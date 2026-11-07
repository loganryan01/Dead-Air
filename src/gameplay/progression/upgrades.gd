class_name Upgrades
extends RefCounted
## Pure purchase math for the air upgrade. No state; the session applies the results.
## Implements: design/game-brief.md MVP feature 6; story-006-shop-air-upgrade.


## Price of buying the next level when `level` levels are owned, rounded to whole cash.
static func price_for_level(level: int, tuning: UpgradeAirTuning) -> float:
	return roundf(tuning.base_price * pow(tuning.price_growth, level))


## Total starting-air bonus at `level` owned levels (capped at max_level).
static func air_bonus(level: int, tuning: UpgradeAirTuning) -> float:
	return tuning.air_bonus_per_level * clampi(level, 0, tuning.max_level)


## True when no further level can be bought.
static func is_maxed(level: int, tuning: UpgradeAirTuning) -> bool:
	return level >= tuning.max_level


## True when the next level is available and `cash` covers its price.
static func can_afford(cash: float, level: int, tuning: UpgradeAirTuning) -> bool:
	return not is_maxed(level, tuning) and cash >= price_for_level(level, tuning)
