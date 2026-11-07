class_name CollapseMeter
extends CanvasLayer
## HUD collapse countdown, formatted m:ss. Display only; never changes the timer.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse.

@onready var _label: Label = $Label


## Shows the given remaining seconds as m:ss (rounded up).
func show_time(remaining: float) -> void:
	var seconds: int = ceili(remaining)
	_label.text = "%d:%02d" % [floori(seconds / 60.0), seconds % 60]
