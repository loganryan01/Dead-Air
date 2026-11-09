class_name StationTuning
extends Resource
## Designer-tunable station run values and station art/lighting values.
## Implements: design/game-brief.md MVP feature 4; story-004-station-airlock-collapse;
## story-009-station-art-pass.
## Instance: assets/data/station_tuning.tres

## Seconds from the start of the run until the station collapses.
@export var collapse_seconds: float = 180.0

@export_group("Alarm")
## Seconds remaining at which the station lights switch to the alarm colour.
@export var alarm_seconds: float = 30.0
## Colour of the station emergency lights in the alarm state.
@export var alarm_color: Color = Color(1.0, 0.1, 0.05, 1.0)

@export_group("Environment")
## Background (sky) colour behind the station.
@export var background_color: Color = Color(0.01, 0.01, 0.015, 1.0)
## Ambient light colour.
@export var ambient_color: Color = Color(0.12, 0.1, 0.1, 1.0)
## Ambient light energy.
@export_range(0.0, 2.0, 0.01) var ambient_energy: float = 0.25
## Fog colour.
@export var fog_color: Color = Color(0.05, 0.035, 0.03, 1.0)
## Fog density.
@export_range(0.0, 0.5, 0.001) var fog_density: float = 0.035

@export_group("Emergency Lights")
## Normal colour of the station emergency lights (warm amber).
@export var light_color: Color = Color(1.0, 0.6, 0.15, 1.0)
## Energy of each station emergency light.
@export_range(0.0, 16.0, 0.1) var light_energy: float = 2.0
## Range in metres of each station emergency light.
@export_range(1.0, 60.0, 0.5) var light_range: float = 10.0
## Flicker speed of flickering lights, in noise cycles per second.
@export_range(0.0, 60.0, 0.1) var flicker_rate: float = 9.0
## Flicker depth: 0 = steady, 1 = the light can drop to fully dark.
@export_range(0.0, 1.0, 0.01) var flicker_depth: float = 0.6

@export_group("Airlock Light")
## Colour of the airlock light (stays this colour in the alarm state).
@export var airlock_light_color: Color = Color(0.2, 1.0, 0.8, 1.0)
## Energy of the airlock light.
@export_range(0.0, 32.0, 0.1) var airlock_light_energy: float = 5.0
## Range in metres of the airlock light (long enough to read down the corridor).
@export_range(1.0, 100.0, 0.5) var airlock_light_range: float = 30.0
