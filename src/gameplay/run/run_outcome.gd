class_name RunOutcome
extends RefCounted
## Pure run-end math: how much cash a finished run banks.
## Implements: design/game-brief.md MVP feature 5; story-005-run-end.

## Why a run ended.
enum Reason { AIRLOCK, AIR_DEPLETED, STATION_COLLAPSED }


## Pure function: cash banked when a run ends for the given reason.
## Reaching the airlock keeps the carried value; every failure reason loses it all.
static func banked_value(reason: Reason, carried_value: float) -> float:
	if reason == Reason.AIRLOCK:
		return carried_value
	return 0.0
