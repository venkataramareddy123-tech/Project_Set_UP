#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

echo "🪝 Installing Git hooks..."

HOOKS_DIR=".git/hooks"
PRE_COMMIT_HOOK="$HOOKS_DIR/pre-commit"

if [[ ! -d ".git" ]]; then
    echo "⚠️ .git directory not found. Skipping hook installation."
    exit 0
fi

mkdir -p "$HOOKS_DIR"

cat <<'EOF' > "$PRE_COMMIT_HOOK"
#!/usr/bin/env bash
set -euo pipefail

echo "🛑 Running repository sync before commit..."
./scripts/sync.sh
EOF

chmod +x "$PRE_COMMIT_HOOK"

echo "✅ Git hooks installed."
