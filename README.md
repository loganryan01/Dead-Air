# Dead Air

Dive into collapsing derelict space stations, grab as much salvage as you can
carry, and escape before your air runs out.

## How it plays

- Start in the Supply Shop and dive into the station.
- Grab salvage. Heavier loot is worth more, but it slows you down and burns air faster.
- Reach the airlock to bank what you carry. Run out of air, or let the station
  collapse, and you lose it all.
- Spend your cash on more air, then dive again.

The design lives in [`design/game-brief.md`](design/game-brief.md), and the
work is tracked as stories in [`production/epics/dead-air/`](production/epics/dead-air/).

## Running it

Built with Godot 4.7.1 and GDScript. Open the project folder in the Godot
editor and press F5. The main scene is `src/game/game.tscn`.

Controls: WASD to move, the mouse to look, Esc to release the mouse.

## Credits

Made with [Claude Code Game Studios](https://github.com/Donchitos/Claude-Code-Game-Studios),
an MIT-licensed framework for running game development through Claude Code
agents. See [`LICENSE`](LICENSE).
