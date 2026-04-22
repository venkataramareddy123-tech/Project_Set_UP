#!/usr/bin/env bash

# Ultimate Token-Saver Search Engine
# Usage: ./scripts/search.sh "query"

QUERY=$1
if [ -z "$QUERY" ]; then
    echo "Usage: ./scripts/search.sh \"query\""
    exit 1
fi

echo "🔍 Searching for '$QUERY'..."

# Search in code and docs, showing 2 lines of context, excluding binary/cache
grep -rniC 2 "$QUERY" --exclude-dir={.git,.venv,venv,__pycache__,.pytest_cache,.ruff_cache,.vibe,data} . | head -n 50

echo "-----------------------------------"
echo "💡 Tip: Read the specific file for full context if these snippets look relevant."
