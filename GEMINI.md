# Agent Instructions

This is an agent-first starter repository.

## Mandatory context

Start each session by reading:
1. `docs/CONTEXT.md`
2. `docs/ACTIVE_TASK.md`
3. `docs/SYSTEM_STATUS.md`
4. `docs/REPO_MAP.md`

## Workflow prompts

- `/continue`: inspect repository state and propose or execute the next step
- `/summarize`: finalize the session and record the handoff state

## Core rule

Always run `./scripts/sync.sh` after edits before claiming repository health.
