class_name Airlock
extends Area3D
## The station exit. Fires airlock_reached once when the Player enters.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse.

## Emitted exactly once, the first time the Player enters the airlock.
signal airlock_reached

var _reached: bool = false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if _reached or not body is Player:
		return
	_reached = true
	airlock_reached.emit()
