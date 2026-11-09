# Epic: Dead Air

> **Source**: `design/game-brief.md` (minimal tier: no GDD, ADRs or manifest)
> **Goal**: Dive into collapsing derelict space stations, grab as much salvage as you can carry, and escape before your air runs out.

## Scope (the brief's MVP list)

- Player movement with a carry-weight penalty
- Air supply that drains faster with load, with a visible HUD meter
- Salvage pickups with different values and weights
- One station layout with an airlock exit and a collapse timer
- Run end: success cashes out salvage, failure drops it
- Between-run shop with one upgrade (more air)

Out of scope: multiplayer, enemies or combat, procedural generation, saves beyond total cash, story, more than one upgrade.

## Order (the brief's build order)

Movement and weight, then air drain, then salvage and airlock, then collapse timer and station, then run end, then the shop.

## Stories

| # | Story | Type | Status | ADR |
|---|-------|------|--------|-----|
| 001 | Player movement with carry weight | Logic | Complete | N/A |
| 002 | Air supply drain and HUD meter | Logic | Complete | N/A |
| 003 | Salvage pickups | Integration | Complete | N/A |
| 004 | Station layout, airlock and collapse timer | Integration | Complete | N/A |
| 005 | Run end: cash-out or loss | Logic | Complete | N/A |
| 006 | Between-run shop and air upgrade | UI | Complete | N/A |
| 008 | HUD polish | UI | Complete | N/A |
| 009 | Station art pass | Visual/Feel | Ready | N/A |
| 010 | Breathing and station audio | Integration | Ready | N/A |
