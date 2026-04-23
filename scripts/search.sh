#!/usr/bin/env bash
set -euo pipefail

QUERY="${1:-}"
if [[ -z "$QUERY" ]]; then
    echo "Usage: ./scripts/search.sh \"query\""
    exit 1
fi

echo "🔍 Searching for '$QUERY'..."

if command -v rg >/dev/null 2>&1; then
    rg -n -C 2 --glob '!.git' --glob '!venv' --glob '!.venv' --glob '!__pycache__' --glob '!.pytest_cache' --glob '!.ruff_cache' --glob '!.vibe' --glob '!data' "$QUERY" . | head -n 50
else
    grep -rniC 2 "$QUERY" --exclude-dir={.git,.venv,venv,__pycache__,.pytest_cache,.ruff_cache,.vibe,data} . | head -n 50
fi

echo "-----------------------------------"
echo "Tip: open the matching file once you see a relevant snippet."
