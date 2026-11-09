class_name Station
extends Node3D
## The grey-box station level. Wires the collapse timer to its HUD readout.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse.
## Story 005: RunState ends the run; its run_ended signal drives the RunResult screen.
## Story 006: Game injects the session and air bonus via configure() and listens for run_closed.

## Emitted when the player dismisses the result screen.
signal run_closed

@onready var _timer: CollapseTimer = $CollapseTimer
@onready var _meter: CollapseMeter = $CollapseMeter
@onready var _run_state: RunState = $RunState
@onready var _result: RunResult = $RunResult
@onready var _cargo_readout: CargoReadout = $CargoReadout


func _ready() -> void:
	_timer.time_changed.connect(_meter.show_time.bind(_timer.tuning.collapse_seconds))
	_run_state.run_ended.connect(_result.show_result)
	_run_state.run_ended.connect(_cargo_readout.clear.unbind(3))
	_result.continue_pressed.connect(run_closed.emit)


## Injects run inputs. Call on the instance BEFORE add_child: children read them in _ready.
func configure(session: GameSession, air_bonus: float) -> void:
	(get_node("RunState") as RunState).session = session
	(get_node("Player") as Player).air_bonus = air_bonus
