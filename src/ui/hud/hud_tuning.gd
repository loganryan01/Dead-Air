class_name HudTuning
extends Resource
## HUD thresholds, pulse rate and state colours (assets/data/hud_tuning.tres).
## Implements: design/game-brief.md art direction; story-008-hud-polish.

## Air fraction (current / maximum) at or below which the air bar turns the low colour.
@export_range(0.0, 1.0, 0.01) var low_air_fraction: float = 0.4
## Air fraction at or below which the air bar turns the critical colour and pulses.
@export_range(0.0, 1.0, 0.01) var critical_air_fraction: float = 0.2
## Pulse cycles per second for the critical air bar.
@export var pulse_hz: float = 2.0
## Collapse seconds remaining at or below which the collapse meter turns red.
@export var collapse_final_seconds: float = 30.0

## Bar colour at healthy air and for the collapse bar before its final seconds.
@export var normal_color: Color = Color(1.0, 0.69, 0.2)
## Air bar colour at or below the low threshold.
@export var low_color: Color = Color(1.0, 0.45, 0.1)
## Air bar colour at or below the critical threshold.
@export var critical_color: Color = Color(0.9, 0.15, 0.1)
## Collapse bar and text colour during the final seconds.
@export var collapse_final_color: Color = Color(0.9, 0.15, 0.1)
