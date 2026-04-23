# Agent-First Production Starter

An opinionated boilerplate for building new software with CLI agents and humans in the same repo. It is designed for fast project setup, trustworthy verification, safe experimentation, and clean handoffs across sessions.

## What it is good at

- Bootstrapping new projects with agent-friendly repository memory already in place
- Supporting web, service, CLI, desktop, library, and sandbox-style starts
- Keeping `docs/` synchronized with actual repository state
- Making verification results explicit in `.vibe/check_summary.json` and `docs/SYSTEM_STATUS.md`
- Giving you a lightweight way to snapshot and restore local experiments

## Included foundations

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

1. Define the first user-facing milestone in `docs/ROADMAP.md`.
2. Ask your CLI agent to read `AGENTS.md`, `docs/CONTEXT.md`, and `docs/ACTIVE_TASK.md`.
3. Work in small slices and run `./scripts/sync.sh` after each meaningful change.
4. Commit only when `docs/SYSTEM_STATUS.md` reflects the expected machine-verified state.

## Notes

- Generated runtime artifacts in `.vibe/*.log` and `.vibe/check_summary.json` are intentionally not committed.
- The starter remains stack-neutral after bootstrap. Add runtime dependencies and deployment wiring for your chosen platform.
