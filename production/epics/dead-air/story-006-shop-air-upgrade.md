# Story 006: Between-run shop and air upgrade

> **Epic**: Dead Air
> **Status**: Ready
> **Layer**: N/A (minimal)
> **Type**: UI
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

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

- `src/ui/shop/shop.tscn`
- `src/ui/shop/shop.gd`
- `src/gameplay/progression/upgrades.gd`
- `assets/data/upgrade_air.tres`
- `tests/unit/dead-air/upgrades_test.gd`

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory), but a UI story's retained screenshot is not.*

**Story Type**: UI
**Required evidence**: retained screenshot of each shop state in `production/qa/evidence/`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/dead-air/story-005-run-end.md`
- Unlocks: None
