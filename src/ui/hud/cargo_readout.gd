class_name CargoReadout
extends CanvasLayer
## HUD readout of carried salvage value and carry weight. Read-only view of Player.
## Implements: design/game-brief.md art direction (HUD); story-008-hud-polish.
## Must come after the Player in the scene tree so Player.cargo and Player.carry exist.

## The player whose cargo and carry weight are displayed.
@export var player: Player

@onready var _label: Label = $Root/Label


func _ready() -> void:
	player.cargo.salvage_picked_up.connect(_refresh.unbind(1))
	player.carry.carry_weight_changed.connect(_refresh.unbind(1))
	_refresh()


## Hides the readout. Call when the run ends (cash-out or loss).
func clear() -> void:
	visible = false


func _refresh() -> void:
	_label.text = "Cargo: %d  Weight: %d/%d" % [
		roundi(player.cargo.get_total_value()),
		roundi(player.carry.weight),
		roundi(player.tuning.max_weight),
	]
