#!/usr/bin/env bash
set -e

# Change to project root
cd "$(dirname "$0")/.."

echo "🔧 Running Vibe Coding Fix (Auto-Heal)..."

# 1. Format and Lint with Fix
if [ -f "./venv/bin/ruff" ]; then
    echo "🔍 Fixing lint issues with Ruff..."
    ./venv/bin/ruff check . --fix
    echo "✨ Lint fixes applied."
else
    echo "⚠️ Warning: Ruff not found in ./venv/bin/ruff. Skipping auto-fix."
fi

# 2. Add other auto-fixers here (e.g., black, isort if used)

echo "✅ Fix complete."
