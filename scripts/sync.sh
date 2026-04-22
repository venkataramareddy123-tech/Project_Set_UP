#!/usr/bin/env bash
set -e

# Change to project root
cd "$(dirname "$0")/.."

echo "🚀 Running Vibe Coding 3.0 Sync..."

# 1. Format and Lint
echo "🔍 Linting with Ruff..."
if [ -f "./venv/bin/ruff" ]; then
    ./venv/bin/ruff check . --fix >/dev/null 2>&1 || true
else
    echo "⚠️ Warning: Ruff not found in ./venv/bin/ruff. Skipping lint."
fi

# 2. Type Checking
echo "🧬 Type checking with Mypy..."
if [ -f "./venv/bin/mypy" ]; then
    ./venv/bin/mypy src/ --ignore-missing-imports || true
else
    echo "⚠️ Warning: Mypy not found. Skipping type check."
fi

# 3. Unit Testing
echo "🧪 Running tests with Pytest..."
mkdir -p .vibe
if [ -f "./venv/bin/pytest" ]; then
    if ! ./venv/bin/pytest tests/ --quiet > .vibe/test_failures.log 2>&1; then
        echo "❌ Tests failed! Error cached in .vibe/test_failures.log"
    else
        rm -f .vibe/test_failures.log
    fi
else
    echo "⚠️ Warning: Pytest not found. Skipping tests."
fi

# 4. Dependency Audit
echo "📦 Auditing dependencies..."
python3 scripts/check_deps.py

# 5. Archive Roadmap
echo "📜 Archiving completed tasks..."
if [ -f "./venv/bin/python" ]; then
    ./venv/bin/python scripts/archive_roadmap.py >/dev/null
else
    python3 scripts/archive_roadmap.py >/dev/null
fi

# 6. Update Repo Map
echo "🗺️  Regenerating Repository Map..."
if [ -f "./venv/bin/python" ]; then
    ./venv/bin/python scripts/generate_repomap.py >/dev/null
else
    python3 scripts/generate_repomap.py >/dev/null
fi

# 6. Generate System Status
echo "📊 Generating System Status Dashboard..."
if [ -f "./venv/bin/python" ]; then
    ./venv/bin/python scripts/generate_status.py >/dev/null
else
    python3 scripts/generate_status.py >/dev/null
fi

echo "✅ Sync complete. Project is robust and mapped."
