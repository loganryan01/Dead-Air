class_name Player
extends CharacterBody3D
## First-person player with carry-weight-scaled movement.
## Implements: design/game-brief.md MVP feature 1; story-001-player-movement-carry-weight;
## story-007-jetpack (hold Space to fire the jetpack; it burns extra air).
## Controls: WASD move, Space jetpack, mouse look, Esc releases the mouse (click recaptures).
## The jetpack lives in _physics_process, so it stops when the run ends
## (RunState disables physics processing on the player).

## Tuning data (assets/data/movement_tuning.tres).
@export var tuning: MovementTuning

## Air tuning data (assets/data/air_tuning.tres).
@export var air_tuning: AirTuning

## Jetpack tuning data (assets/data/jetpack.tres).
@export var jetpack_tuning: JetpackTuning

## Extra starting air from upgrades (story 006). Set before add_child; read in _ready.
var air_bonus: float = 0.0

## Carry weight state. Other systems add/drop weight through this.
var carry: CarryWeight = CarryWeight.new()

## Carried salvage value total (story 003). Salvage pickups add to this.
var cargo: Cargo = Cargo.new()

## Air supply state (story 002). Created in _ready; drains faster with carry weight.
var air: AirSupply

@onready var _camera: Camera3D = $Camera3D


func _ready() -> void:
	air = AirSupply.new(air_tuning, air_bonus)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * tuning.mouse_sensitivity)
		_camera.rotate_x(-event.relative.y * tuning.mouse_sensitivity)
		_camera.rotation.x = clampf(_camera.rotation.x, -PI * 0.49, PI * 0.49)
	elif event is InputEventMouseButton and event.pressed:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event is InputEventKey and event.pressed and not event.echo:
		match event.physical_keycode:
			KEY_ESCAPE:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _physics_process(delta: float) -> void:
	var thrust: float = Jetpack.thrust(jetpack_tuning, carry.weight)
	var firing: bool = Jetpack.is_firing(Input.is_action_pressed("jetpack"), thrust, air.air)
	air.tick(
		delta, carry.weight, tuning.max_weight,
		jetpack_tuning.extra_air_per_second if firing else 0.0
	)

	# Gravity also applies while firing on the floor so the net lift is thrust minus gravity.
	if firing or not is_on_floor():
		velocity += get_gravity() * tuning.gravity_scale * delta

	if firing:
		velocity.y += thrust * delta

	var input_dir: Vector2 = Vector2(
		float(Input.is_physical_key_pressed(KEY_D)) - float(Input.is_physical_key_pressed(KEY_A)),
		float(Input.is_physical_key_pressed(KEY_S)) - float(Input.is_physical_key_pressed(KEY_W))
	)
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	var speed: float = carry.current_speed(tuning)
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed

	move_and_slide()
