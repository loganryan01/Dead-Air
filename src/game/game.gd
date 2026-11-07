class_name Game
extends Node
## Root scene. Owns the GameSession and the shop <-> run transitions.
## Implements: design/game-brief.md core loop; story-006-shop-air-upgrade (resolves TD-001).

## Air upgrade data (assets/data/upgrade_air.tres).
@export var air_upgrade: UpgradeAirTuning

const STATION_SCENE: PackedScene = preload("res://src/levels/station/station.tscn")

## Cash and upgrade levels for this session. Injected into each run.
var session: GameSession = GameSession.new()

var _station: Station

@onready var _shop: Shop = $Shop


func _ready() -> void:
	_shop.buy_requested.connect(_on_buy_requested)
	_shop.dive_requested.connect(_on_dive_requested)
	session.changed.connect(_refresh_shop)
	_refresh_shop()


func _refresh_shop() -> void:
	var level: int = session.air_level
	_shop.show_state(
		session.total_cash,
		level,
		air_upgrade.max_level,
		Upgrades.price_for_level(level, air_upgrade),
		"+%d air per level" % roundi(air_upgrade.air_bonus_per_level)
	)


func _on_buy_requested() -> void:
	session.try_buy_air(air_upgrade)


func _on_dive_requested() -> void:
	if _station != null:
		return
	get_viewport().gui_release_focus()
	_shop.visible = false
	_station = STATION_SCENE.instantiate()
	_station.configure(session, Upgrades.air_bonus(session.air_level, air_upgrade))
	_station.run_closed.connect(_on_run_closed)
	add_child(_station)


func _on_run_closed() -> void:
	_station.queue_free()
	_station = null
	_shop.visible = true
	_refresh_shop()
