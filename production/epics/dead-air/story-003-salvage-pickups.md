# Story 003: Salvage pickups

> **Epic**: Dead Air
> **Status**: Ready
> **Layer**: N/A (minimal)
> **Type**: Integration
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

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

- `src/gameplay/salvage/salvage_item.gd`
- `src/gameplay/salvage/salvage_item.tscn`
- `src/gameplay/player/cargo.gd`
- `assets/data/salvage_types/` (one resource per type)
- `tests/integration/dead-air/salvage_pickup_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory).*

**Story Type**: Integration
**Required evidence**: `tests/integration/dead-air/salvage_pickup_test.gd` OR a playtest note (advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/dead-air/story-001-player-movement-carry-weight.md`, `production/epics/dead-air/story-002-air-supply-hud.md`
- Unlocks: `production/epics/dead-air/story-004-station-airlock-collapse.md`
