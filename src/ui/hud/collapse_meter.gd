class_name CollapseMeter
extends CanvasLayer
## HUD collapse countdown: a bar plus m:ss. Display only; never changes the timer.
## Turns the collapse-final colour in the last HudTuning.collapse_final_seconds.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse; story-008-hud-polish.

## HUD thresholds and colours (assets/data/hud_tuning.tres).
@export var tuning: HudTuning

var _fill: StyleBoxFlat

@onready var _bar: ProgressBar = $Root/Bar
@onready var _label: Label = $Root/Bar/Label


func _ready() -> void:
	_fill = _bar.get_theme_stylebox(&"fill").duplicate()
	_bar.add_theme_stylebox_override(&"fill", _fill)


## Shows the remaining seconds as m:ss (rounded up) and as a bar fraction of `total`.
func show_time(remaining: float, total: float) -> void:
	var seconds: int = ceili(remaining)
	_label.text = "%d:%02d" % [floori(seconds / 60.0), seconds % 60]
	_bar.max_value = total
	_bar.value = remaining
	var final: bool = remaining <= tuning.collapse_final_seconds
	_fill.bg_color = tuning.collapse_final_color if final else tuning.normal_color
