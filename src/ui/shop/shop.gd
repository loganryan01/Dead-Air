class_name Shop
extends CanvasLayer
## Between-run shop. Display only: shows cash and the air upgrade, and requests actions.
## Implements: design/game-brief.md MVP feature 6; story-006-shop-air-upgrade.

## Emitted when the player presses Buy. The owner decides whether the purchase happens.
signal buy_requested
## Emitted when the player presses Dive.
signal dive_requested

@onready var _cash: Label = $Center/Panel/Box/Cash
@onready var _level: Label = $Center/Panel/Box/Level
@onready var _bonus: Label = $Center/Panel/Box/Bonus
@onready var _price: Label = $Center/Panel/Box/Price
@onready var _reason: Label = $Center/Panel/Box/Reason
@onready var _buy: Button = $Center/Panel/Box/Buy
@onready var _dive: Button = $Center/Panel/Box/Dive


func _ready() -> void:
	_buy.pressed.connect(buy_requested.emit)
	_dive.pressed.connect(dive_requested.emit)
	_buy.focus_neighbor_bottom = _dive.get_path()
	_buy.focus_neighbor_top = _dive.get_path()
	_dive.focus_neighbor_top = _buy.get_path()
	_dive.focus_neighbor_bottom = _buy.get_path()


## Refreshes the display. Buy is disabled (with a reason) when cash < price, or at max level.
## `bonus_text` is the ready-made "air per level" line.
func show_state(cash: float, level: int, max_level: int, price: float, bonus_text: String) -> void:
	var maxed: bool = level >= max_level
	var affordable: bool = not maxed and cash >= price
	_cash.text = "Cash: %d" % roundi(cash)
	_bonus.text = bonus_text
	if maxed:
		_level.text = "More air: MAXED"
		_price.text = "MAXED"
		_reason.text = ""
	else:
		_level.text = "More air: Level %d / %d" % [level, max_level]
		_price.text = "Price: %d" % roundi(price)
		_reason.text = "" if affordable else "Not enough cash: need %d" % roundi(price)
	_buy.disabled = not affordable
	_buy.focus_mode = Control.FOCUS_ALL if affordable else Control.FOCUS_NONE
	if visible and not (_buy.has_focus() and affordable):
		(_buy if affordable else _dive).grab_focus()
