class_name RunState
extends Node
## Owns "run active or ended". Ends the run once, banks cash, then freezes the run.
## Implements: design/game-brief.md MVP feature 5; story-005-run-end.
## Must come after Player in station.tscn: Player.air is created in Player._ready.

## Emitted exactly once per run, with the reason, cash banked this run and the new session total.
signal run_ended(reason: RunOutcome.Reason, banked_value: float, total_cash: float)

## Session that receives banked cash. Inject before add_child; a throwaway one is made if absent.
var session: GameSession

var _ended: bool = false

@onready var _player: Player = get_node("../Player")
@onready var _timer: CollapseTimer = get_node("../CollapseTimer")


func _ready() -> void:
	if session == null:
		session = GameSession.new()
	var airlock: Airlock = get_node("../Airlock")
	airlock.airlock_reached.connect(_end_run.bind(RunOutcome.Reason.AIRLOCK))
	_player.air.air_depleted.connect(_end_run.bind(RunOutcome.Reason.AIR_DEPLETED))
	_timer.station_collapsed.connect(_end_run.bind(RunOutcome.Reason.STATION_COLLAPSED))


func _end_run(reason: RunOutcome.Reason) -> void:
	if _ended:
		return
	_ended = true
	var banked: float = RunOutcome.banked_value(reason, _player.cargo.get_total_value())
	session.bank(banked)

	_timer.set_process(false)
	_player.set_physics_process(false)
	_player.set_process_unhandled_input(false)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	run_ended.emit(reason, banked, session.total_cash)
