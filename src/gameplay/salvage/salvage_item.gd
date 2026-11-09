class_name SalvageItem
extends Area3D
## A salvage pickup. Walking the Player into it adds weight and value, then removes it.
## Implements: design/game-brief.md MVP feature 3; story-003-salvage-pickups;
## story-009-station-art-pass (emissive glow driven by SalvageType.glow_energy).

## What this item is (assets/data/salvage_types/*.tres).
@export var salvage_type: SalvageType

var _collected: bool = false

@onready var _mesh: MeshInstance3D = $Mesh


func _ready() -> void:
	var material: StandardMaterial3D = StandardMaterial3D.new()
	material.albedo_color = salvage_type.color
	material.emission_enabled = true
	material.emission = salvage_type.color
	material.emission_energy_multiplier = salvage_type.glow_energy
	_mesh.material_override = material
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if _collected or not body is Player:
		return
	_collected = true
	set_deferred("monitoring", false)
	var player: Player = body
	player.carry.add_weight(salvage_type.weight)
	player.cargo.add_salvage(salvage_type)
	queue_free()
