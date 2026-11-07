class_name Cargo
extends RefCounted
## Running total of carried salvage value. Single owner; HUD and run end read it.
## Implements: design/game-brief.md MVP feature 3; story-003-salvage-pickups.

## Emitted after a salvage item has been added to the cargo.
signal salvage_picked_up(type: SalvageType)

var _total_value: float = 0.0


## Total value of all salvage currently carried.
func get_total_value() -> float:
	return _total_value


## Adds one salvage item's value to the total and emits salvage_picked_up.
## Does not touch carry weight; the caller adds that through CarryWeight.
func add_salvage(type: SalvageType) -> void:
	_total_value += type.value
	salvage_picked_up.emit(type)
