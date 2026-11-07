# Story 004: Station layout, airlock and collapse timer

> **Epic**: Dead Air
> **Status**: Ready
> **Layer**: N/A (minimal)
> **Type**: Integration
> **Estimate**: L
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 4 (one station layout with an airlock exit and a collapse timer)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using any scene, Area3D or Timer API.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's Player goal & fail state (fail: station collapses before the airlock) and MVP feature 4:*

- [ ] One hand-built station scene exists with a start point, several rooms, and an airlock exit.
- [ ] Salvage items are placed through the station, with heavier, more valuable items deeper in.
- [ ] A collapse timer starts when the run starts and its remaining time is visible to the player.
- [ ] Reaching the airlock fires an `airlock_reached` signal.
- [ ] When the timer reaches zero, a `station_collapsed` signal fires exactly once.
- [ ] Timer length comes from a data file.
- [ ] The station is set as the project's main scene so the game launches into it.

---

## Implementation Notes

- Grey-box rooms are enough; no final art.
- Hazards are fixed, not procedural (the brief rules out procedural generation).
- This story only fires the signals. What they do (cash out or lose) is story 005.
- Set `run/main_scene` in `project.godot` once the scene exists.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 005: what happens on airlock or collapse
- Art and audio polish

---

## Files

- `src/levels/station/station.tscn`
- `src/levels/station/station.gd`
- `src/levels/station/airlock.gd`
- `src/gameplay/run/collapse_timer.gd`
- `assets/data/station_tuning.tres`
- `tests/integration/dead-air/station_collapse_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory).*

**Story Type**: Integration
**Required evidence**: `tests/integration/dead-air/station_collapse_test.gd` OR a playtest note (advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/dead-air/story-003-salvage-pickups.md`
- Unlocks: `production/epics/dead-air/story-005-run-end.md`
