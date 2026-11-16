class_name AudioTuning
extends Resource
## Designer-tunable audio values: file paths, bus levels, low-pass cutoff, curves.
## Implements: design/game-brief.md audio direction; story-010-breathing-station-audio.
## Instance: assets/data/audio_tuning.tres

## Name of the muffled bus the breathing plays through (default_bus_layout.tres).
const HELMET_BUS: StringName = &"Helmet"
## Name of the bus the station creaks play through (default_bus_layout.tres).
const STATION_BUS: StringName = &"Station"
## Engine safety floor for AudioStreamPlayer.pitch_scale, which errors at 0 or below.
## Not a tuning value: tuned rates are clamped to it so a bad data file cannot break playback.
const MIN_PITCH_SCALE: float = 0.01

@export_group("Files")
## Breathing loop. Missing file: one warning, breathing stays silent.
@export_file("*.ogg") var breathing_loop_path: String = "res://assets/audio/breathing_loop.ogg"
## Optional ragged breathing loop. If absent, the normal loop is pitched up instead.
@export_file("*.ogg") var breathing_ragged_path: String = "res://assets/audio/breathing_ragged.ogg"
## Creak one-shots; one is picked at random each time. Missing files warn once and are skipped.
@export var creak_paths: PackedStringArray = PackedStringArray([
	"res://assets/audio/creak_1.ogg",
	"res://assets/audio/creak_2.ogg",
	"res://assets/audio/creak_3.ogg",
])

@export_group("Buses")
## Volume of the Helmet bus in dB.
@export var helmet_bus_db: float = 0.0
## Volume of the Station bus in dB.
@export var station_bus_db: float = 0.0
## Low-pass cutoff on the Helmet bus in Hz (lower is more muffled).
@export var lowpass_cutoff_hz: float = 900.0

@export_group("Breathing")
## Loop playback speed (pitch_scale) with no load.
@export var breath_rate_rest: float = 0.85
## Loop playback speed at full load.
@export var breath_rate_full_load: float = 1.35
## Breathing volume in dB with no load.
@export var breath_volume_db_rest: float = -14.0
## Breathing volume in dB at full load.
@export var breath_volume_db_full_load: float = -4.0
## Shapes load to rate/volume: 1 is linear, above 1 stays calm longer then rises sharply.
@export var breath_curve_exponent: float = 1.0
## Extra rate multiplier while air is low and no ragged file exists.
@export var ragged_rate_multiplier: float = 1.3
## Extra volume in dB while air is low.
@export var ragged_volume_boost_db: float = 3.0
## Seconds taken to ease rate and volume toward their targets.
@export var breath_smoothing_seconds: float = 0.4

@export_group("Creaks")
## Seconds between creaks at the start of the run.
@export var creak_interval_start: float = 14.0
## Seconds between creaks as the collapse timer reaches zero.
@export var creak_interval_end: float = 2.0
## Shapes collapse progress to interval: 1 is linear, above 1 stays sparse longer.
@export var creak_curve_exponent: float = 1.5
## Random spread applied to each interval, as a fraction (0.3 = plus or minus 30%).
@export_range(0.0, 0.9, 0.01) var creak_interval_jitter: float = 0.3
## Random pitch spread per creak (0.1 = plus or minus 10%).
@export_range(0.0, 0.5, 0.01) var creak_pitch_jitter: float = 0.1
## Creak volume in dB at the start of the run.
@export var creak_volume_db_start: float = -18.0
## Creak volume in dB as the collapse timer reaches zero.
@export var creak_volume_db_end: float = -6.0


## Pushes the bus volumes and low-pass cutoff to the AudioServer.
## A missing bus logs one warning and is skipped.
func apply_to_buses() -> void:
	_set_bus_db(HELMET_BUS, helmet_bus_db)
	_set_bus_db(STATION_BUS, station_bus_db)
	var helmet: int = AudioServer.get_bus_index(HELMET_BUS)
	if helmet < 0:
		return
	for i: int in AudioServer.get_bus_effect_count(helmet):
		var effect: AudioEffect = AudioServer.get_bus_effect(helmet, i)
		if effect is AudioEffectLowPassFilter:
			(effect as AudioEffectLowPassFilter).cutoff_hz = lowpass_cutoff_hz


## Loads an audio stream defensively. Returns null (after one push_warning) when the
## path is empty or the file is missing, so the caller can stay silent.
static func load_stream(path: String) -> AudioStream:
	if path.is_empty() or not ResourceLoader.exists(path):
		push_warning("AudioTuning: missing audio file '%s'; that sound stays silent." % path)
		return null
	var stream: AudioStream = load(path) as AudioStream
	if stream == null:
		push_warning("AudioTuning: '%s' is not an audio stream; that sound stays silent." % path)
	return stream


## Like load_stream but silent when the file is absent (for optional files).
static func load_optional_stream(path: String) -> AudioStream:
	if path.is_empty() or not ResourceLoader.exists(path):
		return null
	return load(path) as AudioStream


func _set_bus_db(bus_name: StringName, db: float) -> void:
	var index: int = AudioServer.get_bus_index(bus_name)
	if index < 0:
		push_warning("AudioTuning: audio bus '%s' not found." % bus_name)
		return
	AudioServer.set_bus_volume_db(index, db)
