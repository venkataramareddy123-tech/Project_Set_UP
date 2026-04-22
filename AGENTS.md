# QuantumSurge Agent Workflow

This repository uses a persistent handoff workflow so Codex and Gemini can alternate work without losing context.

## Read First
- `docs/CONTEXT.md`
- `docs/ROADMAP.md`
- `docs/SYSTEM_STATUS.md`
- `docs/REPO_MAP.md`

Treat `docs/CONTEXT.md` as the detailed operating protocol. Use the other files as the current project state.

## Manual Workflow Commands
If the user types `/continue` or a close misspelling such as `contnue`, interpret it as a workflow command even if the Codex UI does not expose it in slash autocomplete.

For `/continue`:
1. Read the files listed above.
2. Check `.vibe/test_failures.log` first. If it exists and is non-empty, address those failures before new feature work.
3. Identify the current milestone, latest handoff context, and next unchecked roadmap task.
4. Summarize where work stopped.
5. Produce the next concrete implementation plan by default.
6. Execute the task in the same turn only if the user explicitly asks to continue building immediately.

If the user types `/summarize` or a close misspelling such as `sumarize`, interpret it as the end-of-session handoff command.

For `/summarize`:
1. Review the work completed in the current session.
2. Append a concise handoff note to `docs/ROADMAP.md`.
3. Run `./scripts/sync.sh`.
4. Confirm what changed and what should happen next.

## Mandatory Maintenance
After any code edit:
1. Run `./scripts/sync.sh`.
2. If a roadmap item was completed, update `docs/ROADMAP.md`.

## Architectural Memory
For significant architectural decisions, create an ADR in `docs/ADRs/` with context, decision, and consequences.

## Constraints
- Work inside `/home/ram/QuantumSurge`.
- Prefer `docs/REPO_MAP.md` for codebase orientation before rereading many source files.
- Keep instructions consistent with `docs/CONTEXT.md`.
