# Story 005: Run end: cash-out or loss

> **Epic**: Dead Air
> **Status**: Complete
> **Layer**: N/A (minimal)
> **Type**: Logic
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-08

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 5 (run end: success cashes out salvage, failure drops it)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using any scene-change or save API.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's Player goal & fail state:*

- [ ] Reaching the airlock ends the run as a success: carried salvage value is added to total cash.
- [ ] Air reaching zero ends the run as a failure: carried salvage is lost and total cash is unchanged.
- [ ] The station collapsing before the airlock ends the run as a failure with the same loss.
- [ ] A run can end only once, even if two end conditions fire in the same frame.
- [ ] After a run ends, the player sees a result (success with amount banked, or failure) and can start another dive.
- [ ] Total cash persists between runs in the same session and is the only value kept.
- [ ] The outcome calculation is a pure function a unit test can call.

---

## Implementation Notes

- Listen for `air_depleted` (story 002), `airlock_reached` and `station_collapsed` (story 004).
- A single run-state script owns "active or ended" so duplicate end signals are ignored.
- No save file at this tier; total cash lives only in memory (the brief rules out a save system beyond total cash, which can be added later if wanted).

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 006: spending cash in the shop

---

## Files

- `src/gameplay/run/run_outcome.gd`
- `src/gameplay/run/game_session.gd`
- `src/gameplay/run/run_state.gd`
- `src/ui/run_result/run_result.gd`
- `src/ui/run_result/run_result.tscn`
- `src/levels/station/station.gd`
- `src/levels/station/station.tscn`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory), but a screenshot of an on-screen result is not.*

**Story Type**: Logic
**Required evidence**: `tests/unit/dead-air/run_end_test.gd` (advisory at `qa.level: minimal`); retained screenshot of the result screen in `production/qa/evidence/`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/dead-air/story-002-air-supply-hud.md`, `production/epics/dead-air/story-004-station-airlock-collapse.md`
- Unlocks: `production/epics/dead-air/story-006-shop-air-upgrade.md`

---

## Completion Notes
**Completed**: 2026-11-08
**Criteria**: 7/7 passing (none deferred)
**Deviations**: `GameSession.total_cash` is a `static var`, against `.claude/rules/gameplay-code.md` (logged TD-001); Dive again button overflows the result panel (TD-002); result strings hardcoded, no `tr()` (TD-003); `run_state.gd` uses `get_node("../...")` string paths (TD-004); end conditions forced by probes, not played by hand.
**Test Evidence**: waived at qa.level minimal; screenshots retained at `production/qa/evidence/story-005-run-end/`
**Reviewed by**: self, no independent review
