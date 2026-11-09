class_name Station
extends Node3D
## The station level. Wires the collapse timer to its HUD readout, applies the art tuning.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse.
## Story 005: RunState ends the run; its run_ended signal drives the RunResult screen.
## Story 006: Game injects the session and air bonus via configure() and listens for run_closed.
## Story 009: applies environment/light tuning and switches station lights to alarm red.

## Emitted when the player dismisses the result screen.
signal run_closed

## Group holding every EmergencyLight (station lights and the airlock light).
const LIGHT_GROUP: StringName = &"emergency_lights"

var _alarm_active: bool = false

@onready var _timer: CollapseTimer = $CollapseTimer
@onready var _meter: CollapseMeter = $CollapseMeter
@onready var _run_state: RunState = $RunState
@onready var _result: RunResult = $RunResult
@onready var _cargo_readout: CargoReadout = $CargoReadout
@onready var _world_environment: WorldEnvironment = $WorldEnvironment


func _ready() -> void:
	_timer.time_changed.connect(_meter.show_time.bind(_timer.tuning.collapse_seconds))
	_timer.time_changed.connect(_on_time_changed)
	_run_state.run_ended.connect(_result.show_result)
	_run_state.run_ended.connect(_cargo_readout.clear.unbind(3))
	_result.continue_pressed.connect(run_closed.emit)
	_apply_art_tuning(_timer.tuning)


## Injects run inputs. Call on the instance BEFORE add_child: children read them in _ready.
func configure(session: GameSession, air_bonus: float) -> void:
	(get_node("RunState") as RunState).session = session
	(get_node("Player") as Player).air_bonus = air_bonus


func _apply_art_tuning(tuning: StationTuning) -> void:
	var env: Environment = _world_environment.environment
	env.background_color = tuning.background_color
	env.ambient_light_color = tuning.ambient_color
	env.ambient_light_energy = tuning.ambient_energy
	env.fog_light_color = tuning.fog_color
	env.fog_density = tuning.fog_density
	for node: Node in get_tree().get_nodes_in_group(LIGHT_GROUP):
		if node is EmergencyLight:
			(node as EmergencyLight).configure(tuning)


func _on_time_changed(remaining: float) -> void:
	if _alarm_active or remaining > _timer.tuning.alarm_seconds:
		return
	_alarm_active = true
	for node: Node in get_tree().get_nodes_in_group(LIGHT_GROUP):
		if node is EmergencyLight:
			(node as EmergencyLight).set_alarm(true)
