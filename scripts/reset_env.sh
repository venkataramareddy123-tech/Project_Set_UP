#!/usr/bin/env bash
echo "🔄 Resetting Environment..."
# Remove Python caches
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -type d -name ".pytest_cache" -exec rm -rf {} +
find . -type d -name ".ruff_cache" -exec rm -rf {} +
# Clear logs and local data
rm -f .vibe/test_failures.log
rm -f tests/*.db
rm -f data/*.db data/*.db-wal data/*.db-shm
echo "✨ Environment Cleaned."
