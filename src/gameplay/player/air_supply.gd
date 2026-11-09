class_name AirSupply
extends RefCounted
## Air supply state plus the pure load-to-drain calculation.
## Implements: design/game-brief.md MVP feature 2; story-002-air-supply-hud.
## Only fires air_depleted; what depletion means (run end) is story 005.

## Emitted whenever air changes (and once by announce() for initial display).
signal air_changed(current: float, maximum: float)
## Emitted exactly once, the first time air reaches zero.
signal air_depleted

## Current air, between 0 and maximum.
var air: float
## Air at the start of the run.
var maximum: float

var _tuning: AirTuning
var _depleted: bool = false


## Starts a run with full air: tuning.starting_air plus an optional upgrade bonus.
func _init(tuning: AirTuning, bonus: float = 0.0) -> void:
	_tuning = tuning
	maximum = tuning.starting_air + bonus
	air = maximum


## Emits air_changed with the current values so a listener can show the initial state.
func announce() -> void:
	air_changed.emit(air, maximum)


## Drains air for delta seconds at the rate for the given carry weight.
## extra_drain_per_second is added to the load-based rate (e.g. jetpack fuel burn).
## Does nothing once air is depleted.
func tick(
	delta: float, carry_weight: float, max_weight: float, extra_drain_per_second: float = 0.0
) -> void:
	if _depleted:
		return
	var rate: float = drain_per_second(
		carry_weight, max_weight, _tuning.base_drain_per_second, _tuning.load_multiplier
	) + extra_drain_per_second
	air = maxf(air - rate * delta, 0.0)
	air_changed.emit(air, maximum)
	if air <= 0.0:
		_depleted = true
		air_depleted.emit()


## Pure function: air lost per second for a carry weight.
## Returns base_drain_per_second at weight 0 and rises linearly to
## base_drain_per_second * (1 + load_multiplier) at max_weight (clamped beyond it).
static func drain_per_second(
	weight: float, max_weight: float, base_drain_per_second: float, load_multiplier: float
) -> float:
	var t: float = clampf(weight / max_weight, 0.0, 1.0)
	return base_drain_per_second * (1.0 + load_multiplier * t)
