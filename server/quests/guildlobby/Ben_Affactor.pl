# Ben Affactor - Philanthropist NPC (Guild Lobby)
# Author: Straps
#
# Accepts platinum donations into a communal pool. A server-wide timer
# distributes the pool to eligible low-level newbies when it reaches
# 10,000pp. Donor names are announced in a world broadcast.
#
# Also accepts item hand-ins: checks if an eligible online newbie can
# use the item (class/level), then parcels it to a random match.

my $MIN_DONATION      = 100;
my $MAX_DONATION      = 50000;
my $CONFIRM_THRESHOLD = 10000;
my $DONOR_COOLDOWN    = 10;       # 10 sec, anti-spam only
my $DONOR_MIN_LEVEL   = 10;

sub EVENT_SPAWN {
    # Only instance 0 (static guildlobby) runs the distribution timer
    if ($instanceid == 0) {
        quest::settimer("philanthropist_dist", plugin::Philanthropist_RandomDelay());
    }
}

sub EVENT_TIMER {
    if ($timer eq "philanthropist_dist") {
        plugin::Philanthropist_RunDistribution();
        quest::stoptimer("philanthropist_dist");
        quest::settimer("philanthropist_dist", plugin::Philanthropist_RandomDelay());
        return;
    }
}

sub EVENT_SAY {
    if ($text =~ /hail/i) {
        my $popup = "<c \"#FFD700\"><b>Ben Affactor - The Philanthropist</b></c><br><br>"
            . "I collect platinum from generous adventurers and distribute it to "
            . "those just starting their journey in Norrath.<br><br>"
            . "When enough has been gathered, I send it out to young adventurers "
            . "who need it most. Their names may be unknown to you, but your "
            . "generosity will not go unnoticed.<br><br>"
            . "<c \"#FFCC00\">Platinum:</c> Tell me how much you'd like to give.<br>"
            . "<c \"#FFCC00\">Items:</c> Hand me any tradeable item and I will parcel it "
            . "to a young adventurer who can use it.";

        $client->Popup2("Ben Affactor - The Philanthropist", $popup, 0, 0, 0, 0);
        plugin::Whisper("Welcome, friend. I gather platinum for those in need. "
            . quest::saylink("donate 100", 1, "Donate 100pp") . " | "
            . quest::saylink("donate 500", 1, "500pp") . " | "
            . quest::saylink("donate 1000", 1, "1,000pp") . " | "
            . quest::saylink("donate 5000", 1, "5,000pp")
            . " -- or say 'give X' for a custom amount. You can also hand me items directly.");

        # GM menu
        if ($client->GetGM()) {
            $client->Message(14, "[GM] "
                . quest::saylink("gm_show_eligible", 1, "Show Eligible") . " | "
                . quest::saylink("gm_force_distribute", 1, "Force Distribute") . " | "
                . quest::saylink("gm_pool_status", 1, "Pool Status") . " | "
                . quest::saylink("gm_clear_pool", 1, "Clear Pool"));
        }
    }
    elsif ($client->GetGM() && $text =~ /^gm_show_eligible$/i) {
        plugin::Philanthropist_ShowEligible($client);
    }
    elsif ($client->GetGM() && $text =~ /^gm_force_distribute$/i) {
        plugin::Philanthropist_ForceDistribute($client);
    }
    elsif ($client->GetGM() && $text =~ /^gm_pool_status$/i) {
        plugin::Philanthropist_PoolStatus($client);
    }
    elsif ($client->GetGM() && $text =~ /^gm_clear_pool$/i) {
        plugin::Philanthropist_ClearPool($client);
    }
    elsif ($text =~ /^donate (\d+)$/i) {
        _process_donation($client, int($1), 0);
    }
    elsif ($text =~ /^give (\d+)$/i) {
        _process_donation($client, int($1), 0);
    }
    elsif ($text =~ /^confirm (\d+)$/i) {
        _process_donation($client, int($1), 1);
    }
}

sub _process_donation {
    my ($client, $amount, $confirmed) = @_;

    # Level gate
    if ($client->GetLevel() < $DONOR_MIN_LEVEL) {
        plugin::Whisper("You must be at least level $DONOR_MIN_LEVEL to donate.");
        return;
    }

    # Range check
    if ($amount < $MIN_DONATION) {
        plugin::Whisper("The minimum donation is ${MIN_DONATION}pp.");
        return;
    }
    if ($amount > $MAX_DONATION) {
        plugin::Whisper("The maximum donation is ${MAX_DONATION}pp.");
        return;
    }

    # Account-wide cooldown
    my $cd_key = "philanthropist_cd_" . $client->AccountID();
    my $last = quest::get_data($cd_key);
    if ($last && (time() - $last) < $DONOR_COOLDOWN) {
        my $remaining = $DONOR_COOLDOWN - (time() - $last);
        my $mins = int($remaining / 60);
        my $secs = $remaining % 60;
        plugin::Whisper("Please wait ${mins}m ${secs}s before donating again.");
        return;
    }

    # Confirmation for large amounts
    if ($amount >= $CONFIRM_THRESHOLD && !$confirmed) {
        plugin::Whisper("You wish to donate ${amount}pp. Say '"
            . quest::saylink("confirm $amount", 1, "confirm $amount")
            . "' to proceed.");
        return;
    }

    # Check funds (amount is in pp, GetCarriedMoney returns copper)
    my $cost_copper = $amount * 1000;
    if ($client->GetCarriedMoney() < $cost_copper) {
        plugin::Whisper("You don't have ${amount}pp on you.");
        return;
    }

    # Deduct
    $client->TakeMoneyFromPP($cost_copper, 1);

    # Insert into pool
    my $dbh = plugin::LoadMysql();
    if ($dbh) {
        my $sth = $dbh->prepare(
            "INSERT INTO philanthropist_pool (donor_char_id, donor_account_id, donor_name, amount) VALUES (?, ?, ?, ?)"
        );
        $sth->execute(
            $client->CharacterID(),
            $client->AccountID(),
            $client->GetCleanName(),
            $amount
        );
        $sth->finish();

        # Set cooldown
        quest::set_data($cd_key, time(), $DONOR_COOLDOWN);

        # Show current pool total
        my ($pool_total) = $dbh->selectrow_array(
            "SELECT COALESCE(SUM(amount), 0) FROM philanthropist_pool WHERE distributed = 0"
        );

        plugin::Whisper("Thank you, " . $client->GetCleanName()
            . ". Your ${amount}pp has been added to the benevolence pool. "
            . "The pool now holds ${pool_total}pp.");
    } else {
        # DB failure - refund
        $client->AddMoneyToPP(0, 0, 0, $amount, 1);
        plugin::Whisper("Something went wrong. Your platinum has been returned.");
    }
}

sub EVENT_ITEM {
    # Accept platinum from direct trade
    # Engine auto-returns unconsumed money, so we only consume (handin) on success
    if ($platinum > 0) {
        if ($client->GetLevel() < $DONOR_MIN_LEVEL) {
            plugin::Whisper("You must be at least level $DONOR_MIN_LEVEL to donate.");
        } elsif ($platinum < $MIN_DONATION) {
            plugin::Whisper("The minimum donation is ${MIN_DONATION}pp. Returning your ${platinum}pp.");
        } elsif ($platinum > $MAX_DONATION) {
            plugin::Whisper("The maximum donation is ${MAX_DONATION}pp. Returning your ${platinum}pp.");
        } else {
            my $dbh = plugin::LoadMysql();
            if ($dbh) {
                # Consume the platinum from the trade so engine doesn't return it
                quest::handin({"platinum" => $platinum});

                my $sth = $dbh->prepare(
                    "INSERT INTO philanthropist_pool (donor_char_id, donor_account_id, donor_name, amount) VALUES (?, ?, ?, ?)"
                );
                $sth->execute($client->CharacterID(), $client->AccountID(), $client->GetCleanName(), $platinum);
                $sth->finish();

                my ($pool_total) = $dbh->selectrow_array(
                    "SELECT COALESCE(SUM(amount), 0) FROM philanthropist_pool WHERE distributed = 0"
                );
                plugin::Whisper("Thank you, " . $client->GetCleanName()
                    . ". Your ${platinum}pp has been added to the benevolence pool. "
                    . "The pool now holds ${pool_total}pp.");
            } else {
                plugin::Whisper("Something went wrong. Your platinum has been returned.");
            }
        }
    }

    # Build per-item attuned map from exported trade-slot variables
    my %attuned;
    $attuned{$item1} = $item1_attuned if $item1;
    $attuned{$item2} = $item2_attuned if $item2;
    $attuned{$item3} = $item3_attuned if $item3;
    $attuned{$item4} = $item4_attuned if $item4;

    # Handle item donations (parcel to eligible newbies or return)
    plugin::Philanthropist_HandleItemDonation($client, \%itemcount, \%attuned);

    plugin::return_items(\%itemcount);
}

1;
