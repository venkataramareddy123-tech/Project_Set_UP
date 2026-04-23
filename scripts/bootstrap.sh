#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "🚀 Agent-First Project Bootstrapper"
echo "----------------------------------"

PROJECT_NAME="${1:-}"

if [[ -z "$PROJECT_NAME" ]]; then
    read -r -p "Project name: " PROJECT_NAME
fi

if [[ -z "$PROJECT_NAME" ]]; then
    echo "Project name is required."
    exit 1
fi

read -r -p "Short description: " PROJECT_DESCRIPTION

cat <<EOF > README.md
# $PROJECT_NAME

$PROJECT_DESCRIPTION

This repository was bootstrapped from the Agent-First Vibe Coding Starter.
EOF

cat <<EOF > docs/ROADMAP.md
# Roadmap

## Current milestone

- [ ] Define the first user-facing outcome for $PROJECT_NAME
- [ ] Create the first project module under \`src/\`
- [ ] Replace the starter tests with project-specific tests

## Backlog

- [ ] Add project dependencies to \`requirements-dev.txt\`
- [ ] Create ADRs for major architecture decisions

## Session notes

- $(date +%Y-%m-%d): Bootstrapped $PROJECT_NAME from the starter template.
EOF

cat <<EOF > docs/CHANGELOG.md
# Changelog

Completed roadmap items can be archived here.
EOF

cat <<EOF > docs/ACTIVE_TASK.md
# 🎯 Current Active Task
> **Status:** 🏗️ Waiting for Task

## 📝 Task Definition
(Select the next task from \`docs/ROADMAP.md\`.)

## 🛠️ Micro-Steps
- [ ] Define the task
- [ ] Implement the smallest useful slice
- [ ] Add or update tests

## 🧪 Verification Steps
- [ ] Run \`./scripts/sync.sh\`
- [ ] Confirm \`docs/SYSTEM_STATUS.md\` matches the result
EOF

echo "🧹 Resetting starter source files..."
find src -type f ! -name "__init__.py" -delete
find tests -type f ! -name "__init__.py" -delete

cat <<EOF > tests/test_baseline.py
from pathlib import Path


def test_docs_exist() -> None:
    root = Path(__file__).resolve().parent.parent
    required = [
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

echo "✅ $PROJECT_NAME is ready."
