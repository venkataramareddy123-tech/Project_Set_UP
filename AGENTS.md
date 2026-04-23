# Agent Workflow

This repository is meant to support alternating work between CLI agents and humans without losing state.

## Read first

- `ARCHITECTURE.md`
- `docs/CONTEXT.md`
- `docs/ACTIVE_TASK.md`
- `docs/SYSTEM_STATUS.md`
- `docs/REPO_MAP.md`

Treat `ARCHITECTURE.md` as the canonical high-level system intent, `docs/CONTEXT.md` as the workflow contract, and the other files as current repository memory.

## Workflow commands

If the user types `/continue` or a close misspelling, treat it as a workflow command even if the client does not expose it as a real slash command.

`/continue` is always relative to the repository where the current agent session was started. If the operator starts a session from another project directory, use that project's local `AGENTS.md`, `docs/`, and `.vibe/` files instead of carrying state across repositories.

For `/continue`:
1. Read the files above.
2. Check `.vibe/test_failures.log` first when it exists and is non-empty.
3. Use `ARCHITECTURE.md` to understand the big system idea before deriving smaller work.
4. Identify the current task, current failure state, and next concrete implementation step.
5. Summarize where work stopped.
6. Produce the next execution plan by default.
7. Only start implementing in the same turn if the user explicitly asks for execution.

For `/summarize`:
1. Review the work completed in the current session.
2. Append a concise handoff note to `docs/ROADMAP.md`.
3. Run `./scripts/sync.sh`.
4. Confirm what changed and what should happen next.

## Maintenance rules

After any code edit:
1. Run `./scripts/sync.sh`.
2. Update `docs/ROADMAP.md` if task state changed.

Agents must never pull roadmap, active task, or health state from another workspace unless the user explicitly asks for cross-repo work.

For significant architectural decisions, create an ADR in `docs/ADRs/`.
For changes to the big product or system direction, update `ARCHITECTURE.md` first and derive roadmap/task changes from it.
