#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

JSON_MODE=false
if [[ "${1:-}" == "--json" || "${1:-}" == "--ci" ]]; then
    JSON_MODE=true
fi

mkdir -p .vibe
SUMMARY_FILE=".vibe/check_summary.json"
TOOLS_TMP=".vibe/tools.tmp"

START_TIME=$(date +%s%N)
OVERALL_STATUS="pass"
GIT_COMMIT=$(git rev-parse HEAD 2>/dev/null || echo "untracked")

PYTHON_BIN="${PYTHON_BIN:-}"
if [[ -z "$PYTHON_BIN" ]]; then
    if [[ -x "./venv/bin/python" ]]; then
        PYTHON_BIN="./venv/bin/python"
    else
        PYTHON_BIN="python3"
    fi
fi

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
    set +e
    bash -lc "$cmd" > "$details" 2>&1
    exit_code=$?
    set -e
    end=$(date +%s%N)

    local duration=$(((end - start) / 1000000))
    if [[ $exit_code -ne 0 ]]; then
        status="fail"
        OVERALL_STATUS="fail"
    fi

    echo "  \"$name\": { \"status\": \"$status\", \"exit_code\": $exit_code, \"duration_ms\": $duration, \"details_file\": \"$details\" }," >> "$TOOLS_TMP"
}

resolve_tool() {
    local tool_name=$1
    if [[ -x "./venv/bin/$tool_name" ]]; then
        echo "./venv/bin/$tool_name"
        return 0
    fi
    if command -v "$tool_name" >/dev/null 2>&1; then
        command -v "$tool_name"
        return 0
    fi
    return 1
}

lint_cmd=$(resolve_tool "ruff" || true)
type_cmd=$(resolve_tool "mypy" || true)
test_cmd=$(resolve_tool "pytest" || true)

rm -f "$TOOLS_TMP" .vibe/*.log

if [[ -n "$lint_cmd" ]]; then
    run_tool "lint" "$lint_cmd check ." ".vibe/lint.log"
else
    run_tool "lint" "echo 'ruff not found. Install requirements-dev.txt.'; exit 127" ".vibe/lint.log"
fi

if [[ -n "$type_cmd" ]]; then
    run_tool "typecheck" "$type_cmd src tests --ignore-missing-imports" ".vibe/typecheck.log"
else
    run_tool "typecheck" "echo 'mypy not found. Install requirements-dev.txt.'; exit 127" ".vibe/typecheck.log"
fi

if [[ -n "$test_cmd" ]]; then
    run_tool "tests" "$test_cmd tests --quiet" ".vibe/test_failures.log"
else
    run_tool "tests" "echo 'pytest not found. Install requirements-dev.txt.'; exit 127" ".vibe/test_failures.log"
fi

run_tool "dependency_audit" "$PYTHON_BIN scripts/check_deps.py" ".vibe/deps.log"

END_TIME=$(date +%s%N)
TOTAL_DURATION=$(((END_TIME - START_TIME) / 1000000))
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
PY_VERSION=$("$PYTHON_BIN" --version | cut -d' ' -f2)

sed -i '$ s/,$//' "$TOOLS_TMP"

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
$(cat "$TOOLS_TMP")
  }
}
EOF

rm -f "$TOOLS_TMP"

if [[ "$JSON_MODE" == true ]]; then
    cat "$SUMMARY_FILE"
fi

if [[ "$OVERALL_STATUS" == "fail" ]]; then
    echo "❌ Checks failed."
    exit 1
fi

echo "✅ All checks passed ($TOTAL_DURATION ms)."
