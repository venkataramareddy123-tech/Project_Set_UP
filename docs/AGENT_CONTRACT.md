# Agent Contract

This contract defines the minimum rules required to keep the repository state trustworthy for future agent sessions.

## Hard rules

1. Never manually edit `docs/SYSTEM_STATUS.md`. It is generated.
2. Read `ARCHITECTURE.md`, `docs/ACTIVE_TASK.md`, and `docs/CONTEXT.md` from the current repository before implementation.
3. Treat `ARCHITECTURE.md` as the canonical source for the big system idea.
4. Derive work downward: architecture -> roadmap -> active task -> code/tests.
5. Run `./scripts/sync.sh` after code changes and before `/summarize` or commit.
6. Treat `.vibe/check_summary.json` as the machine source of truth for repository health.
7. Never claim checks passed unless `overall_status` is explicitly `pass`.
8. If `.vibe/check_summary.json` is missing or malformed, assume the repository state is failed until `./scripts/sync.sh` succeeds.
9. Treat `/continue` and `/summarize` as repo-local commands scoped to the working directory where the current agent session started.
10. Do not reuse task state, roadmap state, or verification state from another repository unless the user explicitly asks for cross-repo work.

## Machine-readable state

- Config: `.vibe/config.json`
- Status file: `.vibe/check_summary.json`
- Protocol version: `3.1.0`
