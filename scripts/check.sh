#!/usr/bin/env bash
set -e

# Change to project root
cd "$(dirname "$0")/.."

JSON_MODE=false
if [[ "$1" == "--json" || "$1" == "--ci" ]]; then
    JSON_MODE=true
fi

mkdir -p .vibe
SUMMARY_FILE=".vibe/check_summary.json"

# Initialize state
START_TIME=$(date +%s%N)
OVERALL_STATUS="pass"
GIT_COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "untracked")

# Tool runner function
# Usage: run_tool <name> <command> <details_file>
run_tool() {
    local name=$1
    local cmd=$2
    local details=$3
    local start
    local end
    local exit_code
    local status="pass"

    echo "🧪 Running $name..."
    start=$(date +%s%N)
    
    # Run command and capture exit code
    set +e
    eval "$cmd" > "$details" 2>&1
    exit_code=$?
    set -e
    
    end=$(date +%s%N)
    local duration=$(( (end - start) / 1000000 ))

    if [ $exit_code -ne 0 ]; then
        status="fail"
        OVERALL_STATUS="fail"
    fi

    # Append to temporary JSON building
    echo "  \"$name\": { \"status\": \"$status\", \"exit_code\": $exit_code, \"duration_ms\": $duration, \"details_file\": \"$details\" }," >> .vibe/tools.tmp
}

# Clear previous runs
rm -f .vibe/tools.tmp .vibe/*.log

# 1. Linting
run_tool "lint" "./venv/bin/ruff check ." ".vibe/lint.log"

# 2. Type Checking
run_tool "typecheck" "./venv/bin/mypy src/ --ignore-missing-imports" ".vibe/typecheck.log"

# 3. Unit Testing
run_tool "tests" "./venv/bin/pytest tests/ --quiet" ".vibe/test_failures.log"

# 4. Dependency Audit
run_tool "dependency_audit" "python3 scripts/check_deps.py" ".vibe/deps.log"

# Finalize JSON
END_TIME=$(date +%s%N)
TOTAL_DURATION=$(( (END_TIME - START_TIME) / 1000000 ))
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
PY_VERSION=$(python3 --version | cut -d' ' -f2)

# Remove trailing comma from tools.tmp
sed -i '$ s/,$//' .vibe/tools.tmp

cat <<EOF > "$SUMMARY_FILE"
{
  "schema_version": "1",
  "template_version": "3.1.0",
  "overall_status": "$OVERALL_STATUS",
  "timestamp": "$TIMESTAMP",
  "python_version": "$PY_VERSION",
  "git_commit": "$GIT_COMMIT",
  "total_duration_ms": $TOTAL_DURATION,
  "tools": {
$(cat .vibe/tools.tmp)
  }
}
EOF

rm -f .vibe/tools.tmp

if [ "$JSON_MODE" = true ]; then
    cat "$SUMMARY_FILE"
fi

if [ "$OVERALL_STATUS" = "fail" ]; then
    echo "❌ Checks failed. System is not robust."
    exit 1
fi

echo "✅ All checks passed ($TOTAL_DURATION ms)."
exit 0
