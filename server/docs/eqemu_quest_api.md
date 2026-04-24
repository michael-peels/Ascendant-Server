# EQEmu Quest API Reference

> Source: https://docs.eqemu.dev/ — EverQuest Emulator Documentation
> Also see: [Spire Quest API Explorer](http://spire.akkadius.com/quest-api-explorer)

## Scripting Engines

- **Perl** (2000s) and **Lua** (2013) both supported
- `.lua` takes precedence over `.pl` of the same name
- 1,000+ API methods, 100+ custom events

## Quest Loading Hierarchy (first match wins)

### Global Scripts (run ON TOP of zone scripts — both execute)

| Type | Path |
|------|------|
| NPCs | `quests/global/global_npc.[ext]` |
| Players | `quests/global/global_player.[ext]` |
| Bots | `quests/global/global_bot.[ext]` |
| Mercs | `quests/global/global_merc.[ext]` |

### NPC Scripts

1. `quests/zoneshortname/v[ver]/npc_id.[ext]`
2. `quests/zoneshortname/v[ver]/npc_name.[ext]`
3. `quests/zoneshortname/npc_id.[ext]`
4. `quests/zoneshortname/npc_name.[ext]`
5. `quests/global/npc_id.[ext]`
6. `quests/global/npc_name.[ext]`
7. `quests/zoneshortname/v[ver]/default.[ext]`
8. `quests/zoneshortname/default.[ext]`
9. `quests/global/default.[ext]`

### Player Scripts

1. `quests/zoneshortname/v[ver]/player.[ext]`
2. `quests/zoneshortname/player_v[ver].[ext]`
3. `quests/zoneshortname/player.[ext]`
4. `quests/global/player.[ext]`

### Encounter Scripts

1. `quests/zone/v[ver]/encounters/name.[ext]`
2. `quests/zone/encounters/name.[ext]`
3. `quests/global/encounters/name.[ext]`

### Item Scripts

1. `quests/zone/v[ver]/items/script_NNNNN.[ext]`
2. `quests/zone/items/script_NNNNN.[ext]`
3. `quests/global/items/script_NNNNN.[ext]`
4. `quests/zone/items/default.[ext]`
5. `quests/global/items/default.[ext]`

### Spell Scripts

1. `quests/zone/v[ver]/spells/spell_id.[ext]`
2. `quests/zone/spells/spell_id.[ext]`
3. `quests/global/spells/spell_id.[ext]`
4. `quests/zone/spells/default.[ext]`
5. `quests/global/spells/default.[ext]`

---

## Events Reference

### Default Exports

| Script Type | Perl | Lua |
|------------|------|-----|
| NPC | `$npc`, `$entity_list`, `$x/$y/$z/$h` | `e.self` |
| Player | `$client`, `$entity_list` | `e.self` |
| Item | `$client`, `$questitem` | `e.self`, `e.owner` |
| Encounter | — | `e.name` |

### NPC Events

| Event | Trigger | Key Exports (Perl) |
|-------|---------|-------------------|
| EVENT_AGGRO | Mob aggros client | — |
| EVENT_AGGRO_SAY | Player says while NPC in combat | `$text`, `$langid` |
| EVENT_ATTACK | NPC is attacked | — |
| EVENT_COMBAT | NPC enters/leaves combat | `$combat_state` (0/1); Lua: `e.joined` |
| EVENT_DEATH | NPC dies (before finish) | `$killer_id`, `$killer_damage`, `$killer_spell`, `$charid`, `$mlevel`, `$mname` |
| EVENT_DEATH_COMPLETE | NPC dies (after finish) | `$killer_id`, `$killer_damage`, `$killer_spell`, `$killer_skill` |
| EVENT_DEATH_ZONE | NPC dies (zone controller) | `$killer_id`, `$killer_npc_id` |
| EVENT_HATE_LIST | Hate list changed | `$hate_state`; Lua: `e.joined` |
| EVENT_HP | HP below threshold | `$hpevent`, `$inchpevent` |
| EVENT_ITEM / event_trade | Item/money turned in | `%itemcount`; Lua: `e.trade` |
| EVENT_NPC_SLAY | NPC kills another NPC | `$killed` (NPC Type ID) |
| EVENT_SAY | Player says to targeted NPC | `$text`, `$langid`, `$client`, `$name`, `$ulevel`, `$class`, `$race` |
| EVENT_SIGNAL | Signal received | `$signal`; Lua: `e.signal` |
| EVENT_SLAY | NPC kills a player | — |
| EVENT_SPAWN | NPC spawns | — |
| EVENT_SPAWN_ZONE | NPC spawns (zone controller) | `$spawned_entity_id`, `$spawned_npc_id` |
| EVENT_TIMER | Timer fires | `$timer` (string name); Lua: `e.timer` |
| EVENT_WAYPOINT_ARRIVE | NPC arrives at waypoint | `$wp` (int) |
| EVENT_WAYPOINT_DEPART | NPC departs waypoint | `$wp` (int) |
| EVENT_ENTER | Client enters proximity | — |
| EVENT_EXIT | Client leaves proximity | — |
| EVENT_PROXIMITY_SAY | Client says in proximity | `$text` |
| EVENT_TARGET_CHANGE | Mob changes target | — |
| EVENT_CAST_ON | Spell cast on NPC | `$spell_id` |
| EVENT_SPELL_EFFECT_NPC | Spell lands on NPC | `$caster_id` |
| EVENT_KILLED_MERIT | NPC dies (group that got XP) | `$client`, `$npc` |

### Player Events

| Event | Trigger | Key Exports (Perl) |
|-------|---------|-------------------|
| EVENT_CONNECT | Player connects to world | — |
| EVENT_ENTERZONE | Player enters zone | — |
| EVENT_ZONE | Player leaves zone | `$target_zone_id` |
| EVENT_DISCONNECT | Player disconnects | — |
| EVENT_LEVEL_UP | Player levels up | — |
| EVENT_CAST | Player casts spell | `$spell_id` |
| EVENT_CAST_BEGIN | Player begins casting | `$spell_id` |
| EVENT_CLICKDOOR | Player clicks door | `$doorid`, `$version` |
| EVENT_CLICK_OBJECT | Player clicks object | `$objectid`, `$clicker_id` |
| EVENT_COMMAND | Player uses unhandled # command | `$command`, `$args` |
| EVENT_GM_COMMAND | GM uses any # command | `$message` |
| EVENT_COMBINE_SUCCESS/FAILURE | Tradeskill result | `$recipe_id`, `$recipe_name` |
| EVENT_DUEL_WIN/LOSE | Duel result | — |
| EVENT_EQUIP_ITEM/UNEQUIP_ITEM | Item equip change | — |
| EVENT_FISH_START/SUCCESS/FAILURE | Fishing events | `$fished_item` (success) |
| EVENT_FORAGE_SUCCESS/FAILURE | Foraging events | `$foraged_item` (success) |
| EVENT_GROUP_CHANGE | Group changes | — |
| EVENT_ITEM_CLICK | Item clicked | `$itemid`, `$itemname`, `$slotid`, `$spell_id` |
| EVENT_LOOT | Player loots item | `$looted_id`, `$looted_charges`, `$corpse` |
| EVENT_PLAYER_PICKUP | Player picks up ground item | `$picked_up_id` |
| EVENT_POPUPRESPONSE | Player clicks popup button | `$popupid`; Lua: `e.popup_id` |
| EVENT_RESPAWN | Player respawns | `$option`, `$resurrect` |
| EVENT_TASK_COMPLETE | Task completed | `$task_id`, `$activity_id`, `$donecount` |
| EVENT_TASK_UPDATE | Task updated | `$task_id`, `$activity_id`, `$donecount` |
| EVENT_USE_SKILL | Skill used | `$skill_id`, `$skill_level` |
| EVENT_ENVIRONMENTAL_DAMAGE | Environmental damage | `$env_damage`, `$env_damage_type` |
| EVENT_AUGMENT_ITEM/INSERT/REMOVE | Augment operations | — |
| EVENT_DISCOVER_ITEM | Item discovered | `$itemid` |
| EVENT_DROP_ITEM | Item dropped | `$itemid`, `$quantity` |
| EVENT_DESTROY_ITEM | Item destroyed | — |
| EVENT_FEIGN_DEATH | Player feigns | — |
| EVENT_WEAPON_PROC | Weapon procs | — |
| EVENT_BOT_COMMAND | Player uses ^ command | `$bot_command`, `$args` |

### Spell Events

| Event | Trigger |
|-------|---------|
| EVENT_SPELL_EFFECT_CLIENT | Spell lands on client |
| EVENT_SPELL_EFFECT_NPC | Spell lands on NPC |
| EVENT_SPELL_EFFECT_BUFF_TIC_CLIENT | Spell ticks on client |
| EVENT_SPELL_EFFECT_BUFF_TIC_NPC | Spell ticks on NPC |
| EVENT_SPELL_EFFECT_TRANSLOCATE_COMPLETE | Translocation completes |
| EVENT_SPELL_FADE | Spell fades |
| EVENT_SCALE_CALC | Scaling item recalculation |
| EVENT_ITEM_ENTER_ZONE | Scaling item on zone-in |
| EVENT_ITEM_TICK | Item tick effect |

---

## Global Methods — Perl (`quest::`)

989 methods. Full list: https://docs.eqemu.dev/quest-api/methods/quest/

### Spawning & Despawning
```perl
quest::spawn(npc_type_id, grid_id, unused, x, y, z);
quest::spawn2(npc_type_id, grid_id, unused, x, y, z, heading);
quest::unique_spawn(npc_type_id, grid_id, unused, x, y, z, heading);
quest::depop();                        # despawn current NPC
quest::depop(npc_type_id);
quest::depop_withtimer();
quest::depopall(npc_type_id);
quest::depopzone(bool start_spawn_status);
quest::repopzone();
quest::respawn(npc_type_id, grid_id);
quest::spawn_from_spawn2(uint32 spawn2_id);
quest::enable_spawn2(uint32 spawn2_id);
quest::disable_spawn2(uint32 spawn2_id);
```

### Movement & Teleportation
```perl
quest::movepc(zone_id, x, y, z);
quest::movepc(zone_id, x, y, z, heading);
quest::movegrp(zone_id, x, y, z);
quest::MovePCInstance(zone_id, instance_id, x, y, z, heading);
quest::moveto(x, y, z, h, save_guard);
quest::gmmove(x, y, z);
quest::zone(zone_name);
quest::zonegroup(zone_name);
quest::zoneraid(zone_name);
quest::safemove();
quest::follow(entity_id, distance);
quest::sfollow();                      # stop following
```

### NPC Behavior
```perl
quest::say(message);
quest::say(message, language_id);
quest::shout(message);
quest::shout2(message);               # world-wide
quest::emote(message);
quest::whisper(message);
quest::me(message);
quest::attack(client_name);
quest::attacknpc(npc_entity_id);
quest::SetRunning(bool);
quest::start(waypoint);
quest::stop();
quest::pause(duration_ms);
quest::resume();
quest::FlyMode(gravity_behavior);
quest::doanim(animation_id);
```

### Timers
```perl
quest::settimer(name, seconds);
quest::settimerMS(name, milliseconds);
quest::stoptimer(name);
quest::stopalltimers();
quest::pausetimer(name);
quest::resumetimer(name);
quest::hastimer(name);
quest::ispausedtimer(name);
quest::getremainingtimeMS(name);
```

### Items & Currency
```perl
quest::summonitem(item_id);
quest::summonitem(item_id, charges);
quest::removeitem(item_id, quantity);
quest::countitem(item_id);
quest::collectitems(item_id, remove_item);
quest::addloot(item_id, charges, equip_item);
quest::givecash(copper, silver, gold, platinum);
quest::varlink(item_id);              # create item link string
quest::getitemname(item_id);
quest::getitemstat(item_id, identifier);
quest::saylink(text, silent, link_name);
quest::silent_saylink(text, link_name);
```

### Experience & Leveling
```perl
quest::exp(amount);
quest::level(new_level);
```

### Factions
```perl
quest::faction(faction_id, value, temp);
quest::factionvalue();
quest::rewardfaction(faction_id, value);
```

### Tasks
```perl
quest::assigntask(task_id);
quest::failtask(task_id);
quest::updatetaskactivity(task_id, activity_id, count);
quest::resettaskactivity(task_id, activity_id);
quest::istaskactive(task_id);
quest::istaskcompleted(task_id);
quest::istaskenabled(task_id);
quest::enabletask(array task_ids);
quest::disabletask(array task_ids);
quest::taskselector(array task_ids);
quest::gettaskname(task_id);
quest::gettaskactivitydonecount(task_id, activity_id);
```

### Instances & Expeditions
```perl
quest::CreateInstance(zone_name, version, duration);
quest::DestroyInstance(id);
quest::GetInstanceID(zone_name, version);
quest::AssignToInstance(instance_id);
quest::AssignGroupToInstance(instance_id);
quest::AssignRaidToInstance(instance_id);
quest::RemoveFromInstance(instance_id);
quest::RemoveAllFromInstance(instance_id);
quest::MovePCInstance(zone_id, instance_id, x, y, z, heading);
quest::GetInstanceTimer();
quest::UpdateInstanceTimer(instance_id, duration);
quest::get_expedition();
quest::get_expedition_by_char_id(char_id);
```

### Data Buckets (persistent key-value storage)
```perl
quest::set_data(key, value);
quest::set_data(key, value, expires_at);  # e.g. "3600s", "24h"
quest::get_data(key);
quest::get_data_expires(key);
quest::get_data_remaining(key);
quest::delete_data(key);
```

### Quest Globals (legacy — prefer data buckets)
```perl
quest::setglobal(key, value, options, duration);
quest::delglobal(key);
quest::targlobal(key, value, duration, npc_id, char_id, zone_id);
```

### Signals
```perl
quest::signal(npc_id, wait_ms);
quest::signalwith(npc_id, signal_id, wait_ms);
```

### Proximity
```perl
quest::set_proximity(min_x, max_x, min_y, max_y, min_z, max_z, enable_say);
quest::set_proximity_range(x_range, y_range, z_range, enable_say);
quest::clear_proximity();
quest::enable_proximity_say();
quest::disable_proximity_say();
```

### Messages & UI
```perl
quest::message(color, message);
quest::popup(title, message, popup_id, buttons, duration);
quest::popupbreak();
quest::popupcentermessage(message);
quest::popupcolormessage(color, message);
quest::popupindent();
quest::popuplink(link, message);
quest::popuptable(message);
quest::popuptablerow(message);
quest::popuptablecell(message);
quest::marquee(type, priority, fade_in, fade_out, duration, message);
quest::we(emote_color_id, message);    # world emote
quest::ze(emote_color_id, message);    # zone emote
quest::gmsay(message, color, send_to_world, guild_id, min_status);
quest::discordsend(webhook_name, message);
```

### NPC Appearance
```perl
quest::npcrace(race_id);
quest::npcgender(gender_id);
quest::npctexture(texture_id);
quest::npcsize(size);
quest::wearchange(slot, texture_id, hero_forge_model);
quest::modifynpcstat(key, value);
quest::setanim(npc_type_id, appearance_number);
```

### Player Modification
```perl
quest::playerrace(race_id);
quest::playergender(gender_id);
quest::playertexture(texture_id);
quest::playersize(size);
quest::permarace(race_id);
quest::permagender(gender_id);
quest::permaclass(class_id);
quest::changedeity(deity_id);
quest::surname(last_name);
quest::pvp(mode);
quest::setskill(skill_id, value);
quest::addskill(skill_id, value);
quest::setallskill(value);
quest::setlanguage(lang_id, skill);
quest::scribespells(max_level, min_level);
quest::traindiscs(max_level, min_level);
quest::setstat(stat_id, value);
quest::incstat(stat_id, value);
```

### HP Events
```perl
quest::setnexthpevent(at_mob_percentage);
quest::setnextinchpevent(at_mob_percentage);
quest::sethp(mob_health_percentage);
```

### Zone Control
```perl
quest::rain(weather);
quest::snow(weather);
quest::setsky(new_sky);
quest::settime(hour, min, update_world);
quest::UpdateZoneHeader(key, value);
quest::reloadzonestaticdata();
quest::processmobswhilezoneempty(bool);
quest::spawn_condition(zone_short, condition_id, value);
quest::get_spawn_condition(zone_short, condition_id);
quest::toggle_spawn_event(event_id, enabled, strict, reset);
quest::clearspawntimers();
quest::updatespawntimer(id, new_time);
quest::sethotzone(bool);
quest::ishotzone();
```

### Doors
```perl
quest::forcedooropen(door_id, alt_mode);
quest::forcedoorclose(door_id, alt_mode);
quest::toggledoorstate(door_id);
quest::isdooropen(door_id);
```

### Content Flags & Expansion
```perl
quest::is_content_flag_enabled(flag_name);
quest::set_content_flag(flag_name, enabled);
quest::is_classic_enabled();
quest::is_the_ruins_of_kunark_enabled();
quest::is_the_scars_of_velious_enabled();
quest::is_the_shadows_of_luclin_enabled();
quest::is_the_planes_of_power_enabled();
quest::is_the_legacy_of_ykesha_enabled();
quest::is_lost_dungeons_of_norrath_enabled();
quest::is_gates_of_discord_enabled();
quest::is_omens_of_war_enabled();
# ... continues for all expansions
quest::is_current_expansion_classic(); # ... through all expansions
```

### Rules & Zone Flags
```perl
quest::get_rule(rule_name);
quest::set_rule(rule_name, rule_value);
quest::set_zone_flag(zone_id);
quest::clear_zone_flag(zone_id);
quest::has_zone_flag(zone_id);
```

### Cross-Zone Operations
```perl
# Pattern: quest::crosszone{action}by{target}(target_id, ...)
# Actions: castspell, message, move, signal, setentityvariable, assigntask, etc.
# Targets: charid, clientname, expeditionid, groupid, guildid, raidid
quest::crosszonecastspellbycharid(char_id, spell_id);
quest::crosszonemessageplayerbyname(client_name, type, message);
quest::crosszonemoveplayerbycharid(char_id, zone_short, x, y, z);
quest::crosszonesignalclientbycharid(char_id, signal_id);
quest::crosszonesetentityvariablebycharid(char_id, var_name, var_value);
quest::crosszoneassigntaskbycharid(char_id, task_id);
```

### World-Wide Operations
```perl
quest::worldwidemessage(type, message);
quest::worldwidecastspell(spell_id);
quest::worldwidemove(zone_short);
quest::worldwideassigntask(task_id);
quest::worldwidesignalclient(signal_id);
quest::worldwidesignalnpc(signal_id);
quest::worldwidemarquee(type, priority, fade_in, fade_out, duration, message);
# Most accept optional min_status, max_status filters
```

### Expedition Lockouts
```perl
quest::add_expedition_lockout_all_clients(expedition, event, seconds);
quest::add_expedition_lockout_by_char_id(char_id, expedition, event, seconds);
quest::remove_expedition_lockout_by_char_id(char_id, expedition, event);
quest::remove_all_expedition_lockouts_by_char_id(char_id);
quest::get_expedition_lockout_by_char_id(char_id, expedition, event);
quest::get_expedition_lockouts_by_char_id(char_id);
```

### Lookup Helpers
```perl
quest::GetZoneID(zone);
quest::GetZoneLongName(zone);
quest::GetZoneShortName(zone_id);
quest::getcharidbyname(name);
quest::getcharnamebyid(char_id);
quest::getclassname(class_id);
quest::getracename(race_id);
quest::getdeityname(deity_id);
quest::getfactionname(faction_id);
quest::getguildnamebyid(guild_id);
quest::getspellname(spell_id);
quest::getspell(spell_id);
quest::getspellstat(spell_id, stat, slot);
quest::getnpcnamebyid(npc_id);
quest::getskillname(skill_id);
quest::getlanguagename(lang_id);
quest::getitemname(item_id);
quest::getitemstat(item_id, identifier);
quest::getrecipename(recipe_id);
quest::gettaskname(task_id);
quest::getldonthemename(theme_id);
```

### Utility
```perl
quest::ChooseRandom(option1, option2, ...);
quest::secondstotime(duration);        # "Xh Xm Xs"
quest::timetoseconds(time_string);     # "4d12h" -> seconds
quest::commify(number);                # add commas
quest::debug(message, level);
quest::log(category, message);
quest::write(file, message);
quest::qs_send_query(query);
quest::SendMail(to, from, subject, message);
quest::send_parcel(table_ref);
quest::send_player_handin_event();
quest::GetTimeSeconds();
quest::rename(name);
quest::selfcast(spell_id);
quest::castspell(spell_id, target_id);
quest::save();
quest::rebind(zone_id, x, y, z, heading);
```

---

## Global Methods — Lua (`eq.`)

894 methods. Full list: https://docs.eqemu.dev/quest-api/methods/eq/

### Key Perl-to-Lua Mapping

| Perl | Lua |
|------|-----|
| `quest::spawn2(...)` | `eq.spawn2(...)` |
| `quest::say("text")` | `e.self:Say("text")` |
| `quest::movepc(z, x, y, z)` | `e.other:MovePC(z, x, y, z)` |
| `quest::settimer("n", 30)` | `eq.set_timer("n", 30)` |
| `quest::stoptimer("n")` | `eq.stop_timer("n")` |
| `quest::set_data(k, v)` | `eq.set_data(k, v)` |
| `quest::get_data(k)` | `eq.get_data(k)` |
| `quest::signalwith(id, sig, w)` | `eq.signal(id, sig, w)` |
| `quest::popup(t, m, id)` | `eq.popup(t, m, id)` |
| `quest::set_proximity(...)` | `eq.set_proximity(...)` |
| `quest::saylink(t, s, n)` | `eq.say_link(t, s, n)` |
| `quest::varlink(id)` | `eq.item_link(id)` |
| `quest::we(c, m)` | `eq.world_emote(c, m)` |
| `quest::ze(c, m)` | `eq.zone_emote(c, m)` |
| `quest::set_content_flag(n, b)` | `eq.set_content_flag(n, b)` |
| `$entity_list->...` | `eq.get_entity_list():...` |

### Lua-Only Features
```lua
eq.get_entity_list()
eq.get_initiator()          -- client who triggered event
eq.get_owner()              -- owner (item scripts)
eq.get_quest_item()         -- quest item object
eq.get_zone_id()
eq.get_zone_short_name()
eq.get_zone_long_name()
eq.get_zone_instance_id()
eq.get_zone_instance_version()
eq.get_zone_weather()
eq.get_zone_time()
eq.get_zone_uptime()
eq.clock()                  -- high-res timer
eq.create_npc(table, x, y, z, heading)
eq.add_area(id, type, min_x, max_x, min_y, max_y, min_z, max_z)
eq.remove_area(id)
eq.clear_areas()
eq.modify_npc_stat(stat, value)
eq.whisper(message)
```

---

## Client Methods (`$client->` / `client:`)

566 Perl methods. Full list: https://docs.eqemu.dev/quest-api/methods/client/

### Identity
```perl
$client->AccountID();           $client->AccountName();
$client->CharacterID();         $client->GetName();
$client->GetCleanName();        $client->Admin();
$client->GetGM();               $client->GetClientVersion();
$client->GetClassAbbreviation(); $client->GetClassBitmask();
```

### Stats & Level
```perl
$client->GetLevel();
$client->GetBaseSTR/STA/AGI/DEX/INT/WIS/CHA();
$client->GetClass();            $client->GetRace();
$client->GetDeity();            $client->GetGender();
```

### HP/Mana/Endurance
```perl
$client->GetHP();               $client->GetMaxHP();
$client->GetMana();             $client->GetMaxMana();
$client->GetEndurance();        $client->SetEndurance(int);
```

### Experience
```perl
$client->GetEXP();              $client->GetAAExp();
$client->GetAAPoints();         $client->AddEXP(amount);
$client->AddAAPoints(points);   $client->SetEXP(exp, aaxp);
$client->AddLevelBasedExp(percent, max_level);
$client->CalcEXP(consider_level, ignore_modifiers);
$client->GetEXPModifier();      $client->SetEXPModifier(modifier);
$client->GetAAEXPModifier();    $client->SetAAEXPModifier(modifier);
$client->IsEXPEnabled();        $client->SetEXPEnabled(bool);
```

### Items & Inventory
```perl
$client->CountItem(item_id);
$client->SummonItem(item_id, charges);
$client->RemoveItem(item_id, quantity);
$client->NukeItem(item_id);
$client->GetItemIDAt(slot_id);
$client->GetAugmentIDAt(slot, aug_slot);
$client->DeleteItemInInventory(slot, quantity, update);
$client->AddItem(table_ref);
$client->PushItemOnCursor(inst);
$client->PutItemInInventory(slot, inst);
$client->DropItem(slot_id);
$client->CountAugmentEquippedByID(item_id);
$client->CountItemEquippedByID(item_id);
$client->GetCustomItemData(slot_id, identifier);
$client->SetCustomItemData(slot_id, identifier, value);
$client->SetItemCooldown(item_id, time);
$client->ResetItemCooldown(item_id);
```

### Currency
```perl
$client->GetCarriedMoney();     $client->GetCarriedPlatinum();
$client->GetAllMoney();
$client->AddMoneyToPP(copper, silver, gold, platinum);
$client->AddPlatinum(platinum);
$client->TakeMoneyFromPP(amount, update);
$client->GetAlternateCurrencyValue(currency_id);
$client->AddAlternateCurrencyValue(currency_id, amount);
$client->RemoveAlternateCurrencyValue(currency_id, amount);
$client->CashReward(copper, silver, gold, platinum);
$client->AddCrystals(radiant, ebon);
$client->AddRadiantCrystals(amount);
$client->AddEbonCrystals(amount);
$client->RemoveRadiantCrystals(amount);
$client->RemoveEbonCrystals(amount);
```

### Movement
```perl
$client->MovePC(zone_id, x, y, z, heading);
$client->MovePCInstance(zone_id, inst_id, x, y, z, heading);
$client->MoveZone(zone_short);
$client->MoveZoneGroup(zone_short, x, y, z, heading);
$client->MoveZoneRaid(zone_short, x, y, z, heading);
$client->MoveZoneInstance(inst_id, x, y, z, heading);
$client->MoveZoneInstanceGroup(inst_id, x, y, z, heading);
$client->MoveZoneInstanceRaid(inst_id, x, y, z, heading);
$client->Fling(x, y, z, ignore_los);
$client->Fling(value, x, y, z, ignore_los, clip_walls);
```

### Buffs & Spells
```perl
$client->ApplySpell(spell_id, duration, level, allow_pets, allow_bots);
$client->ApplySpellGroup(spell_id, duration, level);
$client->ApplySpellRaid(spell_id, duration, level);
$client->SetSpellDuration(spell_id, duration, level);
$client->BuffFadeBySpellID(spell_id);
$client->BuffFadeAll();
$client->BuffCount();
$client->HasSpellScribed(spell_id);
$client->MemSpell(spell_id, slot, update);
$client->UnmemSpell(slot, update);
$client->ScribeSpell(spell_id, slot, update);
$client->UnscribeSpell(slot, update);
$client->TrainDisc(spell_id);
$client->FindMemmedSpellBySpellID(spell_id);
$client->FindEmptyMemSlot();
```

### Messages & UI
```perl
$client->Message(color, message);
$client->Popup(title, text, popup_id, negative_id, button_type, duration);
$client->DiaWind(markdown);
$client->DialogueWindow(markdown);
$client->Marquee(type, message, duration);
$client->PlayMP3(file);
$client->QuestReadBook(text, type);
$client->QuestReward(target, copper, silver, gold, platinum, itemid, exp, faction);
```

### Skills
```perl
$client->GetSkill(skill_id);    $client->SetSkill(skill_id, value);
$client->AddSkill(skill_id, value); $client->CanHaveSkill(skill_id);
$client->MaxSkill(skill_id);    $client->GetRawSkill(skill_id);
$client->CheckIncreaseSkill(skill_id, chance_modifier);
$client->SetSkillPoints(points);
```

### AA
```perl
$client->GetAALevel(aa_skill_id);
$client->GrantAlternateAdvancementAbility(aa_id, points);
$client->ResetAlternateAdvancementRank(aa_id);
$client->ResetAA();             $client->RefundAA();
$client->AddAAPoints(points);   $client->RemoveAAPoints(points);
```

### Factions
```perl
$client->GetCharacterFactionLevel(faction_id);
$client->SetFactionLevel2(char_id, faction_id, class, race, deity, value, temp);
$client->RewardFaction(id, amount);
```

### Group & Raid
```perl
$client->GetGroup();            $client->GetRaid();
$client->IsGrouped();           $client->IsRaidGrouped();
```

### Tasks
```perl
$client->AssignTask(task_id, npc_id, enforce_level);
$client->FailTask(task_id);
$client->IsTaskActive(task_id); $client->IsTaskCompleted(task_id);
$client->UpdateTaskActivity(task, activity, count);
$client->HasCompletedTask(task_id);
$client->AreTasksCompleted(task_ids);
$client->EndSharedTask(send_fail);
```

### Expeditions & Lockouts
```perl
$client->CreateExpedition(zone, ver, dur, name, min, max);
$client->CreateExpeditionFromTemplate(dz_template_id);
$client->AddExpeditionLockout(expedition, event, seconds);
$client->AddExpeditionLockoutDuration(expedition, event, seconds);
$client->RemoveExpeditionLockout(expedition, event);
$client->RemoveAllExpeditionLockouts();
$client->HasExpeditionLockout(expedition, event);
$client->GetExpeditionLockouts();
$client->AssignToInstance(instance_id);
```

### Bind & Zone Flags
```perl
$client->SetBindPoint(zone, inst, x, y, z, heading);
$client->GetBindZoneID(index);  $client->GetBindX/Y/Z(index);
$client->HasZoneFlag(zone_id);  $client->SetZoneFlag(zone_id);
$client->ClearZoneFlag(zone_id);
$client->SetPEQZoneFlag(zone_id); $client->ClearPEQZoneFlag(zone_id);
$client->CanEnterZone(zone_short, instance_version);
```

### Compass
```perl
$client->MarkCompassLoc(x, y, z);
$client->ClearCompassMark();
```

### Misc
```perl
$client->Save();                $client->Disconnect();
$client->WorldKick();           $client->GMKill();
$client->SetGM(bool);           $client->SetPVP(bool);
$client->BreakInvis();          $client->Escape();
$client->Duck();                $client->Freeze();
$client->UnFreeze();
$client->SetInvulnerableEnvironmentDamage(bool);
$client->SetEnvironmentDamageModifier(modifier);
$client->GetAccountAge();       $client->Connected();
$client->InZone();              $client->AutoSplitEnabled();
$client->GetAggroCount();       $client->GetCorpseCount();
$client->GetAnon();             $client->GetAFK();
$client->ChangeLastName(last_name);
$client->SetDeity(deity_id);
$client->SetStartZone(zone_id, x, y, z, heading);
$client->ReloadDataBuckets();
$client->SetHideMe(bool);
$client->SetClientMaxLevel(max_level);
$client->GetClientMaxLevel();
$client->SetConsumption(hunger, thirst);
$client->SetHunger(hunger);     $client->SetThirst(thirst);
$client->SetTitleSuffix(suffix, save);
```

---

## NPC Methods (`$npc->` / `npc:`)

147 Perl / 157 Lua methods. Full list: https://docs.eqemu.dev/quest-api/methods/npc/

### Loot & Items
```perl
$npc->AddItem(item_id, charges, equip, aug1..aug6);
$npc->RemoveItem(item_id, quantity, slot_id);
$npc->CountItem(item_id);      $npc->HasItem(item_id);
$npc->CountLoot();              $npc->GetLootList();
$npc->AddLootTable(loottable_id);
$npc->GetLoottableID();
$npc->ClearItemList();          # Lua only
```

### Combat Stats
```perl
$npc->GetMaxDMG();              $npc->GetMinDMG();
$npc->GetMaxDamage(target_level);
$npc->GetAttackDelay();         # returns npc_types.attack_delay * 100
$npc->GetAttackSpeed();
$npc->GetAccuracyRating();     $npc->GetAvoidanceRating();
$npc->GetSlowMitigation();
$npc->GetHealScale();          $npc->GetSpellScale();
$npc->GetSpellFocusDMG();      $npc->GetSpellFocusHeal();
$npc->GetNPCStat(stat);        $npc->GetCombatState();
```

### Stat Modification
```perl
$npc->ModifyNPCStat(stat, value);
$npc->SetSpellFocusDMG(value);  $npc->SetSpellFocusHeal(value);
$npc->ScaleNPC(level, override_special_abilities);
$npc->RecalculateSkills();      $npc->ReloadSpells();
```

### Procs
```perl
$npc->AddMeleeProc(spell_id, chance);
$npc->AddDefensiveProc(spell_id, chance);
$npc->AddRangedProc(spell_id, chance);
$npc->RemoveMeleeProc(spell_id);
$npc->RemoveDefensiveProc(spell_id);
$npc->RemoveRangedProc(spell_id);
```

### AI Spell Effects
```perl
$npc->AddAISpellEffect(effect_id, base, limit, max);
$npc->RemoveAISpellEffect(effect_id);
$npc->HasAISpellEffect(effect_id);
```

### Faction & Hate
```perl
$npc->GetNPCFactionID();        $npc->SetNPCFactionID(faction_id);
$npc->GetPrimaryFaction();
$npc->CheckNPCFactionAlly(faction_id);
$npc->GetNPCHate(mob);          $npc->GetNPCAggro();
$npc->SetNPCAggro(bool);
$npc->IsOnHatelist(mob);        $npc->RemoveFromHateList(mob);
```

### Movement & Pathing
```perl
$npc->GetGrid();                $npc->SetGrid(grid);
$npc->AssignWaypoints(grid_id);
$npc->CalculateNewWaypoint();   $npc->UpdateWaypoint(wp);
$npc->GetMaxWp();               $npc->GetWaypointMax();
$npc->GetGuardPointX/Y/Z();
$npc->NextGuardPosition();      $npc->IsGuarding();
$npc->MoveTo(x, y, z, h, save);
$npc->PauseWandering(pause_time);
$npc->ResumeWandering();        $npc->StopWandering();
$npc->SetSaveWaypoint(wp);      $npc->SetWaypointPause();
$npc->SaveGuardSpot(x, y, z, h); $npc->SaveGuardSpot(clear);
$npc->AI_SetRoambox(dist, max_x, min_x, max_y, min_y, max_delay, min_delay);
$npc->SetSimpleRoamBox(size, move_dist, move_delay);
```

### Spawn Info
```perl
$npc->GetSpawnPointX/Y/Z/H();
$npc->GetSpawnPointID();        $npc->GetSpawnKillCount();
```

### Merchant
```perl
$npc->MerchantOpenShop();       $npc->MerchantCloseShop();
$npc->GetKeepsSoldItems();      $npc->SetKeepsSoldItems(bool);
```

### Pet/Swarm
```perl
$npc->GetPetSpellID();          $npc->SetPetSpellID(amount);
$npc->GetSwarmOwner();          $npc->GetSwarmTarget();
$npc->SetSwarmTarget(target_id);
$npc->StartSwarmTimer(duration);
```

### Misc
```perl
$npc->ChangeLastName(name);     $npc->ClearLastName();
$npc->GetPrimSkill();           $npc->SetPrimSkill(skill);
$npc->GetSecSkill();            $npc->SetSecSkill(skill);
$npc->GetCopper/Silver/Gold/Platinum();
$npc->SetCopper/Silver/Gold/Platinum(amt);
$npc->GetSp2();                 $npc->SetSp2(spawn_group_id);
$npc->GetScore();
$npc->SignalNPC(signal_id);
$npc->SendPayload(payload_id, payload_value);
$npc->IsAnimal();               $npc->IsRaidTarget();
$npc->IsRareSpawn();            $npc->IsTaunting();
$npc->SetTaunting(bool);
$npc->HasSpecialAbilities();
$npc->DescribeSpecialAbilities(client);
$npc->DisplayWaypointInfo(client);
$npc->DoClassAttacks(target);   $npc->PickPocket(thief);
```

---

## Mob Methods (parent of Client and NPC)

All Mob methods available on both `$client` and `$npc`. Full list: https://docs.eqemu.dev/quest-api/methods/mob/

### Identity & Position
```perl
$mob->GetName();                $mob->GetCleanName();
$mob->GetID();                  $mob->GetNPCTypeID();
$mob->GetLevel();               $mob->GetClass();
$mob->GetRace();                $mob->GetGender();
$mob->GetDeity();               $mob->GetBodyType();
$mob->GetX(); $mob->GetY(); $mob->GetZ(); $mob->GetHeading();
$mob->GetSize();
```

### Entity Variables
```perl
$mob->GetEntityVariable(name);
$mob->SetEntityVariable(name, value);
$mob->EntityVariableExists(name);
```

### HP & Mana
```perl
$mob->GetHP();                  $mob->GetMaxHP();
$mob->GetHPRatio();             $mob->SetHP(hp);
$mob->GetMana();                $mob->GetMaxMana();
$mob->SetMana(mana);            $mob->Heal();
$mob->Kill();
$mob->Damage(from, damage, spell_id, skill);
```

### Stats
```perl
$mob->GetSTR/STA/AGI/DEX/INT/WIS/CHA();
$mob->GetMR/FR/CR/PR/DR();
$mob->GetAC();                  $mob->GetATK();
$mob->GetHaste();
```

### Combat
```perl
$mob->Attack(other);            $mob->IsEngaged();
$mob->GetTarget();              $mob->SetTarget(target);
$mob->AddToHateList(other, hate, damage);
$mob->WipeHateList();           $mob->GetHateList();
$mob->GetHateTop();             $mob->GetHateRandom();
$mob->GetHateAmount(other);
```

### Buffs
```perl
$mob->BuffCount();              $mob->FindBuff(spell_id);
$mob->BuffFadeBySpellID(spell_id);
$mob->BuffFadeAll();
$mob->SpellFinished(spell_id, target);
$mob->CastSpell(spell_id, target_id, slot, cast_time);
```

### Pet
```perl
$mob->GetPet();                 $mob->GetPetID();
$mob->GetOwner();               $mob->GetOwnerID();
$mob->HasPet();                 $mob->SetPet(pet);
```

### Type Checks & Casting
```perl
$mob->IsClient();               $mob->IsNPC();
$mob->IsPet();                  $mob->IsCorpse();
$mob->IsMerc();                 $mob->IsBot();
$mob->CastToClient();           $mob->CastToNPC();
$mob->CastToCorpse();
```

### Appearance
```perl
$mob->SendIllusionPacket(table);
$mob->SetRace(race);            $mob->SetGender(gender);
$mob->SetTexture(texture);      $mob->SetSize(size);
$mob->GMMove(x, y, z, heading, send_update);
$mob->Teleport(x, y, z, heading);
```

### Status Checks
```perl
$mob->Charmed();                $mob->IsFeared();
$mob->IsStunned();              $mob->IsSilenced();
$mob->IsRooted();               $mob->IsMezzed();
```

### Misc
```perl
$mob->Say(message);             $mob->Shout(message);
$mob->Emote(message);           $mob->Message(type, message);
$mob->Depop(start_timer);
$mob->GetSpecialAbility(ability);
$mob->SetSpecialAbility(ability, value);
$mob->CalculateDistance(x, y, z);
```

---

## EntityList Methods

Access: `$entity_list->` (Perl) or `eq.get_entity_list():` (Lua)

```perl
$entity_list->GetClientByName(name);
$entity_list->GetClientByID(id);
$entity_list->GetClientByCharID(char_id);
$entity_list->GetClientByAccID(account_id);
$entity_list->GetMobByID(id);
$entity_list->GetMobByNpcTypeID(npc_type_id);
$entity_list->GetNPCByID(id);
$entity_list->GetNPCByNPCTypeID(npc_type_id);
$entity_list->GetNPCBySpawnID(spawn_id);
$entity_list->GetDoorsByDBID(db_id);
$entity_list->GetDoorsByDoorID(door_id);
$entity_list->GetRandomClient(x, y, z, distance);
$entity_list->GetClientList();
$entity_list->GetNPCList();
$entity_list->GetMobList();
$entity_list->GetCorpseList();
$entity_list->SignalAllClients(signal_id);
$entity_list->ChannelMessage(from, channel, language, message);
$entity_list->MessageClose(sender, skip_sender, distance, type, message);
$entity_list->RemoveFromHateLists(mob, set_to_one);
```

---

## Expedition Methods

```perl
$expedition->AddLockout(event_name, seconds);
$expedition->AddLockoutDuration(event_name, seconds);
$expedition->AddReplayLockout(seconds);
$expedition->GetDynamicZoneID();
$expedition->GetID();           $expedition->GetInstanceID();
$expedition->GetLeaderName();   $expedition->GetLockouts();
$expedition->GetMemberCount();  $expedition->GetMembers();
$expedition->GetName();         $expedition->GetUUID();
$expedition->HasLockout(event); $expedition->HasMember(char_id);
$expedition->IsLocked();
$expedition->RemoveCompass();   $expedition->RemoveLockout(event);
$expedition->SetCompass(zone_id, x, y, z);
$expedition->SetLocked(locked, lock_msg, color);
$expedition->SetLootEventByNPCTypeID(npc_type, event);
$expedition->SetLootEventBySpawnID(spawn_id, event);
$expedition->SetReplayLockoutOnMemberJoin(bool);
$expedition->SetSafeReturn(zone_id, x, y, z, h);
$expedition->SetSecondsRemaining(seconds);
$expedition->SetSwitchID(dz_switch_id);
$expedition->SetZoneInLocation(x, y, z, h);
```

---

## Common Patterns

### Perl NPC Say Handler
```perl
sub EVENT_SAY {
    if ($text =~ /hail/i) {
        quest::say("Hello, $name! Would you like to [hear more]?");
    } elsif ($text =~ /hear more/i) {
        quest::say("Here is more info.");
    }
}
```

### Lua NPC Say Handler
```lua
function event_say(e)
    if (e.message:findi("hail")) then
        e.self:Say("Hello, " .. e.other:GetCleanName() .. "!")
    elseif (e.message:findi("hear more")) then
        e.self:Say("Here is more info.")
    end
end
```

### Perl Item Hand-In
```perl
sub EVENT_ITEM {
    if (plugin::check_handin(\%itemcount, 1001 => 1)) {
        quest::say("Thank you!");
        quest::summonitem(2001);
        quest::exp(1000);
    }
    plugin::return_items(\%itemcount);
}
```

### Lua Item Hand-In
```lua
function event_trade(e)
    local item_lib = require("items")
    if (item_lib.check_turn_in(e.self, e.trade, {item1 = 1001})) then
        e.self:Say("Thank you!")
        e.other:SummonItem(2001)
        e.other:AddEXP(1000)
    end
    item_lib.return_items(e.self, e.other, e.trade)
end
```

### Timer Pattern
```perl
sub EVENT_SPAWN { quest::settimer("check", 60); }
sub EVENT_TIMER {
    if ($timer eq "check") {
        quest::stoptimer("check");
        # do work
    }
}
```

### Proximity + Enter/Exit
```perl
sub EVENT_SPAWN {
    quest::set_proximity($x-50, $x+50, $y-50, $y+50, $z-50, $z+50);
}
sub EVENT_ENTER { quest::say("Welcome!"); }
sub EVENT_EXIT  { quest::say("Farewell!"); }
```

### Data Bucket Usage
```perl
my $key = $client->CharacterID() . "-quest-flag";
quest::set_data($key, "1");                    # permanent
quest::set_data($key, "1", "3600s");           # expires in 1 hour
my $val = quest::get_data($key);
quest::delete_data($key);
```

### Popup with Response
```perl
sub EVENT_ENTER {
    quest::popup("Teleport", "Go to Plane of Hate?", 666, 1, 0);
}
sub EVENT_POPUPRESPONSE {
    if ($popupid == 666) { quest::movepc(186, -393, 656, 3); }
}
```

---

## Message Color IDs

| ID | Color |
|----|-------|
| 0 | White (default) |
| 1 | Gray |
| 2 | Dark green |
| 4 | Blue |
| 5 | Light blue |
| 6 | Purple |
| 7 | Light gray |
| 10 | White (bright) |
| 13 | Red |
| 14 | Green |
| 15 | Yellow/Orange |
| 18 | Cyan |
| 256+ | Extended colors |

---

## Additional Object Types

Full docs at https://docs.eqemu.dev/quest-api/methods/:

- **Group** — Group manipulation
- **Raid** — Raid manipulation
- **Corpse** — Corpse manipulation
- **Door/Doors** — Door objects
- **Object** — World objects
- **Item/ItemInst** — Item data/instances
- **Inventory** — Inventory manipulation
- **Spell/Buff** — Spell/buff data
- **Packet** — Network packets

---

## ModifyNPCStat Keys

Valid keys for `$npc->ModifyNPCStat(key, value)`:

`ac`, `accuracy`, `aggro`, `agi`, `assist`, `atk`, `attack_count`, `attack_delay`, `attack_speed`, `avoidance`, `cha`, `cr`, `dex`, `dr`, `fr`, `healscale`, `heroic_strikethrough`, `hp_regen`, `hp_regen_per_second`, `_int`, `keeps_sold_items`, `level`, `loottable_id`, `mana_regen`, `max_hit`, `max_hp`, `min_hit`, `mr`, `npc_spells_effects_id`, `npc_spells_id`, `phr`, `pr`, `runspeed`, `see_hide`, `see_improved_hide`, `see_invis`, `see_invis_undead`, `slow_mitigation`, `special_abilities`, `special_attacks`, `spellscale`, `sta`, `str`, `trackable`, `wis`

- `spellscale` and `healscale` default to 100 (100%)
- `attack_delay` takes raw npc_types value (e.g., 28, not 2800)
- `_int` is used for intelligence (avoids Perl keyword conflict)
