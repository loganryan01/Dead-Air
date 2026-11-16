class_name Breathing
extends Node
## Muffled helmet breathing loop. Rate and volume rise with the air drain rate (carry load);
## below the low-air threshold it turns ragged. Read-only: listens to air signals and reads
## Player.carry.weight, never changes air or load.
## Implements: design/game-brief.md audio direction; story-010-breathing-station-audio.
## Must come after the Player in the scene tree so Player.air exists in _ready.

## The player whose air and load drive the breathing.
@export var player: Player
## Audio tuning data (assets/data/audio_tuning.tres).
@export var tuning: AudioTuning
## Source of the low-air threshold (low_air_fraction), shared with the HUD.
@export var hud_tuning: HudTuning
## Run state; breathing stops when the run ends.
@export var run_state: RunState

var _voice: AudioStreamPlayer
var _normal_stream: AudioStream
var _ragged_stream: AudioStream
var _ragged: bool = false
var _rate: float = 1.0
var _volume_db: float = 0.0


func _ready() -> void:
	tuning.apply_to_buses()
	_voice = AudioStreamPlayer.new()
	_voice.bus = AudioTuning.HELMET_BUS
	add_child(_voice)
	_normal_stream = AudioTuning.load_stream(tuning.breathing_loop_path)
	_ragged_stream = AudioTuning.load_optional_stream(tuning.breathing_ragged_path)
	_enable_loop(_normal_stream)
	_enable_loop(_ragged_stream)
	player.air.air_changed.connect(_on_air_changed)
	if run_state != null:
		run_state.run_ended.connect(_on_run_ended.unbind(3))
	_rate = _target_rate(0.0)
	_volume_db = _target_volume_db(0.0)
	if _normal_stream == null:
		set_process(false)
		return
	_apply_stream()
	_voice.pitch_scale = maxf(_rate, AudioTuning.MIN_PITCH_SCALE)
	_voice.volume_db = _volume_db
	_voice.play()


func _exit_tree() -> void:
	_voice.stop()
	_voice.stream = null


func _process(delta: float) -> void:
	var intensity: float = _load_intensity()
	var weight: float = 1.0
	if tuning.breath_smoothing_seconds > 0.0:
		weight = clampf(delta / tuning.breath_smoothing_seconds, 0.0, 1.0)
	_rate = lerpf(_rate, _target_rate(intensity), weight)
	_volume_db = lerpf(_volume_db, _target_volume_db(intensity), weight)
	_voice.pitch_scale = maxf(_rate, AudioTuning.MIN_PITCH_SCALE)
	_voice.volume_db = _volume_db


## Pure function: 0 at the base drain rate, 1 at the fully loaded drain rate
## (base * (1 + load_multiplier)). Clamped to 0..1; 0 if the span is zero.
static func load_intensity_for_drain(drain: float, base_drain: float, load_multiplier: float) -> float:
	var span: float = base_drain * load_multiplier
	if span <= 0.0:
		return 0.0
	return clampf((drain - base_drain) / span, 0.0, 1.0)


## Pure function: value between rest and full_load, shaped by pow(intensity, exponent).
## Used for both the breathing rate and its volume (dB).
static func curve_value(intensity: float, rest: float, full_load: float, exponent: float) -> float:
	var t: float = pow(clampf(intensity, 0.0, 1.0), maxf(exponent, 0.0))
	return lerpf(rest, full_load, t)


## Pure function: true when air fraction is at or below the low threshold.
static func is_air_low(current: float, maximum: float, low_fraction: float) -> bool:
	return maximum > 0.0 and current / maximum <= low_fraction


func _load_intensity() -> float:
	var air_tuning: AirTuning = player.air_tuning
	var drain: float = AirSupply.drain_per_second(
		player.carry.weight, player.tuning.max_weight,
		air_tuning.base_drain_per_second, air_tuning.load_multiplier
	)
	return load_intensity_for_drain(
		drain, air_tuning.base_drain_per_second, air_tuning.load_multiplier
	)


func _target_rate(intensity: float) -> float:
	var rate: float = curve_value(
		intensity, tuning.breath_rate_rest, tuning.breath_rate_full_load, tuning.breath_curve_exponent
	)
	if _ragged and _ragged_stream == null:
		rate *= tuning.ragged_rate_multiplier
	return rate


func _target_volume_db(intensity: float) -> float:
	var db: float = curve_value(
		intensity, tuning.breath_volume_db_rest, tuning.breath_volume_db_full_load,
		tuning.breath_curve_exponent
	)
	if _ragged:
		db += tuning.ragged_volume_boost_db
	return db


func _on_air_changed(current: float, maximum: float) -> void:
	var low: bool = is_air_low(current, maximum, hud_tuning.low_air_fraction)
	if low == _ragged:
		return
	_ragged = low
	if _normal_stream != null and _ragged_stream != null:
		_apply_stream()
		_voice.play()


func _apply_stream() -> void:
	if _ragged and _ragged_stream != null:
		_voice.stream = _ragged_stream
	else:
		_voice.stream = _normal_stream


func _on_run_ended() -> void:
	set_process(false)
	_voice.stop()


func _enable_loop(stream: AudioStream) -> void:
	if stream is AudioStreamOggVorbis:
		(stream as AudioStreamOggVorbis).loop = true
	elif stream is AudioStreamWAV:
		(stream as AudioStreamWAV).loop_mode = AudioStreamWAV.LOOP_FORWARD
	elif stream is AudioStreamMP3:
		(stream as AudioStreamMP3).loop = true
