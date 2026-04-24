# EQEmu General Knowledge Reference

> Source: https://docs.eqemu.dev/ — EverQuest Emulator Documentation

---

## Architecture Overview

EQEmu is an open-source EverQuest server emulator written in C++.

- **World Server** — Central authority; manages zones, groups, raids, guilds, chat, login
- **Zone Servers** — One process per active zone instance; handles combat, NPCs, quests, movement
- **Login Server** — Authenticates clients; can be local or shared (loginserver.eqemulator.net)
- **UCS** — Universal Chat Server (handles /tell, channels)
- **QueryServ** — Handles logging queries asynchronously
- **SharedMemory** — Pre-loads spells, items, base data into shared memory for zone processes
- **Database** — MySQL/MariaDB stores all persistent game data
- **Quest Scripts** — Perl (.pl) and Lua (.lua) scripts define NPC behavior, events, custom systems

### AkkStack Docker Architecture
- All services run in Docker containers
- Container mount: `/home/eqemu/server/` inside container = host path (e.g., `/opt/akk-stack/server/`)
- Quest scripts must use container paths in file operations (e.g., `/home/eqemu/server/logs/`)
- Spire web admin tool manages server via HTTP API

---

## Expansion List

| ID | Short Name | Expansion |
|----|-----------|-----------|
| 0 | classic | Classic EverQuest |
| 1 | kunark | The Ruins of Kunark |
| 2 | velious | The Scars of Velious |
| 3 | luclin | The Shadows of Luclin |
| 4 | pop | The Planes of Power |
| 5 | ykesha | The Legacy of Ykesha |
| 6 | ldon | Lost Dungeons of Norrath |
| 7 | god | Gates of Discord |
| 8 | oow | Omens of War |
| 9 | don | Dragons of Norrath |
| 10 | dodh | Depths of Darkhollow |
| 11 | por | Prophecy of Ro |
| 12 | tss | The Serpent's Spine |
| 13 | tbs | The Buried Sea |
| 14 | sof | Secrets of Faydwer |
| 15 | sod | Seeds of Destruction |
| 16 | uf | Underfoot |
| 17 | hot | House of Thule |
| 18 | voa | Veil of Alaris |
| 19 | rof | Rain of Fear |
| 20 | cotf | Call of the Forsaken |
| 21 | tds | The Darkened Sea |
| 22 | tbm | The Broken Mirror |
| 23 | eok | Empires of Kunark |
| 24 | ros | Ring of Scale |
| 25 | tbl | The Burning Lands |
| 26 | tov | Torment of Velious |

---

## Class IDs

| ID | Name | Short |
|----|------|-------|
| 1 | Warrior | WAR |
| 2 | Cleric | CLR |
| 3 | Paladin | PAL |
| 4 | Ranger | RNG |
| 5 | Shadow Knight | SHD |
| 6 | Druid | DRU |
| 7 | Monk | MNK |
| 8 | Bard | BRD |
| 9 | Rogue | ROG |
| 10 | Shaman | SHM |
| 11 | Necromancer | NEC |
| 12 | Wizard | WIZ |
| 13 | Magician | MAG |
| 14 | Enchanter | ENC |
| 15 | Beastlord | BST |
| 16 | Berserker | BER |

### Class Bitmask Values
Used in item `classes` field. Sum of applicable values:
- WAR=1, CLR=2, PAL=4, RNG=8, SHD=16, DRU=32, MNK=64, BRD=128
- ROG=256, SHM=512, NEC=1024, WIZ=2048, MAG=4096, ENC=8192
- BST=16384, BER=32768
- All classes = 65535

---

## Race IDs (Playable)

| ID | Race |
|----|------|
| 1 | Human |
| 2 | Barbarian |
| 3 | Erudite |
| 4 | Wood Elf |
| 5 | High Elf |
| 6 | Dark Elf |
| 7 | Half Elf |
| 8 | Dwarf |
| 9 | Troll |
| 10 | Ogre |
| 11 | Halfling |
| 12 | Gnome |
| 13 | Iksar |
| 14 | Vah Shir |
| 15 | Froglok |
| 16 | Drakkin |

---

## Deity IDs

| ID | Deity |
|----|-------|
| 140 | Agnostic |
| 201 | Bertoxxulous |
| 202 | Brell Serilis |
| 203 | Cazic-Thule |
| 204 | Erollisi Marr |
| 205 | Bristlebane |
| 206 | Innoruuk |
| 207 | Karana |
| 208 | Mithaniel Marr |
| 209 | Prexus |
| 210 | Quellious |
| 211 | Rallos Zek |
| 212 | Rodcet Nife |
| 213 | Solusek Ro |
| 214 | The Tribunal |
| 215 | Tunare |
| 216 | Veeshan |

---

## Skill IDs

| ID | Skill |
|----|-------|
| 0 | 1H Blunt |
| 1 | 1H Slashing |
| 2 | 2H Blunt |
| 3 | 2H Slashing |
| 4 | Abjuration |
| 5 | Alteration |
| 6 | Apply Poison |
| 7 | Archery |
| 8 | Backstab |
| 9 | Bind Wound |
| 10 | Bash |
| 11 | Block |
| 12 | Brass Instruments |
| 13 | Channeling |
| 14 | Conjuration |
| 15 | Defense |
| 16 | Disarm |
| 17 | Disarm Traps |
| 18 | Divination |
| 19 | Dodge |
| 20 | Double Attack |
| 21 | Dragon Punch / Tail Rake |
| 22 | Dual Wield |
| 23 | Eagle Strike |
| 24 | Evocation |
| 25 | Feign Death |
| 26 | Flying Kick |
| 27 | Forage |
| 28 | Hand to Hand |
| 29 | Hide |
| 30 | Kick |
| 31 | Meditate |
| 32 | Mend |
| 33 | Offense |
| 34 | Parry |
| 35 | Pick Lock |
| 36 | Piercing |
| 37 | Riposte |
| 38 | Round Kick |
| 39 | Safe Fall |
| 40 | Sense Heading |
| 41 | Singing |
| 42 | Sneak |
| 43 | Specialize Abjuration |
| 44 | Specialize Alteration |
| 45 | Specialize Conjuration |
| 46 | Specialize Divination |
| 47 | Specialize Evocation |
| 48 | Pick Pockets |
| 49 | Stringed Instruments |
| 50 | Swimming |
| 51 | Throwing |
| 52 | Tiger Claw |
| 53 | Tracking |
| 54 | Wind Instruments |
| 55 | Fishing |
| 56 | Make Poison |
| 57 | Tinkering |
| 58 | Research |
| 59 | Alchemy |
| 60 | Baking |
| 61 | Tailoring |
| 62 | Sense Traps |
| 63 | Blacksmithing |
| 64 | Fletching |
| 65 | Brewing |
| 66 | Alcohol Tolerance |
| 67 | Begging |
| 68 | Jewelry Making |
| 69 | Pottery |
| 70 | Percussion Instruments |
| 71 | Intimidation |
| 72 | Berserking |
| 73 | Taunt |
| 74 | Frenzy |
| 75 | Remove Traps |
| 76 | Triple Attack |
| 77 | 2H Piercing |

---

## Inventory Slot IDs

| ID | Slot |
|----|------|
| 0 | Charm |
| 1 | Left Ear |
| 2 | Head |
| 3 | Face |
| 4 | Right Ear |
| 5 | Neck |
| 6 | Shoulders |
| 7 | Arms |
| 8 | Back |
| 9 | Left Wrist |
| 10 | Right Wrist |
| 11 | Range |
| 12 | Hands |
| 13 | Primary |
| 14 | Secondary |
| 15 | Left Ring |
| 16 | Right Ring |
| 17 | Chest |
| 18 | Legs |
| 19 | Feet |
| 20 | Waist |
| 21 | Power Source |
| 22 | Ammo |
| 23-30 | General Inventory (bags) |
| 251-340 | Bag slots (sub-slots) |
| 2000-2023 | Bank slots |
| 2500-2549 | Shared bank |
| 9999 | Cursor |

---

## Data Storage Systems

### Data Buckets (Recommended)
Key-value storage with optional expiry. Preferred over quest globals.

```perl
quest::set_data("key", "value");              # permanent
quest::set_data("key", "value", "3600s");     # expires in 1 hour
quest::set_data("key", "value", "24h");       # expires in 24 hours
quest::set_data("key", "value", "7d");        # expires in 7 days
my $val = quest::get_data("key");
quest::delete_data("key");
```

- Stored in `data_buckets` table
- Keys are arbitrary strings; convention: `charID-flagname` or `system-key`
- Expiry formats: `Ns` (seconds), `Nh` (hours), `Nd` (days)

### Entity Variables (Per-Entity, Non-Persistent)
Stored in memory on the entity. Lost on zone/despawn.

```perl
$mob->SetEntityVariable("key", "value");
my $val = $mob->GetEntityVariable("key");
$mob->EntityVariableExists("key");
```

### Quest Globals (Legacy)
Stored in `quest_globals` table. Use data buckets instead for new code.

```perl
quest::setglobal("key", "value", options, "duration");
# Options: 0=char, 1=group, 2=raid, 3=world, 5=npc, 6=zone, 7=all
# Duration: "F"=forever, "S5"=5s, "M5"=5m, "H5"=5h, "D5"=5d, "Y5"=5y
```

---

## Content Flags

Content flags gate spawns, objects, and merchant lists (NOT zone entry).

```perl
quest::is_content_flag_enabled("flag_name");  # check
quest::set_content_flag("flag_name", 1);      # enable
quest::set_content_flag("flag_name", 0);      # disable
```

- Stored in `content_flags` table: `flag_name`, `enabled`, `notes`
- Referenced in `spawn2.content_flags`, `doors.content_flags`, `merchantlist.content_flags`
- Multiple flags in a column use `&` (AND) and pipe (OR)
- Zone entry is gated by `zone.min_status` and `zone.expansion`, NOT content flags

---

## Zone Entry Gating

Three layers control zone access:
1. **`zone.expansion`** — Player can't enter if server expansion setting is lower
2. **`zone.min_status`** — Account status must be >= this value
3. **Zone flags** — Per-character flags checked via `$client->HasZoneFlag(zone_id)`

---

## NPC Special Abilities

Set in `npc_types.special_abilities` or via `$npc->SetSpecialAbility()`. Format: comma-separated `ability_id,value` pairs joined by `^`.

Example: `1,1^2,1^6,1^13,1^14,1^15,1^16,1^17,1^21,1^35,1`

| ID | Ability | Description |
|----|---------|-------------|
| 1 | Summon | NPC summons players |
| 2 | Enrage | Riposte all attacks at low HP |
| 3 | Rampage | Extra attacks on random nearby targets |
| 4 | Area Rampage | AE rampage |
| 5 | Flurry | Extra attacks on current target |
| 6 | Triple Attack | NPC can triple attack |
| 7 | Dual Wield | NPC can dual wield |
| 8 | Bane Attack | Hits through invulnerability |
| 9 | Magical Attack | Melee counts as magic |
| 10 | Ranged Attack | NPC uses ranged attacks |
| 11 | Unslowable | Immune to slow effects |
| 12 | Unmezable | Immune to mesmerize |
| 13 | Uncharmable | Immune to charm |
| 14 | Unstunable | Immune to stuns |
| 15 | Unsnareable | Immune to snare/root |
| 16 | Unfearable | Immune to fear |
| 17 | Immune to Dispell | Buffs can't be dispelled |
| 18 | Immune to Melee | Takes no melee damage |
| 19 | Immune to Magic | Takes no magic damage |
| 20 | Immune to Fleeing | Won't flee at low HP |
| 21 | Immune to Non-Bane | Only bane weapons work |
| 22 | Immune to Non-Magic | Only magic weapons work |
| 23 | Will Not Aggro | Won't auto-aggro |
| 24 | Immune to Aggro | Can't be added to hate list |
| 25 | Resist Ranged Spells | Immune to ranged spells |
| 26 | See Through Feign Death | Sees through FD |
| 27 | Immune to Taunt | Can't be taunted |
| 28 | Tunnel Vision | Reduced aggro radius in combat |
| 29 | No Buffheal Friend | Won't heal/buff allies |
| 30 | Perfect Accuracy | Never misses |
| 31 | Immune to Slow | Additional slow immunity |
| 32 | AE Melee | Damage all nearby with melee |
| 33 | Proximity Aggro | Aggros based on proximity |
| 34 | Counter Avoid | Bypass avoidance |
| 35 | Immune to Pacify | Can't be pacified |
| 36 | Leash | Returns to spawn if too far |
| 37 | Tethered | Hard distance limit |
| 38 | Destructible Object | Is a destructible object |
| 39 | No Harm from Client | Takes no player damage |
| 40 | Always Flee | Always flees |
| 41 | Flee Percentage | Custom flee HP % |

---

## Body Types

| ID | Type |
|----|------|
| 1 | Humanoid |
| 2 | Lycanthrope |
| 3 | Undead |
| 4 | Giant |
| 5 | Construct |
| 6 | Extraplanar |
| 7 | Magical |
| 8 | Summoned Undead |
| 9 | Raid Giant |
| 10 | No Target |
| 11 | Vampire |
| 12 | Atenha Ra |
| 19 | Extra Planar 2 |
| 20 | Magical 2 |
| 21 | Undead 2 |
| 23 | Extra Planar 3 |
| 24 | Dragon |
| 25 | Summoned |
| 26 | Summoned 2 |
| 27 | Plant |
| 28 | Dragon 2 |
| 29 | Velious Dragon |
| 30 | Muramite |
| 31 | No Target 2 |
| 32 | Dragon 3 |
| 33 | Swarm Pet |
| 34 | Monster Summoning |
| 60 | Untargetable |
| 63 | Trap |
| 65 | Timer |
| 66 | Trigger |
| 67 | Unkillable |

---

## LDON Theme IDs

| ID | Theme |
|----|-------|
| 1 | Guk (Grobb) |
| 2 | Miragul's (Everfrost) |
| 3 | Mistmoore (Butcherblock) |
| 4 | Rujarkian Hills (South Ro) |
| 5 | Takish-Hiz (North Ro) |

---

## Spell Effect IDs (Common)

| ID | Effect |
|----|--------|
| 0 | Current HP |
| 1 | AC |
| 2 | ATK |
| 3 | Movement Speed |
| 4 | STR |
| 5 | DEX |
| 6 | AGI |
| 7 | STA |
| 8 | INT |
| 9 | WIS |
| 10 | CHA |
| 11 | Attack Speed (Haste) |
| 12 | Invisibility |
| 14 | Levitate |
| 15 | Fire Resist |
| 16 | Cold Resist |
| 17 | Poison Resist |
| 18 | Disease Resist |
| 19 | Magic Resist |
| 21 | Stun |
| 22 | Charm |
| 23 | Fear |
| 24 | Stamina/Fatigue |
| 25 | Bind Affinity |
| 26 | Gate |
| 27 | Dispel Magic |
| 28 | Invisible vs Undead |
| 31 | Mesmerize |
| 32 | Summon Item |
| 33 | Summon Pet |
| 35 | Disease Counter |
| 36 | Poison Counter |
| 46 | Fire Damage |
| 47 | Cold Damage |
| 48 | Poison Damage |
| 49 | Disease Damage |
| 69 | Max HP |
| 79 | Current HP (Heal Over Time) |
| 85 | Add Spell Proc |
| 86 | Reaction Radius |
| 87 | Magnification (spell focus) |
| 100 | HP when Cast (Lifetap) |
| 101 | Stacking: Block |
| 116 | Illusion |
| 119 | Feign Death |
| 120 | Voice Graft |
| 121 | Sentinel |
| 123 | Summon BST Pet |
| 124 | Maximum Mana |
| 125 | Bane Damage |
| 127 | Spell Damage Shield |
| 134 | Limit: Max Level |
| 135 | Limit: Resist Type |
| 136 | Limit: Target Type |
| 137 | Limit: Effect |
| 138 | Limit: Spell Type |
| 139 | Limit: Spell |
| 140 | Limit: Min Duration |
| 141 | Limit: Instant Only |
| 142 | Limit: Min Level |
| 143 | Limit: Min Cast Time |
| 144 | Limit: Max Cast Time |
| 148 | Stacking: Overwrite |
| 154 | Percent Heal |
| 159 | Illusion: Copy |
| 167 | Pet Power Increase |
| 169 | Critical Heal Chance |
| 170 | Critical Nuke Chance |
| 171 | Crippling Blow Chance |
| 172 | Evasion |
| 173 | Riposte Chance |
| 174 | Dodge Chance |
| 175 | Parry Chance |
| 176 | Dual Wield Chance |
| 177 | Double Attack Chance |
| 185 | Spell Damage |
| 186 | Heal Amount |
| 188 | Reduce Mana Cost |
| 189 | Reduce Spell Hate |
| 200 | Hate Override |
| 212 | Add Defensive Proc |
| 214 | Triple Attack Chance |
| 220 | Spell Haste |
| 254 | Spell Damage Amount |
| 273 | Backstab from Front |
| 294 | Critical Melee Damage Mod |
| 302 | Spell Damage Mod |
| 303 | Heal Mod |
| 330 | Melee Mitigation |
| 339 | Shield Block |
| 374 | Corruption Resist |
| 375 | Physical Resist |
| 383 | Skill Damage Mod |
| 413 | Heal Burn |
| 462 | Worn Spell Damage |
| 463 | Worn Heal Amount |

---

## Rule System

Server behavior is controlled by rules in `rule_values` table.

```perl
my $val = quest::get_rule("RuleName");
quest::set_rule("RuleName", "value");
```

Key rule categories:
- **Character** — Level caps, stats, regen, bind, AA
- **Zone** — Repop timers, weather, gravity, auto-shutdown
- **Combat** — Damage formulas, procs, criticals, riposte
- **Spells** — Resist mechanics, buff limits, charm behavior
- **World** — Max clients, expansion, PVP mode
- **NPC** — Aggro, assist, pathing, scaling
- **Merchant** — Price formulas, sell rate
- **TaskSystem** — Task mechanics
- **Logging** — Debug levels

---

## Plugins System (Perl)

Perl plugins live in `quests/plugins/` and are auto-loaded by all zone processes.

```perl
# In a plugin file (quests/plugins/my_plugin.pl):
sub MyFunction {
    my ($arg1, $arg2) = @_;
    # ...
}

# Usage from any quest script:
plugin::MyFunction($arg1, $arg2);
```

### Built-in Plugin Functions
```perl
plugin::check_handin(\%itemcount, item_id => count, ...);
plugin::return_items(\%itemcount);
plugin::Whisper(message);          # whisper to client
plugin::YellowText(message);      # yellow message to client
plugin::WorldMoan(message);       # world-wide emote
plugin::LoadMysql();               # returns DBI handle
plugin::val(key);                  # get quest global
plugin::SetRoambox(dist, max_x, min_x, max_y, min_y, delay, min_delay);
```

---

## Lua Modules

Lua scripts can use `require()` for modules in `quests/lua_modules/`.

```lua
local item_lib = require("items")
-- item_lib.check_turn_in(npc, trade, {item1 = id})
-- item_lib.return_items(npc, client, trade)
```

---

## Common GM Commands

| Command | Description |
|---------|-------------|
| `#gm on/off` | Toggle GM flag |
| `#zone zoneshortname` | Zone to target |
| `#goto x y z` | Teleport self |
| `#movechar charname zonename` | Move offline character |
| `#summon charname` | Summon player |
| `#kill` | Kill target |
| `#heal` | Full heal target |
| `#level N` | Set target level |
| `#setstat stat value` | Set character stat |
| `#gi item_id [charges]` | Give item to target |
| `#si item_id [charges]` | Summon item |
| `#spawn npc_type_id` | Spawn NPC |
| `#npcspawn create` | Create spawn point |
| `#depop` | Despawn target NPC |
| `#repop` | Repop current zone |
| `#reloadquests` | Reload quest scripts |
| `#reloadworld` | Reload world data |
| `#reloadcontentflags` | Reload content flags |
| `#modifynpcstat key value` | Modify NPC stat |
| `#who` | List players |
| `#flag charname zone_id` | Set zone flag |
| `#setaaxp N` | Set AA XP |
| `#setaapts N` | Set AA points |
| `#castspell spell_id` | Cast spell on target |
| `#peqzone zone_id` | Set PEQ zone flag |
| `#rules` | View/set rules |
| `#databuckets` | View/set data buckets |
| `#logs` | Manage log categories |
| `#door open/close N` | Manipulate doors |

---

## Emote Color IDs

| ID | Color | Common Use |
|----|-------|-----------|
| 0 | White | Default |
| 1 | Gray | System |
| 4 | Blue | Links |
| 5 | Light blue | — |
| 13 | Red | Errors/warnings |
| 14 | Green | Success/positive |
| 15 | Yellow/Orange | World emotes, announcements |
| 18 | Cyan | — |
| 256-335 | Extended palette | Various |

---

## Zone Types

| Value | Type |
|-------|------|
| 0 | Unknown |
| 1 | Regular |
| 2 | Instanced |
| 3 | Hybrid |
| 4 | Guild Hall |
| 5 | Tutorial |
| 6 | Trader |
| 255 | No bind |

---

## Tradeskill Container Types

| ID | Container |
|----|-----------|
| 0 | None |
| 5 | Alchemy |
| 8 | Poison Making |
| 9 | Tinkering |
| 10 | Research |
| 12 | Baking |
| 13 | Tailoring |
| 14 | Blacksmithing |
| 15 | Fletching |
| 16 | Brewing |
| 17 | Jewelry Making |
| 18 | Pottery |
| 19 | Kiln |
| 20 | Oven |
| 40 | Augmentation Pool |
| 50 | Magic |

---

## Item Types

| ID | Type |
|----|------|
| 0 | 1H Slashing |
| 1 | 2H Slashing |
| 2 | 1H Piercing |
| 3 | 1H Blunt |
| 4 | 2H Blunt |
| 5 | Bow |
| 7 | Throwing (Large) |
| 10 | Shield |
| 11 | Ring |
| 14 | 2H Piercing |
| 15 | Spell/Tome/Scroll |
| 17 | All Instruments |
| 20 | Poison |
| 21 | Augmentation |
| 23 | Arrow |
| 24 | Wind Instrument |
| 25 | Stringed Instrument |
| 26 | Brass Instrument |
| 27 | Percussion Instrument |
| 29 | Fishing Pole |
| 31 | Charm |
| 33 | Note |
| 34 | Key |
| 36 | Clothing |
| 38 | Combinable Container |
| 45 | Throwing (Small) |
| 52 | Potion |
| 54 | Armor |
| 58 | Augmentation Solvent |

---

## Damage Types (for spells)

| ID | Type |
|----|------|
| 0 | Unknown/Melee |
| 1 | Fire |
| 2 | Cold |
| 3 | Poison |
| 4 | Disease |
| 5 | Chromatic |
| 6 | Corruption |
| 7 | Prismatic |
| 8 | Physical |
| 9 | Unresistable |

---

## Spell Target Types

| ID | Target |
|----|--------|
| 1 | Line of Sight |
| 2 | AE (PC only) |
| 3 | Group v1 |
| 4 | PB AE |
| 5 | Single |
| 6 | Self |
| 8 | Targeted AE |
| 9 | Animal |
| 10 | Undead |
| 11 | Summoned |
| 13 | Lifetap |
| 14 | Pet |
| 15 | Corpse |
| 16 | Plant |
| 17 | Giant |
| 18 | Dragon |
| 20 | Targeted AE Tap |
| 24 | AE Undeads |
| 25 | AE Summoned |
| 32 | AE Caster |
| 33 | Group |
| 34 | Directional Cone |
| 36 | Group Teleport |
| 40 | AE PC v2 |
| 41 | Group v2 |
| 42 | Directional AE |
| 43 | Front AE |
| 44 | Single in Group |
| 46 | Target Ring |
| 47 | Targets Target |

---

## Faction Values

| Range | Standing |
|-------|----------|
| 1100+ | Ally |
| 750-1099 | Warmly |
| 500-749 | Kindly |
| 100-499 | Amiably |
| 0-99 | Indifferently |
| -100 to -1 | Apprehensively |
| -500 to -101 | Dubiously |
| -750 to -501 | Threateningly |
| -751 and below | Ready to Attack |

---

## Log Categories

Used with `quest::log(category, message)`:

| Category | Description |
|----------|-------------|
| 1 | Normal |
| 2 | Error |
| 3 | Debug |
| 4 | Quest |
| 5 | Command |

---

## Useful SQL Patterns

### Find NPC by name
```sql
SELECT id, name, level, race, class, hp, loottable_id 
FROM npc_types WHERE name LIKE '%Guard%' LIMIT 20;
```

### Find item by name
```sql
SELECT id, Name, ac, hp, mana, classes, slots 
FROM items WHERE Name LIKE '%Sword%' LIMIT 20;
```

### Find spawn by NPC type
```sql
SELECT s2.id, s2.zone, sg.name, se.npcID 
FROM spawn2 s2 
JOIN spawngroup sg ON s2.spawngroupID = sg.id 
JOIN spawnentry se ON sg.id = se.spawngroupID 
WHERE se.npcID = 12345;
```

### View active content flags
```sql
SELECT * FROM content_flags WHERE enabled = 1;
```

### Check zone settings
```sql
SELECT short_name, long_name, expansion, min_status, content_flags 
FROM zone WHERE short_name = 'guildlobby';
```
