# Agent-First Vibe Coding Starter

An opinionated starter template for CLI-agent driven projects. It gives Codex, Gemini, Cursor, or a human operator a shared operating model: deterministic checks, lightweight repository memory, and a small set of scripts that keep the repo synchronized.

## What this template is for

- Starting a new project with agent-friendly conventions already in place
- Keeping `docs/` aligned with the real repository state
- Giving agents a trustworthy source of project health in `.vibe/check_summary.json`
- Reducing context waste with a generated repo map and explicit task files

## What is included

- `scripts/check.sh`: runs lint, typecheck, tests, and dependency audit
- `scripts/sync.sh`: runs fixes, checks, and regenerates repo memory files
- `scripts/bootstrap.sh`: resets the template for a new project
- `scripts/install_hooks.sh`: installs a pre-commit hook that runs `sync.sh`
- `docs/AGENT_CONTRACT.md`: the rules agents should follow
- `docs/CONTEXT.md`: the `/continue` and `/summarize` workflow
- `docs/REPO_MAP.md`: generated structural overview of the repository
- `docs/SYSTEM_STATUS.md`: generated dashboard from machine-readable check output

## Quick start

```bash
git clone git@github.com:venkataramareddy123-tech/Project_Set_UP.git my-project
cd my-project
python3 -m venv venv
source venv/bin/activate
pip install -r requirements-dev.txt
./scripts/bootstrap.sh
./scripts/install_hooks.sh
./scripts/sync.sh
```

## Recommended workflow

1. Update `docs/ROADMAP.md` with the first milestone.
2. Tell your CLI agent to read `AGENTS.md`, `docs/CONTEXT.md`, and `docs/ACTIVE_TASK.md`.
3. Implement in small steps.
4. Run `./scripts/sync.sh` after edits.
5. Commit only when `docs/SYSTEM_STATUS.md` reflects a healthy state.

## Notes

- Generated runtime artifacts in `.vibe/*.log` and `.vibe/check_summary.json` are intentionally not committed.
- The template is deliberately neutral. Add domain libraries and source structure only after bootstrapping the new project.
