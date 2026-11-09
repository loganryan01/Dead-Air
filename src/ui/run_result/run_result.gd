class_name RunResult
extends CanvasLayer
## End-of-run result screen. Display only: shows the outcome and requests to leave.
## Implements: design/game-brief.md MVP feature 5; story-005-run-end; story-006 (continue).

## Emitted when the player presses the continue button.
signal continue_pressed

@onready var _headline: Label = $Root/Center/Panel/Box/Headline
@onready var _reason: Label = $Root/Center/Panel/Box/Reason
@onready var _banked: Label = $Root/Center/Panel/Box/Banked
@onready var _total: Label = $Root/Center/Panel/Box/Total
@onready var _button: Button = $Root/Center/Panel/Box/Continue


func _ready() -> void:
	_button.pressed.connect(continue_pressed.emit)


## Fills in and shows the screen. Connect to RunState.run_ended.
func show_result(reason: RunOutcome.Reason, banked_value: float, total_cash: float) -> void:
	var succeeded: bool = reason == RunOutcome.Reason.AIRLOCK
	_headline.text = "Escaped!" if succeeded else "Lost it all"
	match reason:
		RunOutcome.Reason.AIRLOCK:
			_reason.text = "You made it to the airlock."
		RunOutcome.Reason.AIR_DEPLETED:
			_reason.text = "You ran out of air."
		RunOutcome.Reason.STATION_COLLAPSED:
			_reason.text = "The station collapsed."
	_banked.text = "Banked this run: %d" % roundi(banked_value)
	_total.text = "Total cash: %d" % roundi(total_cash)
	visible = true
	_button.grab_focus()
