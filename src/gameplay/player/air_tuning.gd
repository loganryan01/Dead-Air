class_name AirTuning
extends Resource
## Designer-tunable air supply values.
## Implements: design/game-brief.md MVP feature 2; story-002-air-supply-hud.
## Instance: assets/data/air_tuning.tres

## Air at the start of a run (and the meter's maximum).
@export var starting_air: float = 60.0
## Air lost per second while carrying nothing.
@export var base_drain_per_second: float = 1.0
## Extra drain at full load, as a fraction of the base rate. Drain per second is
## base_drain_per_second * (1 + load_multiplier * clamp(weight / max_weight, 0, 1)).
## 2.0 means a fully loaded player drains at 3x the base rate.
@export var load_multiplier: float = 2.0
