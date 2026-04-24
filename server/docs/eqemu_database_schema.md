# EQEmu Database Schema Reference

> Source: https://docs.eqemu.dev/schema/ — EverQuest Emulator Documentation
> Full schema docs: https://docs.eqemu.dev/schema/

---

## Table Categories

### Account & Characters
- `account` — Player accounts (id, name, status, ls_id, password)
- `account_flags` — Per-account flags
- `account_ip` — IP address history
- `character_data` — Main character record (id, account_id, name, level, class, race, zone, x/y/z, etc.)
- `character_currency` — Currency (platinum, gold, silver, copper, radiant/ebon crystals, alt currencies)
- `character_alternate_abilities` — AA purchases per character
- `character_spells` — Scribed spells
- `character_memmed_spells` — Memorized spells
- `character_disciplines` — Learned disciplines
- `character_skills` — Skill levels
- `character_languages` — Language skills
- `character_bind` — Bind points
- `character_buffs` — Active buffs (persist across zones)
- `character_inventory` — Inventory contents
- `character_corpses` — Player corpses
- `character_corpse_items` — Items on corpses
- `character_tasks` — Active/completed tasks
- `character_activities` — Task activity progress
- `character_task_timers` — Task cooldowns
- `character_expedition_lockouts` — Expedition lockouts
- `character_peqzone_flags` — PEQ zone flags
- `character_tribute` — Tribute settings
- `character_leadership_abilities` — Leadership AAs

### NPCs
- **`npc_types`** — NPC definitions (see full schema below)
- `npc_emotes` — NPC emote definitions
- `npc_faction` — NPC faction assignments
- `npc_faction_entries` — Faction modifier entries
- `npc_spells` — NPC spell set definitions
- `npc_spells_entries` — Individual spells in spell sets
- `npc_spells_effects` — NPC spell effect overrides
- `npc_spells_effects_entries` — Individual effect entries
- `npc_types_tint` — NPC armor tint definitions

### Spawns
- **`spawn2`** — Spawn points (see full schema below)
- **`spawngroup`** — Spawn groups
- **`spawnentry`** — NPC-to-spawngroup mapping with chance
- `spawn_conditions` — Spawn condition values
- `spawn_condition_values` — Condition value storage
- `spawn_events` — Timed spawn events

### Loot
- **`loottable`** — Loot table definitions
- **`loottable_entries`** — Links loottables to lootdrops
- **`lootdrop`** — Loot drop pool definitions
- **`lootdrop_entries`** — Individual items in loot drops
- `global_loot` — Global loot rules

### Items
- **`items`** — Item definitions (see full schema below)
- `item_tick` — Item tick effects
- `discovered_items` — First-discovered item tracking

### Spells
- `spells_new` — Spell definitions (3000+ columns, massive table)
- `spell_globals` — Spell global requirements

### Zone
- **`zone`** — Zone definitions (see full schema below)
- `zone_flags` — Per-character zone flags
- `zone_points` — Zone connection points

### Doors & Objects
- `doors` — Door/object definitions (id, doorid, zone, name, pos_x/y/z, dest_zone, dest_x/y/z, keyitem, etc.)
- `object` — World objects (forges, brew barrels, etc.)
- `object_contents` — Items stored in world objects

### Grids & Pathing
- `grid` — Grid definitions (id, zoneid, type, type2)
- `grid_entries` — Waypoints (gridid, zoneid, number, x, y, z, heading, pause, centerpoint)

### Factions
- `faction_list` — Faction definitions (id, name, base)
- `faction_list_mod` — Faction modifiers by race/class/deity
- `faction_values` — Per-character faction values

### Tasks
- `tasks` — Task definitions
- `task_activities` — Task activity steps
- `tasksets` — Task set groupings

### Merchants
- `merchantlist` — Merchant inventory (merchantid, slot, item, faction_required, etc.)
- `merchantlist_temp` — Temporary merchant changes

### Tradeskills
- `tradeskill_recipe` — Recipe definitions
- `tradeskill_recipe_entries` — Recipe components and results

### Adventures & Dynamic Zones
- `adventure_template` — Adventure template definitions
- `adventure_template_entry` — Adventure template entries
- `dynamic_zones` — Active dynamic zone instances
- `dynamic_zone_templates` — DZ templates
- `expedition_lockouts` — Expedition lockout tracking
- `expeditions` — Active expeditions
- `instance_list` — Active zone instances

### Rules & Flags
- `rule_sets` — Rule set definitions
- `rule_values` — Rule name-value pairs
- `content_flags` — Content flag definitions (flag_name, enabled, notes)
- `data_buckets` — Key-value data storage with expiry
- `quest_globals` — Legacy quest global storage
- `variables` — Server variables

### Titles
- `titles` — Title definitions

### Guilds
- `guilds` — Guild definitions
- `guild_members` — Guild membership
- `guild_ranks` — Guild rank definitions

### Groups & Raids
- `group_id` — Group tracking
- `group_leaders` — Group leader tracking
- `raid_details` — Raid instance details
- `raid_members` — Raid membership
- `raid_leaders` — Raid leader tracking

### AAs
- `aa_ability` — AA ability definitions
- `aa_ranks` — AA rank definitions
- `aa_rank_effects` — AA rank effect values
- `aa_rank_prereqs` — AA rank prerequisites

### Pets
- `pets` — Pet definitions (type, petpower, npcID, temp, petcontrol, petnaming, monsterflag, equipmentset)
- `pets_beastlord_data` — Beastlord pet data
- `pets_equipmentset` — Pet equipment sets
- `pets_equipmentset_entries` — Individual pet equipment entries

### Traps
- `traps` — Trap definitions
- `ldon_trap_templates` — LDON trap templates
- `ldon_trap_entries` — LDON trap entries

### Ground Spawns
- `ground_spawns` — Ground spawn items (zoneid, item, max_x/y/z, min_x/y/z, respawn_timer)

### Tribute
- `tribute_levels` — Tribute tier definitions
- `tributes` — Tribute definitions

### Misc
- `bugs` — Bug report storage
- `petitions` — Player petitions
- `login_server_list_types` — Login server types
- `player_event_logs` — Player event logging
- `qs_player_*` — QueryServ player tracking tables

---

## Key Table Schemas

### npc_types

Full NPC definition table. Referenced by `spawnentry.npcID`.

| Column | Type | Description |
|--------|------|-------------|
| id | int | Unique NPC Type Identifier |
| name | text | Name |
| lastname | varchar | Last Name |
| level | tinyint | Level |
| race | smallint | Race ID |
| class | tinyint | Class ID |
| bodytype | int | Body Type ID |
| hp | bigint | Health |
| mana | bigint | Mana |
| gender | tinyint | Gender (0=Male, 1=Female, 2=Neuter) |
| texture | tinyint | Model texture |
| helmtexture | tinyint | Helmet texture |
| herosforgemodel | int | Hero's Forge model |
| size | float | Size multiplier |
| hp_regen_rate | bigint | HP regeneration |
| hp_regen_per_second | bigint | HP regen per second |
| mana_regen_rate | bigint | Mana regeneration |
| loottable_id | int | FK → loottable.id |
| merchant_id | int | FK → merchantlist |
| alt_currency_id | int | Alternate currency ID |
| npc_spells_id | int | FK → npc_spells.id |
| npc_spells_effects_id | int | FK → npc_spells_effects.id |
| npc_faction_id | int | FK → faction_list.id |
| adventure_template_id | int | FK → adventure_template.id |
| mindmg | int | Minimum damage |
| maxdmg | int | Maximum damage |
| attack_count | smallint | Attack count |
| special_abilities | text | Special abilities string (see General Knowledge doc) |
| aggroradius | int | Aggro radius |
| assistradius | int | Assist radius |
| face | int | Face appearance |
| luclin_hairstyle | int | Hair style |
| luclin_haircolor | int | Hair color |
| luclin_eyecolor | int | Eye color 1 |
| luclin_eyecolor2 | int | Eye color 2 |
| luclin_beardcolor | int | Beard color |
| luclin_beard | int | Beard style |
| drakkin_heritage | int | Drakkin heritage |
| drakkin_tattoo | int | Drakkin tattoo |
| drakkin_details | int | Drakkin details |
| armortint_id | int | FK → npc_types_tint.id |
| armortint_red | tinyint | Armor tint red (0-255) |
| armortint_green | tinyint | Armor tint green (0-255) |
| armortint_blue | tinyint | Armor tint blue (0-255) |
| d_melee_texture1 | int | Primary weapon texture |
| d_melee_texture2 | int | Secondary weapon texture |
| prim_melee_type | tinyint | Primary melee skill type |
| sec_melee_type | tinyint | Secondary melee skill type |
| ranged_type | tinyint | Ranged skill type |
| runspeed | float | Run speed |
| MR | smallint | Magic Resistance |
| CR | smallint | Cold Resistance |
| DR | smallint | Disease Resistance |
| FR | smallint | Fire Resistance |
| PR | smallint | Poison Resistance |
| Corrup | smallint | Corruption Resistance |
| PhR | smallint | Physical Resistance |
| see_invis | smallint | See Invisible (0/1) |
| see_invis_undead | smallint | See Invisible vs Undead (0/1) |
| AC | smallint | Armor Class |
| npc_aggro | tinyint | NPC Aggro (0/1) |
| spawn_limit | tinyint | Spawn limit |
| attack_speed | float | Attack speed (deprecated, use attack_delay) |
| attack_delay | tinyint | Attack delay in 10ths of second (e.g., 28 = 2.8s) |
| findable | tinyint | Findable via /find (0/1) |
| STR | mediumint | Strength |
| STA | mediumint | Stamina |
| DEX | mediumint | Dexterity |
| AGI | mediumint | Agility |
| _INT | mediumint | Intelligence |
| WIS | mediumint | Wisdom |
| CHA | mediumint | Charisma |
| see_hide | tinyint | See Hide (0/1) |
| see_improved_hide | tinyint | See Improved Hide (0/1) |
| trackable | tinyint | Trackable (0/1) |
| ATK | mediumint | Attack |
| Accuracy | mediumint | Accuracy rating |
| Avoidance | mediumint | Avoidance rating |
| slow_mitigation | smallint | Slow mitigation |
| version | smallint | Version |
| maxlevel | tinyint | Maximum level |
| scalerate | int | Scale rate for level scaling |
| private_corpse | tinyint | Private corpse (0/1) |
| unique_spawn_by_name | tinyint | Unique spawn by name (0/1) |
| underwater | tinyint | Underwater only (0/1) |
| emoteid | int | FK → npc_emotes.id |
| spellscale | float | Spell scale (100 = 100%) |
| healscale | float | Heal scale (100 = 100%) |
| no_target_hotkey | tinyint | No target hotkey (0/1) |
| raid_target | tinyint | Raid target (0/1) |
| light | tinyint | Light type |
| walkspeed | tinyint | Walk speed |
| charm_ac | smallint | Charmed AC |
| charm_min_dmg | int | Charmed minimum damage |
| charm_max_dmg | int | Charmed maximum damage |
| charm_attack_delay | tinyint | Charmed attack delay |
| charm_accuracy_rating | mediumint | Charmed accuracy |
| charm_avoidance_rating | mediumint | Charmed avoidance |
| charm_atk | mediumint | Charmed attack |
| skip_global_loot | tinyint | Skip global loot (0/1) |
| rare_spawn | tinyint | Rare spawn (0/1) |
| flymode | tinyint | Fly mode |
| always_aggro | tinyint | Always aggro (0/1) |
| exp_mod | int | XP modifier (100 = 100%) |
| heroic_strikethrough | int | Heroic strikethrough |
| keeps_sold_items | tinyint | Keeps sold items (0/1) |

---

### spawn2

Spawn point definitions — where NPCs can spawn in zones.

| Column | Type | Description |
|--------|------|-------------|
| id | int | Unique spawn2 ID |
| spawngroupID | int | FK → spawngroup.id |
| zone | varchar | Zone short name |
| version | smallint | Zone version |
| x | float | X coordinate |
| y | float | Y coordinate |
| z | float | Z coordinate |
| heading | float | Heading |
| respawntime | int | Respawn time in seconds |
| variance | int | Respawn variance in seconds |
| pathgrid | int | FK → grid.id (0 = none) |
| path_when_zone_idle | tinyint | Path when zone idle (0/1) |
| _condition | mediumint | Spawn condition ID |
| cond_value | mediumint | Spawn condition value |
| animation | tinyint | Animation on spawn |
| min_expansion | tinyint | Minimum expansion filter |
| max_expansion | tinyint | Maximum expansion filter |
| content_flags | varchar | Content flags required enabled |
| content_flags_disabled | varchar | Content flags required disabled |

---

### spawngroup

Groups spawn entries together with a shared spawn point.

| Column | Type | Description |
|--------|------|-------------|
| id | int | Unique spawngroup ID |
| name | varchar | Name |
| spawn_limit | tinyint | Maximum concurrent spawns |
| dist | float | Roam distance |
| max_x | float | Roam max X |
| min_x | float | Roam min X |
| max_y | float | Roam max Y |
| min_y | float | Roam min Y |
| delay | int | Roam delay |
| mindelay | int | Minimum roam delay |
| despawn | tinyint | Despawn type |
| despawn_timer | int | Despawn timer (seconds) |
| wp_spawns | tinyint | Spawn at waypoint (0/1) |

---

### spawnentry

Links NPCs to spawn groups with probability.

| Column | Type | Description |
|--------|------|-------------|
| spawngroupID | int | FK → spawngroup.id |
| npcID | int | FK → npc_types.id |
| chance | smallint | Spawn chance (0-100) |
| condition_value_filter | mediumint | Condition value filter |
| min_expansion | tinyint | Minimum expansion filter |
| max_expansion | tinyint | Maximum expansion filter |
| content_flags | varchar | Content flags required enabled |
| content_flags_disabled | varchar | Content flags required disabled |

---

### Spawn Chain Explained

```
spawn2 (WHERE in zone) 
  → spawngroup (WHICH group, roaming bounds) 
    → spawnentry (WHICH NPC, % chance) 
      → npc_types (WHAT NPC is)
        → loottable → loottable_entries → lootdrop → lootdrop_entries → items
        → npc_spells → npc_spells_entries
        → npc_faction → faction_list
```

---

### Loot Chain

```
npc_types.loottable_id → loottable
  → loottable_entries (multiplier, droplimit, mindrop, probability)
    → lootdrop
      → lootdrop_entries (item_id, chance, equip_item, npc_min/max_level)
        → items
```

#### loottable

| Column | Type | Description |
|--------|------|-------------|
| id | int | Unique loottable ID |
| name | varchar | Name |
| mincash | int | Minimum cash (copper) |
| maxcash | int | Maximum cash (copper) |
| avgcoin | int | Average coin (copper) |
| done | tinyint | Done flag (0/1) |
| content_flags | varchar | Content flags |

#### loottable_entries

| Column | Type | Description |
|--------|------|-------------|
| loottable_id | int | FK → loottable.id |
| lootdrop_id | int | FK → lootdrop.id |
| multiplier | tinyint | How many times to roll this drop |
| droplimit | tinyint | Maximum items from this drop |
| mindrop | tinyint | Minimum items from this drop |
| probability | float | Probability (0-100) |

#### lootdrop

| Column | Type | Description |
|--------|------|-------------|
| id | int | Unique lootdrop ID |
| name | varchar | Name |
| content_flags | varchar | Content flags |

#### lootdrop_entries

| Column | Type | Description |
|--------|------|-------------|
| lootdrop_id | int | FK → lootdrop.id |
| item_id | int | FK → items.id |
| item_charges | smallint | Item charges |
| equip_item | tinyint | Equip on NPC (0/1) |
| chance | float | Chance (0-100) |
| disabled_chance | float | Disabled chance |
| trivial_min_level | smallint | Trivial minimum level |
| trivial_max_level | smallint | Trivial maximum level |
| multiplier | tinyint | Multiplier |
| npc_min_level | smallint | NPC minimum level filter |
| npc_max_level | smallint | NPC maximum level filter |

---

### zone

Zone definitions.

| Column | Type | Description |
|--------|------|-------------|
| id | int | Unique entry ID |
| short_name | varchar | Zone short name (e.g., "guildlobby") |
| long_name | text | Zone long name |
| zoneidnumber | int | Zone ID number |
| version | tinyint | Version |
| file_name | varchar | Map file name |
| safe_x/y/z | float | Safe coordinates |
| safe_heading | float | Safe heading |
| graveyard_id | float | FK → graveyard.id |
| min_level | tinyint | Minimum level to enter |
| max_level | tinyint | Maximum level to enter |
| min_status | tinyint | Minimum account status |
| maxclients | int | Maximum clients in zone |
| ruleset | int | FK → rule_sets.id |
| underworld | float | Underworld Z threshold |
| minclip | float | Minimum clipping distance |
| maxclip | float | Maximum clipping distance |
| fog_minclip/maxclip | float | Fog clipping distances |
| fog_red/green/blue | tinyint | Fog color (0-255) |
| fog_density | float | Fog density (0-1) |
| sky | tinyint | Sky type |
| ztype | tinyint | Zone type |
| zone_exp_multiplier | decimal | XP multiplier (1.0 = 100%) |
| walkspeed | float | Zone walk speed |
| time_type | tinyint | Time type |
| flag_needed | varchar | Zone flag requirement |
| castoutdoor | tinyint | Cast outdoors (0/1) |
| hotzone | tinyint | Hot zone (0/1) |
| insttype | tinyint | Instance type |
| shutdowndelay | bigint | Shutdown delay |
| peqzone | tinyint | PEQ zone flag support (0/1) |
| expansion | tinyint | Required expansion ID |
| bypass_expansion_check | tinyint | Bypass expansion check (0/1) |
| suspendbuffs | tinyint | Suspend buffs on entry (0/1) |
| rain_chance1-4 | int | Rain chance per slot |
| rain_duration1-4 | int | Rain duration per slot |
| snow_chance1-4 | int | Snow chance per slot |
| snow_duration1-4 | int | Snow duration per slot |
| gravity | float | Gravity |
| type | int | Type (0=Unknown, 1=Regular, 2=Instanced, 3=Hybrid) |
| skylock | tinyint | Sky lock |
| fast_regen_hp/mana/endurance | int | Fast regen rates |
| npc_max_aggro_dist | int | NPC max aggro distance |
| min_expansion | tinyint | Minimum expansion filter |
| max_expansion | tinyint | Maximum expansion filter |
| content_flags | varchar | Content flags required enabled |
| content_flags_disabled | varchar | Content flags required disabled |
| lava_damage | int | Lava damage modifier |
| min_lava_damage | int | Minimum lava damage |
| idle_when_empty | tinyint | Idle when empty (0/1) |
| seconds_before_idle | int | Seconds before idle |

---

### items (Key Columns Only)

Full item table has 200+ columns. Key fields:

| Column | Type | Description |
|--------|------|-------------|
| id | int | Unique item ID |
| Name | varchar | Item name |
| itemclass | int | Item class (0=Common, 1=Container, 2=Book) |
| itemtype | int | Item type (0=1HS, 1=2HS, 2=Piercing, etc.) |
| slots | int | Equippable slot bitmask |
| classes | int | Usable class bitmask |
| races | int | Usable race bitmask |
| deity | int | Required deity |
| reqlevel | int | Required level |
| reclevel | int | Recommended level |
| ac | int | Armor Class |
| hp | int | Health |
| mana | int | Mana |
| endur | int | Endurance |
| astr/asta/aagi/adex/aint/awis/acha | int | Stat bonuses |
| mr/fr/cr/pr/dr | int | Resist bonuses |
| svcorruption | int | Corruption resist |
| damage | int | Weapon damage |
| delay | int | Weapon delay |
| range | int | Weapon range |
| haste | int | Haste percentage |
| attack | int | Attack bonus |
| regen | int | HP regen |
| manaregen | int | Mana regen |
| enduranceregen | int | Endurance regen |
| healamt | smallint | Heal amount |
| spelldmg | smallint | Spell damage |
| accuracy | int | Accuracy |
| avoidance | int | Avoidance |
| shielding | int | Shielding % |
| strikethrough | int | Strikethrough |
| stunresist | int | Stun resist |
| damageshield | int | Damage shield |
| spellshield | int | Spell shielding |
| dotshielding | int | DoT shielding |
| heroic_str/sta/agi/dex/int/wis/cha | smallint | Heroic stats |
| heroic_mr/fr/cr/pr/dr/svcorrup | smallint | Heroic resists |
| clickeffect | int | Click effect spell ID |
| clicktype | int | Click type |
| clicklevel | int | Click level |
| proceffect | int | Proc spell ID |
| procrate | int | Proc rate modifier |
| proclevel | int | Proc level |
| worneffect | int | Worn effect spell ID |
| worntype | int | Worn type |
| focuseffect | int | Focus effect spell ID |
| focustype | int | Focus type |
| scrolleffect | int | Scroll effect spell ID |
| bardeffect | int | Bard effect spell ID |
| weight | int | Weight (10 = 1.0 lbs) |
| price | int | Price in copper |
| stacksize | int | Stack size |
| stackable | int | Stackable (0/1) |
| nodrop | int | No Drop (0=True, 1=False — inverted!) |
| norent | int | No Rent (0=True, 1=False — inverted!) |
| notransfer | int | No Transfer (0/1) |
| attuneable | int | Attuneable (0/1) |
| magic | int | Magic item (0/1) |
| lore | varchar | Lore text |
| loregroup | int | Lore group |
| questitemflag | int | Quest item (0/1) |
| bagslots | int | Bag slots (1-10) |
| bagsize | int | Bag size |
| bagtype | int | Bag/container type |
| bagwr | int | Bag weight reduction % |
| augtype | int | Augment type |
| augslot1type-6type | tinyint | Augment slot types |
| maxcharges | int | Maximum charges |
| recastdelay | int | Recast delay (seconds) |
| recasttype | int | Recast type |
| tradeskills | int | Tradeskill item (0/1) |
| ldonprice | int | LDON price |
| ldontheme | int | LDON theme ID |
| book | int | Book type |
| booktype | int | Book language |
| purity | int | Purity |
| epicitem | int | Epic item (0/1) |
| evoitem | int | Evolving item (0/1) |
| evolvinglevel | int | Evolving level |

**Important:** `nodrop` and `norent` use inverted logic: 0 = True (item IS no-drop), 1 = False.

---

### data_buckets

Key-value storage with optional expiration.

| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Auto-increment ID |
| key_ | varchar(100) | Bucket key |
| value | text | Bucket value |
| expires | int | Unix timestamp expiry (0 = never) |

---

### content_flags

Content flag definitions for gating content.

| Column | Type | Description |
|--------|------|-------------|
| id | int | Auto-increment ID |
| flag_name | varchar(75) | Flag name |
| enabled | tinyint | Enabled (0/1) |
| notes | text | Notes |

Referenced by: `spawn2.content_flags`, `spawnentry.content_flags`, `doors.content_flags`, `merchantlist.content_flags`, `loottable.content_flags`, `lootdrop.content_flags`, `zone.content_flags`

---

### rule_values

Server behavior rules.

| Column | Type | Description |
|--------|------|-------------|
| ruleset_id | tinyint | FK → rule_sets.id |
| rule_name | varchar(64) | Rule name (e.g., "Character:MaxLevel") |
| rule_value | varchar(30) | Rule value |
| notes | text | Notes |

---

### doors

Door and clickable object definitions.

| Column | Type | Description |
|--------|------|-------------|
| id | int | Auto-increment ID |
| doorid | smallint | Door ID (unique per zone) |
| zone | varchar(32) | Zone short name |
| version | smallint | Zone version |
| name | varchar(32) | Door name |
| pos_x/y/z | float | Position |
| heading | float | Heading |
| opentype | smallint | Open type |
| guild | smallint | Guild ID requirement |
| lockpick | smallint | Lockpick skill required |
| keyitem | int | Key item ID required |
| nokeyring | smallint | No keyring (0/1) |
| triggerdoor | smallint | Trigger door ID |
| triggertype | smallint | Trigger type |
| dest_zone | varchar(32) | Destination zone |
| dest_instance | int | Destination instance |
| dest_x/y/z | float | Destination coordinates |
| dest_heading | float | Destination heading |
| invert_state | int | Invert state (0/1) |
| incline | int | Incline |
| size | smallint | Size |
| is_ldon_door | smallint | LDON door (0/1) |
| content_flags | varchar | Content flags |

---

### grid / grid_entries

NPC patrol paths.

**grid:**
| Column | Type | Description |
|--------|------|-------------|
| id | int | Grid ID |
| zoneid | int | Zone ID |
| type | int | Wander type (0=Circular, 1=Random, 2=Patrol, 3=OneWay, 4=Random CenterPoint) |
| type2 | int | Pause type (0=Random Half, 1=Full, 2=Random Full) |

**grid_entries:**
| Column | Type | Description |
|--------|------|-------------|
| gridid | int | FK → grid.id |
| zoneid | int | Zone ID |
| number | int | Waypoint number (0-based) |
| x/y/z | float | Coordinates |
| heading | float | Heading |
| pause | int | Pause time (seconds) |
| centerpoint | tinyint | Center point (0/1) |

---

## Common SQL Queries

### Spawn chain lookup (NPC → spawn point)
```sql
SELECT s2.id AS spawn2_id, s2.zone, s2.x, s2.y, s2.z, s2.respawntime,
       sg.name AS spawngroup_name, se.chance,
       nt.id AS npc_id, nt.name AS npc_name, nt.level
FROM npc_types nt
JOIN spawnentry se ON nt.id = se.npcID
JOIN spawngroup sg ON se.spawngroupID = sg.id
JOIN spawn2 s2 ON sg.id = s2.spawngroupID
WHERE nt.name LIKE '%Fippy%';
```

### Loot chain lookup (NPC → items)
```sql
SELECT nt.name AS npc_name, lt.name AS loottable_name,
       lte.probability, lte.multiplier, lte.droplimit, lte.mindrop,
       ld.name AS lootdrop_name,
       lde.chance, lde.equip_item,
       i.id AS item_id, i.Name AS item_name
FROM npc_types nt
JOIN loottable lt ON nt.loottable_id = lt.id
JOIN loottable_entries lte ON lt.id = lte.loottable_id
JOIN lootdrop ld ON lte.lootdrop_id = ld.id
JOIN lootdrop_entries lde ON ld.id = lde.lootdrop_id
JOIN items i ON lde.item_id = i.id
WHERE nt.id = 12345;
```

### Find all NPCs in a zone
```sql
SELECT DISTINCT nt.id, nt.name, nt.level, nt.race, nt.class
FROM spawn2 s2
JOIN spawnentry se ON s2.spawngroupID = se.spawngroupID
JOIN npc_types nt ON se.npcID = nt.id
WHERE s2.zone = 'guildlobby'
ORDER BY nt.level DESC;
```

### Content-flagged spawns
```sql
SELECT s2.id, s2.zone, s2.content_flags, nt.name
FROM spawn2 s2
JOIN spawnentry se ON s2.spawngroupID = se.spawngroupID
JOIN npc_types nt ON se.npcID = nt.id
WHERE s2.content_flags IS NOT NULL AND s2.content_flags != '';
```

### Data bucket lookup
```sql
SELECT * FROM data_buckets WHERE key_ LIKE '%charID-flag%';
```
