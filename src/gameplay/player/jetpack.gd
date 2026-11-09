class_name Jetpack
extends RefCounted
## Pure jetpack math. Implements: story-007-jetpack.
## Gravity (9.8 m/s^2) opposes thrust, so the practical lift-off weight is lower
## than max_lift_weight (about 47 with the default tuning).
## The player calls this from _physics_process, so it stops when the run ends
## (RunState calls player.set_physics_process(false)).


## Pure function: upward acceleration (m/s^2) for a carry weight.
## Equals thrust_accel at weight 0, falls to exactly 0 at max_lift_weight and above.
static func thrust_for_weight(
	weight: float, thrust_accel: float, max_lift_weight: float, falloff_exponent: float
) -> float:
	if weight >= max_lift_weight:
		return 0.0
	var t: float = clampf(weight / max_lift_weight, 0.0, 1.0)
	return thrust_accel * (1.0 - pow(t, falloff_exponent))


## Thrust (m/s^2) for the given carry weight using the tuning data.
static func thrust(tuning: JetpackTuning, weight: float) -> float:
	return thrust_for_weight(
		weight, tuning.thrust_accel, tuning.max_lift_weight, tuning.weight_falloff_exponent
	)


## True when the jetpack fires: input held, thrust above zero and air remaining.
static func is_firing(input_held: bool, current_thrust: float, air_left: float) -> bool:
	return input_held and current_thrust > 0.0 and air_left > 0.0
