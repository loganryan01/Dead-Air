class_name AirMeter
extends CanvasLayer
## HUD air meter: a bar plus a number. Read-only view of Player.air; never changes air.
## The bar colour follows HudTuning thresholds and pulses while critical.
## Implements: design/game-brief.md MVP feature 2; story-002-air-supply-hud; story-008-hud-polish.
## Must come after the Player in the scene tree so Player.air exists in _ready.

## The player whose air supply is displayed.
@export var player: Player

## HUD thresholds, colours and pulse rate (assets/data/hud_tuning.tres).
@export var tuning: HudTuning

var _fill: StyleBoxFlat
var _critical: bool = false
var _pulse_time: float = 0.0

@onready var _bar: ProgressBar = $Root/Bar
@onready var _label: Label = $Root/Bar/Label


func _ready() -> void:
	_fill = _bar.get_theme_stylebox(&"fill").duplicate()
	_bar.add_theme_stylebox_override(&"fill", _fill)
	set_process(false)
	player.air.air_changed.connect(_on_air_changed)
	player.air.announce()


func _process(delta: float) -> void:
	_pulse_time += delta
	var t: float = 0.5 + 0.5 * sin(TAU * tuning.pulse_hz * _pulse_time)
	_fill.bg_color = tuning.critical_color.lerp(tuning.critical_color.darkened(0.6), t)


func _on_air_changed(current: float, maximum: float) -> void:
	_bar.max_value = maximum
	_bar.value = current
	_label.text = str(ceili(current))
	var fraction: float = current / maximum
	_critical = fraction <= tuning.critical_air_fraction
	if _critical:
		set_process(true)
		return
	set_process(false)
	_pulse_time = 0.0
	_fill.bg_color = tuning.low_color if fraction <= tuning.low_air_fraction else tuning.normal_color
