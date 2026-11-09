# Story 001: Player movement with carry weight

> **Epic**: Dead Air
> **Status**: Complete
> **Layer**: N/A (minimal)
> **Type**: Logic
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-07

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 1 (player movement with a carry-weight penalty)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using any physics or CharacterBody3D API.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's Player goal & fail state and MVP feature 1:*

- [ ] The player moves in a grey-box room with keyboard/mouse (gamepad optional).
- [ ] Carry weight is a single number that rises when salvage is added and falls when it is dropped.
- [ ] Move speed falls as carry weight rises, and never drops below a minimum speed.
- [ ] Speed with zero weight equals the base speed.
- [ ] Base speed, minimum speed and the weight-to-speed curve come from a data file, not hardcoded.
- [ ] The weight-to-speed calculation is a pure function that a unit test can call without a scene.

---

## Implementation Notes

- Keep the weight-to-speed math in its own script, separate from the player node, so it is unit-testable.
- Gameplay values live in an external resource or config file, per project coding standards.
- Grey-box only: no art. This story proves the movement feels right before anything else is built.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 002: air drain and the HUD meter
- Story 003: salvage pickups that actually add weight

---

## Files

- `src/gameplay/player/movement_tuning.gd`
- `src/gameplay/player/carry_weight.gd`
- `src/gameplay/player/player.gd`
- `src/gameplay/player/grey_box_room.tscn`
- `assets/data/movement_tuning.tres`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory).*

**Story Type**: Logic
**Required evidence**: `tests/unit/dead-air/movement_weight_test.gd` (advisory at `qa.level: minimal`)

**Status**: [x] Automated test waived (qa.level minimal) — screenshot retained in `production/qa/evidence/story-001-player-movement-carry-weight/`

---

## Dependencies

- Depends on: None
- Unlocks: `production/epics/dead-air/story-002-air-supply-hud.md`, `production/epics/dead-air/story-003-salvage-pickups.md`

---

## Completion Notes
**Completed**: 2026-11-07
**Criteria**: 6/6 passing (none deferred)
**Deviations**: R/F debug weight keys in `player.gd` (remove when story 003 lands); WASD hardcoded until InputMap actions exist; `max_weight` of 0 and a null `tuning` are unguarded. Godot-generated `.gd.uid` files and a rewritten `project.godot` are outside the Files list.
**Test Evidence**: waived at qa.level minimal; screenshot retained at `production/qa/evidence/story-001-player-movement-carry-weight/`
**Reviewed by**: self, no independent review
