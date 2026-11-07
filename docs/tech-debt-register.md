## Technical Debt Register

Last updated: 2026-11-08

Total items: 6 (2 resolved) | Estimated total effort: M + 5S

| ID | Category | Description | Files | Effort | Impact | Priority | Status | Added | Sprint |
|----|----------|-------------|-------|--------|--------|----------|--------|-------|--------|
| TD-001 | Architecture | `GameSession.total_cash` is a `static var`, which breaks `.claude/rules/gameplay-code.md` ("No static singletons for game state"). Hold the session in an injected object owned by a root scene — from production/epics/dead-air/story-005-run-end.md. Resolved in story 006: `GameSession` is an injected instance owned by `Game` | src/gameplay/run/game_session.gd, src/gameplay/run/run_state.gd | M | Med | — | Resolved | 2026-11-08 | Backlog |
| TD-002 | Code Quality | Dive again button is wider than the result panel and sits at its bottom edge — from production/epics/dead-air/story-005-run-end.md. Resolved in story 006: padded, opaque panel | src/ui/run_result/run_result.tscn | S | Low | — | Resolved | 2026-11-08 | Backlog |
| TD-003 | Code Quality | Result screen and shop strings are hardcoded; `.claude/rules/ui-code.md` asks for `tr()` — from production/epics/dead-air/story-005-run-end.md and story-006-shop-air-upgrade.md | src/ui/run_result/run_result.gd, src/ui/shop/shop.gd, src/game/game.gd | S | Low | — | Open | 2026-11-08 | Backlog |
| TD-004 | Code Quality | `run_state.gd` finds Airlock, Player and CollapseTimer with `get_node("../...")` string paths, which break if the scene is rearranged — from production/epics/dead-air/story-005-run-end.md | src/gameplay/run/run_state.gd | S | Low | — | Open | 2026-11-08 | Backlog |
| TD-005 | Test | Shop was only driven by keyboard in the probe; mouse clicks and Godot 4.6+'s split keyboard/mouse focus are unverified in a real run — from production/epics/dead-air/story-006-shop-air-upgrade.md | src/ui/shop/shop.gd, src/game/game.gd | S | Low | — | Open | 2026-11-08 | Backlog |
| TD-006 | Code Quality | Running `station.tscn` on its own still launches, but its result button does nothing because only `Game` listens for `run_closed` — from production/epics/dead-air/story-006-shop-air-upgrade.md | src/levels/station/station.gd, src/ui/run_result/run_result.gd | S | Low | — | Open | 2026-11-08 | Backlog |
