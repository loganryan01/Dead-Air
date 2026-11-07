# Game Brief: Dead Air

**One-sentence pitch:** Dive into collapsing derelict space stations, grab as much salvage as you can carry, and escape before your air runs out.

## Core loop
- Dive into a procedurally arranged station section with a fixed air supply.
- Scout rooms and grab salvage. Heavier loot is worth more but slows you and burns air faster.
- Decide each moment whether to push deeper or head back to the airlock.
- Cash out salvage, buy air and gear upgrades, then dive again.

## Player goal & fail state — what "working" looks like
- Goal: bank as much salvage value as possible across runs, working toward the deepest station.
- Fail: air hits zero or the station collapses before you reach the airlock, and you lose everything carried that run.

## MVP — what must exist to be the game
- Player movement with a carry-weight penalty
- Air supply that drains faster with load, with a visible HUD meter
- Salvage pickups with different values and weights
- One station layout with an airlock exit and a collapse timer
- Run end: success cashes out salvage, failure drops it
- Between-run shop with one upgrade (more air)

## Out of scope — not building this
- No multiplayer
- No enemies or combat
- No procedural generation (one hand-built station, hazards fixed)
- No save system beyond total cash
- No story or dialogue
- No more than one upgrade

## Build order
1. Movement, weight and air drain on a grey-box room (proves the push-your-luck tension is fun)
2. Salvage pickups and airlock cash-out
3. Collapse timer and the full station layout
4. Fail state and run reset
5. Between-run shop and the air upgrade
6. HUD polish, then art and audio

---
**Who it's for / what they feel:** Players who like short, tense runs and "one more dive" greed, with a 5 to 10 minute session.

**Art & audio direction:** Dark, low-poly silhouettes with a warm emergency-light palette, plus muffled breathing and creaking metal.

**Reference game:** Lethal Company's scavenge-and-extract tension, keeping only the solo loot-and-escape pressure with no monsters.
