#!/usr/bin/env bash
set -e

# Change to project root
cd "$(dirname "$0")/.."

echo "🚀 Running Vibe Coding 3.1 Sync (Orchestrator)..."

# 1. Auto-Heal
./scripts/fix.sh

# 2. Strict Check
./scripts/check.sh

# 3. Documentation and Maps
echo "📜 Updating Project Documentation..."

# Archive Roadmap
if [ -f "./venv/bin/python" ]; then
    ./venv/bin/python scripts/archive_roadmap.py >/dev/null
else
    python3 scripts/archive_roadmap.py >/dev/null
fi

# Regenerate Repository Map
if [ -f "./venv/bin/python" ]; then
    ./venv/bin/python scripts/generate_repomap.py >/dev/null
else
    python3 scripts/generate_repomap.py >/dev/null
fi

# Generate System Status Dashboard
if [ -f "./venv/bin/python" ]; then
    ./venv/bin/python scripts/generate_status.py >/dev/null
else
    python3 scripts/generate_status.py >/dev/null
fi

echo "✅ Sync complete. Project is robust and mapped."
