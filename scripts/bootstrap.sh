#!/usr/bin/env bash
set -e

echo "🚀 Vibe Coding: Project Bootstrapper"
echo "-----------------------------------"

read -p "Enter your new Project Name (e.g., SkyNet): " NEW_NAME
read -p "Enter a short description: " DESC

# 1. Rebrand Files
echo "🏷️  Rebranding files to $NEW_NAME..."
find . -type f -not -path '*/.*' -exec sed -i "s/QuantumSurge V2/$NEW_NAME/g" {} +
find . -type f -not -path '*/.*' -exec sed -i "s/QuantumSurge/$NEW_NAME/g" {} +

# 2. Reset Roadmap and Changelog
echo "📋 Resetting Roadmap and Changelog..."
cat <<EOF > docs/ROADMAP.md
# 🗺️ $NEW_NAME: Roadmap & Progress Tracker

## Current Milestone: [Phase 1] Foundation
- [ ] Initialize $NEW_NAME core structure.
- [ ] Define first architectural pillar.

## Session Notes
- **$(date +%Y-%m-%d):** Project bootstrapped via Ultimate Vibe Coding Framework.
EOF

cat <<EOF > docs/CHANGELOG.md
# 📜 $NEW_NAME: Project Changelog
(Tasks archived from ROADMAP.md will appear here)
EOF

# 3. Clear Active Task
cat <<EOF > docs/ACTIVE_TASK.md
# 🎯 Current Active Task
> **Status:** 🏗️ Waiting for Task

## 📝 Task Definition
(Pick a task from ROADMAP.md and run /continue)
EOF

# 4. Cleanup Example Code and Libraries
echo "🧹 Cleaning up example code..."
rm -rf src/ingestion/* src/core/* tests/*
touch src/core/__init__.py src/ingestion/__init__.py tests/__init__.py

read -p "Do you want to wipe project-specific libraries (DuckDB, Telegram, etc.)? (y/n): " WIPE_LIBS
if [ "$WIPE_LIBS" == "y" ]; then
    # Keep only the framework section
    sed -i '/🛠️ \[DOMAIN LIBRARIES\]/q' requirements-dev.txt
    echo "✅ requirements-dev.txt reset to Framework Core."
fi

# 5. Reset Git (Optional)
read -p "Do you want to reset Git history for a fresh start? (y/n): " RESET_GIT
if [ "$RESET_GIT" == "y" ]; then
    rm -rf .git
    git init
    git branch -m main
    echo "✨ Git history reset."
fi

# 6. Install Hooks
echo "🪝  Installing Git hooks..."
./scripts/install_hooks.sh

echo "✅ $NEW_NAME is ready for Vibe Coding."
