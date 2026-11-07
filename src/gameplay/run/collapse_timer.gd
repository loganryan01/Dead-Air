class_name CollapseTimer
extends Node
## Counts down from the moment it enters the tree. Fires station_collapsed once at zero.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse.

## Emitted every frame while counting, and once at zero, with the seconds left.
signal time_changed(remaining: float)
## Emitted exactly once when the remaining time reaches zero.
signal station_collapsed

## Tuning data (assets/data/station_tuning.tres).
@export var tuning: StationTuning

## Seconds left before the station collapses.
var remaining: float = 0.0


func _ready() -> void:
	remaining = tuning.collapse_seconds


func _process(delta: float) -> void:
	remaining = maxf(remaining - delta, 0.0)
	time_changed.emit(remaining)
	if remaining <= 0.0:
		set_process(false)
		station_collapsed.emit()
