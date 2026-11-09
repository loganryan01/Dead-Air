# Story 008: HUD polish

> **Epic**: Dead Air
> **Status**: Complete
> **Layer**: N/A (minimal)
> **Type**: UI
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-09

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief build order step 6 ("HUD polish"), supporting Brief MVP feature 2 (visible HUD air meter)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using any Theme, StyleBox or Tween API.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's fail state (air hits zero or the station collapses) and art direction (warm emergency-light palette):*

- [ ] The air meter and collapse meter share one HUD Theme resource in the brief's palette (warm amber on near-black).
- [ ] The air bar changes colour at a configured low threshold and a configured critical threshold, and pulses while critical.
- [ ] The collapse meter shows a bar plus a countdown, and turns red in its configured final seconds.
- [ ] A HUD readout shows carried salvage value and carried weight, updating on pickup and on cash-out or loss.
- [ ] The run result and shop screens use the same Theme.
- [ ] Thresholds, colours and pulse rate come from a data file.
- [ ] All HUD text and bars are readable at 1280×720.

---

## Implementation Notes

- The HUD only reads state through signals or getters; it never changes air, cargo or the timer.
- One Theme resource under `assets/` (or `src/ui/`), applied at the root of each CanvasLayer, not per-node overrides.
- Replace the per-node `theme_override_*` styles in `run_result.tscn` and `shop.tscn` with the shared Theme.
- Take screenshots of the HUD at full, low and critical air, the collapse meter's final seconds, and the restyled result and shop screens, and keep them in `production/qa/evidence/`.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 009: station lighting, materials and geometry
- Story 010: low-air breathing audio and collapse creaks

---

## Files

- `src/ui/hud/hud_tuning.gd`
- `assets/data/hud_tuning.tres`
- `assets/ui/hud_theme.tres`
- `src/ui/hud/cargo_readout.gd`
- `src/ui/hud/cargo_readout.tscn`
- `src/ui/hud/air_meter.gd`
- `src/ui/hud/air_meter.tscn`
- `src/ui/hud/collapse_meter.gd`
- `src/ui/hud/collapse_meter.tscn`
- `src/ui/run_result/run_result.gd`
- `src/ui/run_result/run_result.tscn`
- `src/ui/shop/shop.gd`
- `src/ui/shop/shop.tscn`
- `src/levels/station/station.gd`
- `src/levels/station/station.tscn`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory), but a UI story's retained screenshot is not.*

**Story Type**: UI
**Required evidence**: retained screenshot of each screen touched (HUD at full, low and critical air; collapse final seconds; run result; shop) in `production/qa/evidence/`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/dead-air/story-002-air-supply-hud.md`, `production/epics/dead-air/story-004-station-airlock-collapse.md`, `production/epics/dead-air/story-006-shop-air-upgrade.md`
- Unlocks: `production/epics/dead-air/story-009-station-art-pass.md`

## Completion Notes
**Completed**: 2026-11-09
**Criteria**: 6/7 passing (critical-air pulse DEFERRED — feel, needs a playtest)
**Deviations**: None. Advisory nits not logged: `as StyleBoxFlat` casts in air_meter.gd:23 / collapse_meter.gd:17; unused `ProgressBar/colors/font_color` in hud_theme.tres
**Test Evidence**: waived at qa.level minimal; screenshots retained in `production/qa/evidence/story-008-hud-polish/` (01-full … 06-shop)
**Reviewed by**: self, no independent review (Godot specialist engine-API check found no problems)
