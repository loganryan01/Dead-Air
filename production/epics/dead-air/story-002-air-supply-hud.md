# Story 002: Air supply drain and HUD meter

> **Epic**: Dead Air
> **Status**: Complete
> **Layer**: N/A (minimal)
> **Type**: Logic
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-07

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 2 (air supply that drains faster with load, with a visible HUD meter)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using any Control or signal API.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's Player goal & fail state (fail: air hits zero) and MVP feature 2:*

- [ ] The player starts each run with a full air supply of a configured size.
- [ ] Air drains every second at a base rate when carrying nothing.
- [ ] The drain rate rises as carry weight rises (reads weight from story 001).
- [ ] When air reaches zero, an `air_depleted` signal fires exactly once.
- [ ] A HUD meter shows current air as a bar and a number, and updates as air changes.
- [ ] Base drain rate, load multiplier and starting air come from a data file.
- [ ] The drain calculation is a pure function a unit test can call.

---

## Implementation Notes

- Keep the drain math separate from the HUD so it is unit-testable.
- The HUD only reads air through a signal or a getter; it never changes air.
- Use `air_depleted` (past tense, snake_case) per project naming.
- Take a screenshot of the HUD meter at full, half and empty air and keep it in `production/qa/evidence/`.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 005: what happens when air depletes (run end)
- Story 006: the air upgrade that raises starting air

---

## Files

- `src/gameplay/player/air_tuning.gd`
- `src/gameplay/player/air_supply.gd`
- `src/ui/hud/air_meter.gd`
- `src/ui/hud/air_meter.tscn`
- `assets/data/air_tuning.tres`
- `src/gameplay/player/player.gd`
- `src/gameplay/player/grey_box_room.tscn`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory), but a screenshot of an on-screen element is not.*

**Story Type**: Logic
**Required evidence**: `tests/unit/dead-air/air_supply_test.gd` (advisory at `qa.level: minimal`); retained screenshot of the HUD meter in `production/qa/evidence/`

**Status**: [x] Automated test waived (qa.level minimal) — screenshot retained in `production/qa/evidence/story-002-air-supply-hud/`

---

## Dependencies

- Depends on: `production/epics/dead-air/story-001-player-movement-carry-weight.md`
- Unlocks: `production/epics/dead-air/story-003-salvage-pickups.md`, `production/epics/dead-air/story-005-run-end.md`

---

## Completion Notes
**Completed**: 2026-11-07
**Criteria**: 7/7 passing (none deferred)
**Deviations**: Edited story-001 files `player.gd` and `grey_box_room.tscn` (story 001's evidence stamp is now older than that code); half and empty screenshots came from ticking the supply directly, not a live run; HUD meter is default grey and uses fixed pixel offsets (polish step); `max_weight` of 0 and unassigned `air_tuning` or `player` are unguarded.
**Test Evidence**: waived at qa.level minimal; screenshots retained at `production/qa/evidence/story-002-air-supply-hud/`
**Reviewed by**: self, no independent review
