# `/continue` and `/summarize` Protocol

This repository uses a shared handoff workflow across CLI agents.

## Planning hierarchy

Agents should plan work from broad intent to executable slices:

1. `ARCHITECTURE.md` defines the big product/system idea and target architecture.
2. `docs/ROADMAP.md` breaks that architecture into milestones and backlog items.
3. `docs/ACTIVE_TASK.md` defines the single current implementation slice.
4. Code and tests implement that slice.
5. `docs/SYSTEM_STATUS.md` and `.vibe/check_summary.json` record machine-verified health.

## `/continue`

When `/continue` is triggered, the agent should:
1. Resolve the current repository from the working directory where the agent session started.
2. Read that repository's `ARCHITECTURE.md`, `docs/CONTEXT.md`, `docs/SYSTEM_STATUS.md`, and `docs/ACTIVE_TASK.md` first.
3. Check that repository's `.vibe/test_failures.log` if it exists and is non-empty.
4. Read that repository's `docs/REPO_MAP.md` only when more structure is needed.
5. Read that repository's `docs/ROADMAP.md` when the active task is empty, stale, or needs to be reconciled with the architecture.
6. Derive the next implementation step from architecture -> roadmap -> active task.
7. Propose the next concrete implementation step by default.
8. Run `./scripts/sync.sh` after any code change.

The agent must not import roadmap or health state from another repository unless the user explicitly asks for cross-project coordination.

## `/review`

Before commit, the agent should:
1. Review the diff against `docs/ACTIVE_TASK.md`.
2. Check for behavior gaps, missing tests, and error handling.
3. Use `docs/SYSTEM_STATUS.md` and `.vibe/check_summary.json` instead of making assumptions about health.

## `/summarize`

When `/summarize` is triggered, the agent should:
1. Review the session work.
2. Append a short handoff note to `docs/ROADMAP.md`.
3. Run `./scripts/sync.sh`.
4. Report what changed and what should happen next.

## ADR rule

For significant architectural decisions, add an ADR in `docs/ADRs/` describing context, decision, and consequences.
