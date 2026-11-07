class_name AirMeter
extends CanvasLayer
## HUD air meter: a bar plus a number. Read-only view of Player.air; never changes air.
## Implements: design/game-brief.md MVP feature 2; story-002-air-supply-hud.
## Must come after the Player in the scene tree so Player.air exists in _ready.

## The player whose air supply is displayed.
@export var player: Player

@onready var _bar: ProgressBar = $Bar
@onready var _label: Label = $Bar/Label


func _ready() -> void:
	player.air.air_changed.connect(_on_air_changed)
	player.air.announce()


func _on_air_changed(current: float, maximum: float) -> void:
	_bar.max_value = maximum
	_bar.value = current
	_label.text = str(ceili(current))
