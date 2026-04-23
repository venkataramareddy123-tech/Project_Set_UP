# Agent Workflow

This repository is meant to support alternating work between CLI agents and humans without losing state.

## Read first

- `docs/CONTEXT.md`
- `docs/ACTIVE_TASK.md`
- `docs/SYSTEM_STATUS.md`
- `docs/REPO_MAP.md`

Treat `docs/CONTEXT.md` as the workflow contract and the other files as current repository memory.

## Workflow commands

If the user types `/continue` or a close misspelling, treat it as a workflow command even if the client does not expose it as a real slash command.

For `/continue`:
1. Read the files above.
2. Check `.vibe/test_failures.log` first when it exists and is non-empty.
3. Identify the current task, current failure state, and next concrete implementation step.
4. Summarize where work stopped.
5. Produce the next execution plan by default.
6. Only start implementing in the same turn if the user explicitly asks for execution.

For `/summarize`:
1. Review the work completed in the current session.
2. Append a concise handoff note to `docs/ROADMAP.md`.
3. Run `./scripts/sync.sh`.
4. Confirm what changed and what should happen next.

## Maintenance rules

After any code edit:
1. Run `./scripts/sync.sh`.
2. Update `docs/ROADMAP.md` if task state changed.

For significant architectural decisions, create an ADR in `docs/ADRs/`.
