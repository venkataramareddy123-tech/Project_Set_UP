#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "🔧 Running auto-fix..."

if [[ -x "./venv/bin/ruff" ]]; then
    RUFF_BIN="./venv/bin/ruff"
elif command -v ruff >/dev/null 2>&1; then
    RUFF_BIN="$(command -v ruff)"
else
    RUFF_BIN=""
fi

if [[ -n "$RUFF_BIN" ]]; then
    "$RUFF_BIN" check . --fix
    echo "✨ Ruff fixes applied."
else
    echo "⚠️ Ruff not found. Skipping auto-fix."
fi

echo "✅ Fix complete."
