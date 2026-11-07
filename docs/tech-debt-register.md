## Technical Debt Register

Last updated: 2026-11-08

Total items: 4 | Estimated total effort: M + 3S

| ID | Category | Description | Files | Effort | Impact | Priority | Status | Added | Sprint |
|----|----------|-------------|-------|--------|--------|----------|--------|-------|--------|
| TD-001 | Architecture | `GameSession.total_cash` is a `static var`, which breaks `.claude/rules/gameplay-code.md` ("No static singletons for game state"). Hold the session in an injected object owned by a root scene — from production/epics/dead-air/story-005-run-end.md | src/gameplay/run/game_session.gd, src/gameplay/run/run_state.gd | M | Med | — | Open | 2026-11-08 | Backlog |
| TD-002 | Code Quality | Dive again button is wider than the result panel and sits at its bottom edge — from production/epics/dead-air/story-005-run-end.md | src/ui/run_result/run_result.tscn | S | Low | — | Open | 2026-11-08 | Backlog |
| TD-003 | Code Quality | Result screen strings are hardcoded; `.claude/rules/ui-code.md` asks for `tr()` — from production/epics/dead-air/story-005-run-end.md | src/ui/run_result/run_result.gd | S | Low | — | Open | 2026-11-08 | Backlog |
| TD-004 | Code Quality | `run_state.gd` finds Airlock, Player and CollapseTimer with `get_node("../...")` string paths, which break if the scene is rearranged — from production/epics/dead-air/story-005-run-end.md | src/gameplay/run/run_state.gd | S | Low | — | Open | 2026-11-08 | Backlog |
