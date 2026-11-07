class_name SalvageType
extends Resource
## Designer-tunable definition of one kind of salvage.
## Implements: design/game-brief.md MVP feature 3; story-003-salvage-pickups.
## Instances: assets/data/salvage_types/*.tres

## Display name of the salvage type.
@export var display_name: String = "Salvage"
## Value added to the carried total on pickup.
@export var value: float = 10.0
## Carry weight added on pickup (same scale as MovementTuning.max_weight).
@export var weight: float = 5.0
## Tint of the grey-box mesh.
@export var color: Color = Color.WHITE
