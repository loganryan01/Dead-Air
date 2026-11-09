# Story 010: Breathing and station audio

> **Epic**: Dead Air
> **Status**: Ready
> **Layer**: N/A (minimal)
> **Type**: Integration
> **Estimate**: M
> **Manifest Version**: N/A (minimal — no control manifest)
> **Last Updated**: [set by /dev-story when implementation begins]

## Context

**GDD**: `design/game-brief.md`
**Requirement**: Brief build order step 6 ("audio"), per the brief's audio direction (muffled breathing and creaking metal)

**ADR Governing Implementation**: N/A (minimal — no ADRs)
**ADR Decision Summary**: N/A (minimal — no ADRs)
**ADR Version**: N/A (minimal — no ADRs)

**Engine**: Godot 4.7.1 | **Risk**: HIGH
**Engine Notes**: none (no ADR engine-compatibility analysis at minimal). Check `docs/engine-reference/godot/` before using AudioServer bus, AudioEffect or AudioStreamPlayer APIs.

**Control Manifest Rules (this layer)**: N/A (minimal — no control manifest)

---

## Acceptance Criteria

*From the brief's fail state (air hits zero or the station collapses) and audio direction:*

- [ ] A breathing loop plays through a "Helmet" audio bus with a low-pass filter, so it sounds muffled.
- [ ] Breathing rate and volume rise as the air drain rate rises with carried load.
- [ ] Below the low-air threshold, breathing switches to a ragged variant (or pitch/rate change) until air recovers or the run ends.
- [ ] Creaking-metal sounds play at random intervals that shorten as the collapse timer runs down.
- [ ] Audio reads air and collapse state only through their signals or getters; it never changes them.
- [ ] A missing file in `assets/audio/` logs one warning and the game runs on silent for that sound, with no crash.
- [ ] Bus volumes, low-pass cutoff, breathing rate curve and creak interval curve come from a data file.

---

## Implementation Notes

- **Asset dependency:** the user supplies the files. Expected names: `assets/audio/breathing_loop.ogg`, optionally `assets/audio/breathing_ragged.ogg`, and one or more `assets/audio/creak_*.ogg`. Implementation can land before the files; playtest evidence cannot.
- Keep the rate and interval maths in a pure function so it is unit-testable without a scene.
- Sound cannot be screenshotted: record a short playtest note in `production/qa/evidence/` covering breathing under no load, full load, low air, and creaks near collapse.

---

## Out of Scope

*Handled by neighbouring stories — do not implement here:*

- Story 008: low-air visual warning on the HUD
- Story 009: alarm lighting near collapse
- Music, UI click sounds, pickup or airlock sounds (not in the brief's audio direction)

---

## Files

- `src/audio/breathing.gd` (new)
- `src/audio/station_creaks.gd` (new)
- `src/audio/audio_tuning.gd` (new)
- `assets/data/audio_tuning.tres` (new)
- `default_bus_layout.tres` (new)
- `src/levels/station/station.tscn`
- `assets/audio/` (user-supplied files)
- `tests/unit/dead-air/audio_curves_test.gd` (advisory at `qa.level: minimal`)

---

## QA Test Cases

*N/A — no qa-lead specs at this tier; implement against the Acceptance Criteria above*

---

## Test Evidence

*Governed by `qa.level`: at `qa.level: minimal` tests are waived (advisory).*

**Story Type**: Integration
**Required evidence**: `tests/integration/dead-air/station_audio_test.gd` OR a playtest note in `production/qa/evidence/` (advisory at `qa.level: minimal`)

**Status**: [ ] Not yet created

---

## Dependencies

- Depends on: `production/epics/dead-air/story-002-air-supply-hud.md`, `production/epics/dead-air/story-004-station-airlock-collapse.md`, `production/epics/dead-air/story-009-station-art-pass.md`
- Unlocks: None
