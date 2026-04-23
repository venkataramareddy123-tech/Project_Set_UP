#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "🚀 Agent-First Project Bootstrapper"
echo "----------------------------------"

usage() {
    cat <<'EOF'
Usage: ./scripts/bootstrap.sh [options]

Options:
  --name NAME              Project name
  --description TEXT       Short project description
  --profile PROFILE        One of: library, cli, web, service, desktop, sandbox
  --yes                    Use defaults for missing answers
  --help                   Show this help message
EOF
}

slugify() {
    echo "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/_/g; s/^_+//; s/_+$//'
}

PROJECT_NAME=""
PROJECT_DESCRIPTION=""
PROJECT_PROFILE=""
ASSUME_YES=false

while [[ $# -gt 0 ]]; do
    case "$1" in
        --name)
            PROJECT_NAME="${2:-}"
            shift 2
            ;;
        --description)
            PROJECT_DESCRIPTION="${2:-}"
            shift 2
            ;;
        --profile)
            PROJECT_PROFILE="${2:-}"
            shift 2
            ;;
        --yes)
            ASSUME_YES=true
            shift
            ;;
        --help)
            usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            exit 1
            ;;
    esac
done

if [[ -z "$PROJECT_NAME" && "$ASSUME_YES" == false ]]; then
    read -r -p "Project name: " PROJECT_NAME
fi
if [[ -z "$PROJECT_DESCRIPTION" && "$ASSUME_YES" == false ]]; then
    read -r -p "Short description: " PROJECT_DESCRIPTION
fi
if [[ -z "$PROJECT_PROFILE" && "$ASSUME_YES" == false ]]; then
    read -r -p "Project profile [library/cli/web/service/desktop/sandbox]: " PROJECT_PROFILE
fi

PROJECT_NAME="${PROJECT_NAME:-Starter Project}"
PROJECT_DESCRIPTION="${PROJECT_DESCRIPTION:-Production-ready agent-first starter repository.}"
PROJECT_PROFILE="${PROJECT_PROFILE:-service}"

case "$PROJECT_PROFILE" in
    library|cli|web|service|desktop|sandbox) ;;
    *)
        echo "Unsupported profile: $PROJECT_PROFILE"
        exit 1
        ;;
esac

PACKAGE_NAME="$(slugify "$PROJECT_NAME")"
if [[ -z "$PACKAGE_NAME" ]]; then
    PACKAGE_NAME="app"
fi

mkdir -p "src/$PACKAGE_NAME" tests/unit tests/integration docs/ADRs docs/knowledge .snapshots

cat <<EOF > ARCHITECTURE.md
# Architecture

This is the canonical high-level design document for $PROJECT_NAME.

Agents should treat this file as the top-down source of intent before turning work into milestones, tasks, and code changes.

## Product Vision

$PROJECT_DESCRIPTION

## Target Users

- Primary users:
- Secondary users:
- Operators or maintainers:

## Core Capabilities

- Capability 1:
- Capability 2:
- Capability 3:

## System Shape

Describe the intended architecture at a high level. Include major apps, services, modules, storage, external APIs, queues, background jobs, agents, or local tools.

## Data Model

Describe the important entities, state, files, databases, events, and data ownership boundaries.

## Interfaces

Describe user interfaces, APIs, CLIs, background jobs, integrations, and automation entrypoints.

## Quality Requirements

- Reliability:
- Security:
- Privacy:
- Performance:
- Observability:
- Maintainability:

## Constraints

List technical, business, platform, budget, timeline, or deployment constraints that should guide implementation choices.

## Open Questions

- Question 1:
- Question 2:

## Agent Planning Rules

1. Use this file to understand the full intended system before proposing work.
2. Convert architecture intent into milestones in \`docs/ROADMAP.md\`.
3. Convert the next milestone into one concrete task in \`docs/ACTIVE_TASK.md\`.
4. Keep code changes small enough to verify with \`./scripts/sync.sh\`.
5. Update this file when the big system idea or architecture changes materially.
EOF

cat <<EOF > README.md
# $PROJECT_NAME

$PROJECT_DESCRIPTION

This repository was bootstrapped from the Agent-First Vibe Coding Starter using the \`$PROJECT_PROFILE\` profile.

## Quick start

\`\`\`bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements-dev.txt
./scripts/install_hooks.sh
./scripts/sync.sh
\`\`\`

## Template capabilities

- Agent handoff memory in \`docs/\`
- Deterministic verification with \`./scripts/check.sh\`
- Safe iteration snapshots with \`python3 scripts/snapshot_workspace.py\`
- Profile-aware starter structure under \`src/$PACKAGE_NAME/\`

## Next steps

1. Fill in \`ARCHITECTURE.md\` with the full product and system idea.
2. Convert that architecture into milestones in \`docs/ROADMAP.md\`.
3. Replace the profile starter module with your first production slice.
4. Add runtime dependencies for the chosen stack.
EOF

cat <<EOF > docs/ROADMAP.md
# Roadmap

## Current milestone

- [ ] Define the first user-facing outcome for $PROJECT_NAME
- [ ] Fill in \`ARCHITECTURE.md\` with the intended system design
- [ ] Replace the starter profile code in \`src/$PACKAGE_NAME/\`
- [ ] Add project-specific verification beyond the framework smoke tests

## Backlog

- [ ] Add runtime dependencies for the $PROJECT_PROFILE stack
- [ ] Add deployment, packaging, or release automation
- [ ] Capture major architecture decisions in \`docs/ADRs/\`

## Session notes

- $(date +%Y-%m-%d): Bootstrapped $PROJECT_NAME from the starter template using the $PROJECT_PROFILE profile.
EOF

cat <<EOF > docs/CHANGELOG.md
# Changelog

Completed roadmap items can be archived here.
EOF

cat <<EOF > docs/ACTIVE_TASK.md
# 🎯 Current Active Task
> **Status:** 🏗️ Waiting for Task

## 📝 Task Definition
Define the first concrete implementation task from \`docs/ROADMAP.md\`.

## 🛠️ Micro-Steps
- [ ] Choose the first user-facing or operator-facing slice
- [ ] Replace the starter implementation with a real module
- [ ] Add tests that lock in the intended behavior

## 🧪 Verification Steps
- [ ] Run \`./scripts/sync.sh\`
- [ ] Confirm \`docs/SYSTEM_STATUS.md\` matches the result
EOF

cat <<EOF > docs/knowledge/index.md
# External Knowledge Base

Capture external references here when the project depends on APIs, SDKs, frameworks, or platform docs that agents should reuse across sessions.
EOF

cat <<EOF > .env.example
# Copy to .env and fill in project-specific secrets or local settings.
APP_ENV=development
LOG_LEVEL=INFO
EOF

find src -type f ! -name "__init__.py" -delete
find tests -type f ! -name "__init__.py" -delete

cat <<EOF > "src/$PACKAGE_NAME/__init__.py"
"""$PROJECT_NAME package."""
EOF

case "$PROJECT_PROFILE" in
    library)
        cat <<EOF > "src/$PACKAGE_NAME/api.py"
"""Public library surface for $PROJECT_NAME."""


def describe() -> str:
    """Return a stable marker for the initial library scaffold."""
    return "$PROJECT_NAME library scaffold"
EOF
        cat <<EOF > tests/unit/test_profile.py
from $PACKAGE_NAME.api import describe


def test_library_profile_smoke() -> None:
    assert describe() == "$PROJECT_NAME library scaffold"
EOF
        ;;
    cli)
        cat <<EOF > "src/$PACKAGE_NAME/cli.py"
"""CLI entrypoints for $PROJECT_NAME."""


def build_banner() -> str:
    """Return the default CLI banner."""
    return "$PROJECT_NAME CLI ready"
EOF
        cat <<EOF > tests/unit/test_profile.py
from $PACKAGE_NAME.cli import build_banner


def test_cli_profile_smoke() -> None:
    assert build_banner() == "$PROJECT_NAME CLI ready"
EOF
        ;;
    web)
        cat <<EOF > "src/$PACKAGE_NAME/web.py"
"""Web application entrypoints for $PROJECT_NAME."""


def healthcheck() -> dict[str, str]:
    """Return a minimal health payload for the starter web profile."""
    return {"status": "ok", "app": "$PROJECT_NAME"}
EOF
        cat <<EOF > tests/unit/test_profile.py
from $PACKAGE_NAME.web import healthcheck


def test_web_profile_smoke() -> None:
    assert healthcheck()["status"] == "ok"
EOF
        ;;
    service)
        cat <<EOF > "src/$PACKAGE_NAME/service.py"
"""Background service entrypoints for $PROJECT_NAME."""


def service_status() -> dict[str, str]:
    """Return a minimal service status payload."""
    return {"status": "ready", "service": "$PROJECT_NAME"}
EOF
        cat <<EOF > tests/unit/test_profile.py
from $PACKAGE_NAME.service import service_status


def test_service_profile_smoke() -> None:
    assert service_status()["status"] == "ready"
EOF
        ;;
    desktop)
        cat <<EOF > "src/$PACKAGE_NAME/desktop.py"
"""Desktop application entrypoints for $PROJECT_NAME."""


def window_title() -> str:
    """Return the default application window title."""
    return "$PROJECT_NAME Desktop"
EOF
        cat <<EOF > tests/unit/test_profile.py
from $PACKAGE_NAME.desktop import window_title


def test_desktop_profile_smoke() -> None:
    assert window_title() == "$PROJECT_NAME Desktop"
EOF
        ;;
    sandbox)
        mkdir -p experiments
        cat <<EOF > "src/$PACKAGE_NAME/lab.py"
"""Experiment helpers for $PROJECT_NAME."""


def experiment_marker() -> str:
    """Return a stable marker for the sandbox profile."""
    return "$PROJECT_NAME sandbox"
EOF
        cat <<EOF > tests/unit/test_profile.py
from $PACKAGE_NAME.lab import experiment_marker


def test_sandbox_profile_smoke() -> None:
    assert experiment_marker() == "$PROJECT_NAME sandbox"
EOF
        cat <<EOF > experiments/README.md
# Experiments

Use this directory for temporary prototypes, notebooks, or validation spikes that should not pollute \`src/\`.
EOF
        ;;
esac

cat <<'EOF' > tests/test_baseline.py
from pathlib import Path


def test_docs_exist() -> None:
    root = Path(__file__).resolve().parent.parent
    required = [
        "ARCHITECTURE.md",
        "docs/ACTIVE_TASK.md",
        "docs/AGENT_CONTRACT.md",
        "docs/CONTEXT.md",
        "docs/ROADMAP.md",
    ]
    for relative_path in required:
        assert (root / relative_path).exists()
EOF

echo "🪝 Installing hooks..."
./scripts/install_hooks.sh

echo "✅ $PROJECT_NAME is ready with the $PROJECT_PROFILE profile."
