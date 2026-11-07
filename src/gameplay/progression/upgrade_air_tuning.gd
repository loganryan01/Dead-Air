class_name UpgradeAirTuning
extends Resource
## Designer-tunable values for the one MVP upgrade: more starting air.
## Implements: design/game-brief.md MVP feature 6; story-006-shop-air-upgrade.
## Instance: assets/data/upgrade_air.tres

## Price of the first level, in cash.
@export var base_price: float = 50.0
## Price multiplier per level already owned. Price of level n+1 = base_price * price_growth^n.
@export var price_growth: float = 1.5
## Starting air added per level (same units as AirTuning.starting_air).
@export var air_bonus_per_level: float = 15.0
## Highest level that can be bought.
@export var max_level: int = 4
