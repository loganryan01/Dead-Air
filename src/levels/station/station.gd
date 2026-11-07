extends Node3D
## The grey-box station level. Wires the collapse timer to its HUD readout.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse.
## Story 005: RunState ends the run; its run_ended signal drives the RunResult screen.

@onready var _timer: CollapseTimer = $CollapseTimer
@onready var _meter: CollapseMeter = $CollapseMeter
@onready var _run_state: RunState = $RunState
@onready var _result: RunResult = $RunResult


func _ready() -> void:
	_timer.time_changed.connect(_meter.show_time)
	_run_state.run_ended.connect(_result.show_result)
