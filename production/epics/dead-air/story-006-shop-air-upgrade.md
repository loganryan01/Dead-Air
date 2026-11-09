# Story 006: Between-run shop and air upgrade

> **Epic**: Dead Air
> **Status**: Complete
> **Layer**: N/A (minimal)
> **Type**: UI
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-08

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief MVP feature 6 (between-run shop with one upgrade: more air)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using any Control, theme or input-focus API.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's core loop (cash out, buy air, dive again) and MVP feature 6:*

- [ ] A shop screen appears between runs showing total cash and the air upgrade with its price.
- [ ] Buying the upgrade deducts its price from total cash and raises starting air by a configured amount.
- [ ] The Buy button is disabled when cash is below the price, and the screen shows why.
- [ ] The upgrade can be bought repeatedly with a rising price, up to a configured limit; at the limit it shows as maxed.
- [ ] The raised starting air applies to the next dive (story 002 reads it).
- [ ] A Dive button starts the next run.
- [ ] Price, air bonus per level and level cap come from a data file.
- [ ] The shop is usable with keyboard/mouse, and with keyboard-only focus navigation.

---

## Implementation Notes

- This is the only upgrade in the MVP; do not add others (the brief rules them out).
- Purchase logic lives in its own script so the screen only displays and requests.
- Take a screenshot of the shop in three states (can afford, cannot afford, maxed) and keep them in `production/qa/evidence/`.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Any second upgrade, gear or cosmetics
- Saving cash between game sessions

---

## Files

- `src/game/game.gd`
- `src/game/game.tscn`
- `src/ui/shop/shop.gd`
- `src/ui/shop/shop.tscn`
- `src/gameplay/progression/upgrades.gd`
- `src/gameplay/progression/upgrade_air_tuning.gd`
- `assets/data/upgrade_air.tres`
- `src/gameplay/run/game_session.gd`
- `src/gameplay/run/run_state.gd`
- `src/gameplay/player/air_supply.gd`
- `src/gameplay/player/player.gd`
- `src/levels/station/station.gd`
- `src/ui/run_result/run_result.gd`
- `src/ui/run_result/run_result.tscn`
- `project.godot`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory), but a UI story's retained screenshot is not.*

**Story Type**: UI
**Required evidence**: retained screenshot of each shop state in `production/qa/evidence/`

**Status**: [x] Present — screenshots retained in `production/qa/evidence/story-006-shop-air-upgrade/`

---

## Dependencies

- Depends on: `production/epics/dead-air/story-005-run-end.md`
- Unlocks: None

---

## Completion Notes
**Completed**: 2026-11-08
**Criteria**: 8/8 passing (none deferred)
**Deviations**: Reworked story 001-005 code (player, air supply, station, run state, session, result screen, `project.godot` main scene), so earlier stories' evidence stamps are now older than their code; probes forced outcomes and set cash to 1000 to reach MAXED; mouse clicks on the shop unverified (TD-005); strings hardcoded (TD-003); standalone `station.tscn` result button does nothing (TD-006). Resolves TD-001 and TD-002.
**Test Evidence**: screenshots retained at `production/qa/evidence/story-006-shop-air-upgrade/`
**Reviewed by**: self, no independent review
