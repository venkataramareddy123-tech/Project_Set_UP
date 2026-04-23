# /continue

Sync to the current repository state and plan the next implementation step.

## Workflow

1. Resolve the repository from the directory where the current agent session started.
2. Read that repository's `docs/CONTEXT.md`, `docs/ROADMAP.md`, and `docs/REPO_MAP.md`.
3. Identify the current milestone, the latest session notes, and the next unchecked roadmap task for that repository only.
4. Summarize where work stopped and what context matters for the next session.
5. Produce a short, concrete implementation plan for the next task instead of executing it by default.
6. If the user explicitly asks to continue building in the same turn, execute the planned task using the repository workflow rules.
