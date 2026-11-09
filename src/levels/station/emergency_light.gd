class_name EmergencyLight
extends OmniLight3D
## A station emergency light: amber, optionally flickering, switchable to alarm red.
## The airlock light is an EmergencyLight with airlock = true: it uses the airlock
## colour/energy/range and ignores the alarm.
## Implements: story-009-station-art-pass.
## Tuning: assets/data/station_tuning.tres (StationTuning); Station calls configure().

## Whether this light flickers (rate and depth come from StationTuning).
@export var flickers: bool = false
## Whether this is the airlock light (distinct colour, never turns alarm red).
@export var airlock: bool = false

var _tuning: StationTuning
var _base_energy: float = 0.0
var _noise_time: float = 0.0
var _noise: FastNoiseLite = FastNoiseLite.new()


func _ready() -> void:
	set_process(false)
	_noise.frequency = 1.0
	_noise.seed = randi()
	_noise_time = randf() * 100.0


## Applies tuning values to this light. Call once after the node is in the tree.
func configure(tuning: StationTuning) -> void:
	_tuning = tuning
	if airlock:
		light_color = tuning.airlock_light_color
		_base_energy = tuning.airlock_light_energy
		omni_range = tuning.airlock_light_range
	else:
		light_color = tuning.light_color
		_base_energy = tuning.light_energy
		omni_range = tuning.light_range
	light_energy = _base_energy
	set_process(flickers)


## Switches the light to the alarm colour (true) or back to its normal colour (false).
## The airlock light ignores this call.
func set_alarm(active: bool) -> void:
	if airlock or _tuning == null:
		return
	light_color = _tuning.alarm_color if active else _tuning.light_color


func _process(delta: float) -> void:
	_noise_time += delta * _tuning.flicker_rate
	var level: float = clampf(0.5 + _noise.get_noise_1d(_noise_time) * 1.2, 0.0, 1.0)
	light_energy = _base_energy * (1.0 - _tuning.flicker_depth * (1.0 - level))
