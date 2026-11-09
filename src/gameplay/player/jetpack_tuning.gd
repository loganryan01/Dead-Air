class_name JetpackTuning
extends Resource
## Designer-tunable jetpack values.
## Implements: story-007-jetpack (air is the fuel; carried weight reduces thrust).
## Instance: assets/data/jetpack.tres

## Upward acceleration (m/s^2) at zero carry weight.
@export var thrust_accel: float = 24.0
## Extra air drained per second while the jetpack fires, on top of the load-based drain.
@export var extra_air_per_second: float = 5.0
## Shape of thrust vs weight. 1.0 is linear, above 1.0 keeps thrust high longer
## then drops sharply, below 1.0 loses thrust quickly at first.
@export var weight_falloff_exponent: float = 1.0
## Carry weight at or above which thrust is zero.
@export var max_lift_weight: float = 80.0
