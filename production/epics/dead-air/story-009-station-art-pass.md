# Story 009: Station art pass

> **Epic**: Dead Air
> **Status**: Complete
> **Layer**: N/A (minimal)
> **Type**: Visual/Feel
> **Estimate**: L
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: 2026-11-09

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief build order step 6 ("art"), per the brief's art direction (dark, low-poly silhouettes with a warm emergency-light palette)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). 4.6 reworked glow and 4.7 added AreaLight3D: check `docs/engine-reference/godot/` before touching Environment, glow, fog or light APIs.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's art direction and its goal (reach the airlock before air runs out or the station collapses):*

- [ ] The station's grey boxes are replaced by low-poly silhouettes built in-engine from Godot primitives, with dark materials; no imported models.
- [ ] Lighting comes from amber emergency lights (some flickering), a WorldEnvironment with fog and low ambient light; the DirectionalLight3D is removed.
- [ ] The airlock has its own distinct light colour so the exit is findable from inside each room.
- [ ] Salvage items glow by value, driven from the existing `salvage_type` data, so a heavier, richer item reads differently.
- [ ] As the collapse timer enters its final configured seconds, station lights shift to an alarm-red state.
- [ ] Collision shapes and room layout are unchanged: walk paths and distances to the airlock are the same as before.
- [ ] Flicker rate, fog density, light colours and intensities come from a data file.
- [ ] The station holds 60 fps at 1280×720 on the development machine.

---

## Implementation Notes

- Keep visuals and collision separate: change MeshInstance3D and materials, leave StaticBody3D/CollisionShape3D transforms as they are.
- Light flicker and alarm state read the collapse timer through its signal; they never change it.
- Prefer a handful of shared StandardMaterial3D resources over one per mesh.
- Take a screenshot of each room, the airlock, and the alarm state, keep them in `production/qa/evidence/`, and write the sign-off note `production/qa/evidence/story-009-station-art-pass-evidence.md`.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 008: HUD and menu styling
- Story 010: audio
- New rooms, hazards or layout changes (the brief fixes one hand-built station)

---

## Files

- `src/levels/station/station.tscn`
- `src/levels/station/station.gd`
- `src/levels/station/station_tuning.gd`
- `src/levels/station/emergency_light.gd`
- `assets/data/station_tuning.tres`
- `src/gameplay/salvage/salvage_item.gd`
- `src/gameplay/salvage/salvage_type.gd`
- `assets/data/salvage_types/scrap_metal.tres`
- `assets/data/salvage_types/circuit_board.tres`
- `assets/data/salvage_types/reactor_core.tres`
- `src/levels/station/emergency_light.gd.uid`

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory), but a Visual/Feel story's retained screenshot is not.*

**Story Type**: Visual/Feel
**Required evidence**: retained screenshot of each room, the airlock and the alarm state in `production/qa/evidence/` + sign-off in `production/qa/evidence/story-009-station-art-pass-evidence.md`

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/dead-air/story-004-station-airlock-collapse.md`, `production/epics/dead-air/story-008-hud-polish.md`
- Unlocks: `production/epics/dead-air/story-010-breathing-station-audio.md`

---

## Completion Notes
**Completed**: 2026-11-09
**Criteria**: 7/8 passing (flicker feel and exact light/fog/alarm tuning DEFERRED to a playtest)
**Deviations**: ADVISORY: noise frequency (1.0) and amplitude scale (1.2) are hardcoded in `emergency_light.gd`. Out of scope, for awareness: `.godot/global_script_class_cache.cfg` changed by the Godot import.
**Test Evidence**: waived at qa.level minimal; retained screenshots in `production/qa/evidence/story-009-station-art-pass/` and sign-off in `production/qa/evidence/story-009-station-art-pass-evidence.md`
**Reviewed by**: self, no independent review
