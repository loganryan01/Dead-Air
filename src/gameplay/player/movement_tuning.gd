class_name MovementTuning
extends Resource
## Designer-tunable movement values for the player.
## Implements: design/game-brief.md MVP feature 1 (movement with carry-weight penalty).
## Instance: assets/data/movement_tuning.tres

## Speed (m/s) at zero carry weight.
@export var base_speed: float = 5.0
## Speed (m/s) floor; speed never drops below this however heavy the load.
@export var min_speed: float = 1.5
## Carry weight at which speed reaches min_speed.
@export var max_weight: float = 100.0
## Shape of the weight-to-speed curve. 1.0 is linear, above 1.0 keeps speed
## high longer then drops sharply, below 1.0 slows quickly at first.
@export var curve_exponent: float = 1.0
## Gravity multiplier applied to the engine's default gravity.
@export var gravity_scale: float = 1.0
## Mouse look sensitivity in radians per pixel.
@export var mouse_sensitivity: float = 0.003
## Weight added or removed per press of the grey-box debug keys (R / F).
@export var debug_weight_step: float = 10.0
