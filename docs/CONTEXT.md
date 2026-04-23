# `/continue` and `/summarize` Protocol

This repository uses a shared handoff workflow across CLI agents.

## `/continue`

When `/continue` is triggered, the agent should:
1. Read only `docs/CONTEXT.md`, `docs/SYSTEM_STATUS.md`, and `docs/ACTIVE_TASK.md` first.
2. Check `.vibe/test_failures.log` if it exists and is non-empty.
3. Read `docs/REPO_MAP.md` only when more structure is needed.
4. Read `docs/ROADMAP.md` only when the active task is empty or stale.
5. Propose the next concrete implementation step by default.
6. Run `./scripts/sync.sh` after any code change.

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
