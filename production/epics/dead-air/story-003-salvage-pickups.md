# Story 003: Salvage pickups

> **Epic**: Dead Air
> **Status**: Complete
> **Layer**: N/A (minimal)
> **Type**: Integration
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-07

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 3 (salvage pickups with different values and weights)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using any Area3D or physics API.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's core loop (grab salvage; heavier loot is worth more but slows you and burns air) and MVP feature 3:*

- [ ] At least three salvage types exist, each with its own value and weight, defined in a data file.
- [ ] Walking into or interacting with a salvage item picks it up and removes it from the world.
- [ ] A pickup raises carry weight by the item's weight (story 001) and therefore speeds up air drain (story 002).
- [ ] A running total of carried value is tracked and available to other systems.
- [ ] Heavier items are worth more value than lighter ones in the data.
- [ ] Items cannot be picked up twice.

---

## Implementation Notes

- Salvage types are data (a resource each), not hardcoded.
- The carried-salvage total is owned by one script; the HUD and run end read it through a getter or signal.
- Use `salvage_picked_up` (past tense, snake_case) for the signal.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 004: where salvage is placed in the station
- Story 005: cashing out or dropping carried salvage

---

## Files

- `src/gameplay/salvage/salvage_type.gd`
- `src/gameplay/salvage/salvage_item.gd`
- `src/gameplay/salvage/salvage_item.tscn`
- `src/gameplay/player/cargo.gd`
- `assets/data/salvage_types/scrap_metal.tres`
- `assets/data/salvage_types/circuit_board.tres`
- `assets/data/salvage_types/reactor_core.tres`
- `src/gameplay/player/player.gd`
- `src/gameplay/player/movement_tuning.gd`
- `assets/data/movement_tuning.tres`
- `src/gameplay/player/grey_box_room.tscn`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory).*

**Story Type**: Integration
**Required evidence**: `tests/integration/dead-air/salvage_pickup_test.gd` OR a playtest note (advisory at `qa.level: minimal`)

**Status**: [x] Automated test waived (qa.level minimal) — screenshot retained in `production/qa/evidence/story-003-salvage-pickups/`

---

## Dependencies

- Depends on: `production/epics/dead-air/story-001-player-movement-carry-weight.md`, `production/epics/dead-air/story-002-air-supply-hud.md`
- Unlocks: `production/epics/dead-air/story-004-station-airlock-collapse.md`

---

## Completion Notes
**Completed**: 2026-11-07
**Criteria**: 6/6 passing (none deferred)
**Deviations**: Removed the R/F debug keys and `debug_weight_step` from story-001 files (planned in story 001's notes; stories 001 and 002 evidence stamps are now older than that code); probe placed the player on the item rather than walking with WASD; pickup radius (0.5) lives in the scene, not a data file; carried weight and value are not shown on screen yet.
**Test Evidence**: waived at qa.level minimal; screenshots retained at `production/qa/evidence/story-003-salvage-pickups/`
**Reviewed by**: self, no independent review
