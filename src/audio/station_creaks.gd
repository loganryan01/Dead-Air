class_name StationCreaks
extends Node
## Plays creaking-metal one-shots at random intervals that shorten as the collapse timer
## runs down. Read-only: listens to CollapseTimer.time_changed and never changes the timer.
## Implements: design/game-brief.md audio direction; story-010-breathing-station-audio.

## The collapse timer that drives creak frequency.
@export var collapse_timer: CollapseTimer
## Audio tuning data (assets/data/audio_tuning.tres).
@export var tuning: AudioTuning
## Run state; creaks stop when the run ends.
@export var run_state: RunState

var _voice: AudioStreamPlayer
var _streams: Array[AudioStream] = []
var _progress: float = 0.0
var _countdown: float = 0.0
var _rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	tuning.apply_to_buses()
	_rng.randomize()
	_voice = AudioStreamPlayer.new()
	_voice.bus = AudioTuning.STATION_BUS
	add_child(_voice)
	for path: String in tuning.creak_paths:
		var stream: AudioStream = AudioTuning.load_stream(path)
		if stream != null:
			_streams.append(stream)
	if _streams.is_empty():
		set_process(false)
		return
	collapse_timer.time_changed.connect(_on_time_changed)
	collapse_timer.station_collapsed.connect(_stop)
	if run_state != null:
		run_state.run_ended.connect(_stop.unbind(3))
	_countdown = _next_countdown()


func _process(delta: float) -> void:
	_countdown -= delta
	if _countdown > 0.0:
		return
	_play_creak()
	_countdown = _next_countdown()


## Pure function: seconds between creaks. Equals interval_start at progress 0 and
## interval_end at progress 1 (collapse reached), shaped by pow(progress, exponent).
static func creak_interval(
	progress: float, interval_start: float, interval_end: float, exponent: float
) -> float:
	var t: float = pow(clampf(progress, 0.0, 1.0), maxf(exponent, 0.0))
	return maxf(lerpf(interval_start, interval_end, t), 0.0)


## Pure function: applies a random spread to an interval. unit_random is in 0..1;
## 0.5 returns the interval unchanged, 0 and 1 give interval * (1 -/+ jitter).
static func jittered(interval: float, jitter: float, unit_random: float) -> float:
	return interval * (1.0 + jitter * (unit_random * 2.0 - 1.0))


## Pure function: collapse progress 0..1 from the seconds left and the total.
static func progress_for(remaining: float, total: float) -> float:
	if total <= 0.0:
		return 1.0
	return clampf(1.0 - remaining / total, 0.0, 1.0)


func _exit_tree() -> void:
	_voice.stop()
	_voice.stream = null


func _stop() -> void:
	set_process(false)


func _on_time_changed(remaining: float) -> void:
	_progress = progress_for(remaining, collapse_timer.tuning.collapse_seconds)


func _next_countdown() -> float:
	var base: float = creak_interval(
		_progress, tuning.creak_interval_start, tuning.creak_interval_end, tuning.creak_curve_exponent
	)
	return jittered(base, tuning.creak_interval_jitter, _rng.randf())


func _play_creak() -> void:
	_voice.stream = _streams[_rng.randi_range(0, _streams.size() - 1)]
	_voice.pitch_scale = maxf(
		1.0 + tuning.creak_pitch_jitter * _rng.randf_range(-1.0, 1.0), AudioTuning.MIN_PITCH_SCALE
	)
	_voice.volume_db = lerpf(tuning.creak_volume_db_start, tuning.creak_volume_db_end, _progress)
	_voice.play()
