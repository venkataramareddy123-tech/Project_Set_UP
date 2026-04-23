#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "🚀 Running sync..."

if [[ -x "./venv/bin/python" ]]; then
    PYTHON_BIN="./venv/bin/python"
else
    PYTHON_BIN="python3"
fi

CHECK_EXIT=0

./scripts/fix.sh || true
./scripts/check.sh || CHECK_EXIT=$?

echo "📜 Updating repository memory..."

"$PYTHON_BIN" scripts/archive_roadmap.py >/dev/null || true
"$PYTHON_BIN" scripts/generate_repomap.py >/dev/null
"$PYTHON_BIN" scripts/generate_status.py >/dev/null

if [[ $CHECK_EXIT -ne 0 ]]; then
    echo "❌ Sync finished with failing checks."
    exit "$CHECK_EXIT"
fi

echo "✅ Sync complete."
