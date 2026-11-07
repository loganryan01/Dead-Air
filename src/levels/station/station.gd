extends Node3D
## The grey-box station level. Wires the collapse timer to its HUD readout.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse.
## The airlock_reached and station_collapsed signals only fire here; story 005 handles them.

@onready var _timer: CollapseTimer = $CollapseTimer
@onready var _meter: CollapseMeter = $CollapseMeter


func _ready() -> void:
	_timer.time_changed.connect(_meter.show_time)
