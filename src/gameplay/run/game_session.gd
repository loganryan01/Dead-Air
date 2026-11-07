class_name GameSession
extends RefCounted
## In-memory state that outlives a single run (survives reload_current_scene).
## Implements: design/game-brief.md MVP feature 5; story-005-run-end. No save file.

## Cash banked across all runs this session. Only RunState writes it.
static var total_cash: float = 0.0
