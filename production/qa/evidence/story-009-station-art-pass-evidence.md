# Evidence: Story 009 — Station art pass

**Story**: `production/epics/dead-air/story-009-station-art-pass.md`
**Type**: Visual/Feel
**Captured**: 2026-11-09, Godot 4.7.1 (Forward+, Vulkan, NVIDIA RTX 4000 Ada), 1280×720 window
**Files proved**: hashed in `story-009-station-art-pass/stamp.txt`

## Screenshots

All are in `production/qa/evidence/story-009-station-art-pass/`. Each one was taken from the player camera, facing toward the airlock (−z).

| Image | Player z | Shows |
|---|---|---|
| `01-room1.png` | −2 | Room 1: ceiling ribs and wall pillars under amber light; the teal airlock is visible at the far end of the corridor |
| `02-room2.png` | −14 | Room 2: crate stacks |
| `03-room3.png` | −26 | Room 3: wall pipes and posts; teal airlock glow through the doorways |
| `04-room4.png` | −38 | Room 4: reactor columns with glowing rings and prism wedges; reactor-core salvage glowing bright yellow |
| `05-room5-airlock.png` | −49 | Room 5 / airlock: consoles, gate frame, emissive teal airlock floor and light |
| `06-airlock-from-room3.png` | −30 | How easy the airlock is to find from mid-station |
| `07-alarm-room2.png` | −14 | Alarm state (collapse timer forced to 0:10): station lights are alarm red, the airlock glow stays teal |
| `08-alarm-room5-airlock.png` | −49 | Alarm state at the airlock: the airlock stays teal, the station light behind turns red |

## Acceptance criteria

| Criterion | Result | Evidence |
|---|---|---|
| Low-poly shapes built from Godot primitives, dark materials, no imported models | PASS | `01`–`05` |
| Amber emergency lights (some flicker), WorldEnvironment with fog and low ambient light, DirectionalLight3D removed | PASS (look); flicker is a feel item, see below | `01`–`04` |
| The airlock has its own light colour and can be found from each room | PASS | `01`, `03`, `06` |
| Salvage glow strength set by `salvage_type` value | PASS: scrap is dim grey, circuit boards bright green, reactor cores bright yellow | `03`, `04`, `07` |
| Lights turn alarm red in the final configured seconds | PASS (`alarm_seconds` = 30) | `07`, `08` |
| Collision shapes and layout unchanged | PASS: all 36 StaticBody / CollisionShape / Area3D / shape / Player blocks in `station.tscn` match HEAD byte for byte | scripted diff |
| Flicker, fog, colours and intensities come from a data file | PASS: `assets/data/station_tuning.tres` | code |
| 60 fps at 1280×720 on the dev machine | PASS: about 1930 fps on average, worst frame 1.29 ms over 5 s with vsync off (room 3) | scripted measurement |

## Deferred to a playtest (feel)

- Flicker rate and depth (9 / 0.6) and how harsh the flicker feels in motion.
- Light energy (2), range (10) and fog density (0.035) are first guesses, worth tuning by eye.
- Whether the 30-second alarm threshold feels right against the 180 s collapse timer.

## Sign-off

- [x] Lead sign-off: Logan Ryan Date: 9/11/2026
