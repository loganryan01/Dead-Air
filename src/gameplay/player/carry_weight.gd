class_name CarryWeight
extends RefCounted
## Carry weight state plus the pure weight-to-speed calculation.
## Implements: design/game-brief.md MVP feature 1 (carry-weight penalty).

## Emitted after the weight value changes.
signal carry_weight_changed(new_weight: float)

## Current carry weight, a single number. Never negative.
var weight: float = 0.0


## Raises carry weight by amount (ignored if not positive).
func add_weight(amount: float) -> void:
	if amount <= 0.0:
		return
	weight += amount
	carry_weight_changed.emit(weight)


## Lowers carry weight by amount, clamped so weight never goes below zero.
func drop_weight(amount: float) -> void:
	if amount <= 0.0:
		return
	weight = maxf(weight - amount, 0.0)
	carry_weight_changed.emit(weight)


## Current move speed for this weight, using the given tuning data.
func current_speed(tuning: MovementTuning) -> float:
	return speed_for_weight(
		weight, tuning.base_speed, tuning.min_speed, tuning.max_weight, tuning.curve_exponent
	)


## Pure function: move speed for a carry weight.
## Returns base_speed at weight 0, falls along pow(weight / max_weight, curve_exponent)
## and is never below min_speed (also when weight exceeds max_weight).
static func speed_for_weight(
	weight: float,
	base_speed: float,
	min_speed: float,
	max_weight: float,
	curve_exponent: float
) -> float:
	var t: float = clampf(weight / max_weight, 0.0, 1.0)
	var speed: float = base_speed - (base_speed - min_speed) * pow(t, curve_exponent)
	return maxf(speed, min_speed)
