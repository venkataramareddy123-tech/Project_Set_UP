# Agent-First Production Starter

An opinionated boilerplate for building new software with CLI agents and humans in the same repo. It is designed for fast project setup, trustworthy verification, safe experimentation, and clean handoffs across sessions.

## What it is good at

- Bootstrapping new projects with agent-friendly repository memory already in place
- Supporting web, service, CLI, desktop, library, and sandbox-style starts
- Keeping `docs/` synchronized with actual repository state
- Making verification results explicit in `.vibe/check_summary.json` and `docs/SYSTEM_STATUS.md`
- Giving you a lightweight way to snapshot and restore local experiments

## Included foundations

- `ARCHITECTURE.md`: canonical top-down product and system design
- `scripts/bootstrap.sh`: non-interactive project bootstrap with starter profiles
- `scripts/check.sh`: lint, typecheck, tests, and dependency audit
- `scripts/sync.sh`: fix, verify, and regenerate repository memory
- `scripts/snapshot_workspace.py`: capture a local workspace snapshot before risky changes
- `scripts/restore_snapshot.py`: restore a previous snapshot without relying on git history
- `docs/AGENT_CONTRACT.md`: workflow rules for agents
- `docs/CONTEXT.md`: `/continue` and `/summarize` protocol
- `docs/REPO_MAP.md`: generated code overview
- `docs/SYSTEM_STATUS.md`: generated verification dashboard

## Quick start

```bash
git clone git@github.com:venkataramareddy123-tech/Project_Set_UP.git my-project
cd my-project
python3 -m venv venv
source venv/bin/activate
pip install -r requirements-dev.txt
./scripts/bootstrap.sh --name "My Project" --description "Short summary" --profile service --yes
./scripts/install_hooks.sh
./scripts/sync.sh
```

## Profiles

- `library`: package-first scaffold
- `cli`: command-oriented starter
- `web`: web app entrypoint scaffold
- `service`: background worker or API service starter
- `desktop`: desktop application starter
- `sandbox`: experiment-first layout with an `experiments/` area

## Safe iteration

Before large edits or speculative changes:

```bash
python3 scripts/snapshot_workspace.py before-refactor
```

Restore later if needed:

```bash
python3 scripts/restore_snapshot.py before-refactor
```

## Workflow

1. Write the big product and system idea in `ARCHITECTURE.md`.
2. Break that architecture into milestones in `docs/ROADMAP.md`.
3. Ask your CLI agent to read `AGENTS.md`, `ARCHITECTURE.md`, `docs/CONTEXT.md`, and `docs/ACTIVE_TASK.md`.
4. Let the agent derive one concrete active task from the architecture and roadmap.
5. Work in small slices and run `./scripts/sync.sh` after each meaningful change.
6. Commit only when `docs/SYSTEM_STATUS.md` reflects the expected machine-verified state.

`/continue` and `/summarize` are intended to be repo-local. Start the agent session from the project directory you want to work on, and the workflow should use that repository's local `docs/` and `.vibe/` state rather than any other project's memory.

## Notes

- Generated runtime artifacts in `.vibe/*.log` and `.vibe/check_summary.json` are intentionally not committed.
- The starter remains stack-neutral after bootstrap. Add runtime dependencies and deployment wiring for your chosen platform.
