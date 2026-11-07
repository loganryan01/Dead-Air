class_name GameSession
extends RefCounted
## In-memory state that outlives a single run: cash and upgrade level. No save file.
## Implements: design/game-brief.md MVP features 5 and 6; story-005-run-end, story-006.
## Owned by Game and injected into whatever needs it (resolves TD-001).

## Emitted after cash or upgrade level changes.
signal changed

## Cash banked across all runs this session.
var total_cash: float = 0.0
## Levels of the air upgrade owned.
var air_level: int = 0


## Adds cash from a finished run.
func bank(amount: float) -> void:
	total_cash += amount
	changed.emit()


## Buys the next air level if it is not maxed and cash covers it. Returns true on purchase.
func try_buy_air(tuning: UpgradeAirTuning) -> bool:
	if not Upgrades.can_afford(total_cash, air_level, tuning):
		return false
	total_cash -= Upgrades.price_for_level(air_level, tuning)
	air_level += 1
	changed.emit()
	return true
