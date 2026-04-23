#!/usr/bin/env bash
set -e

# Change to project root
cd "$(dirname "$0")/.."

echo "🪝  Installing Vibe Coding Git Hooks..."

HOOKS_DIR=".git/hooks"
PRE_COMMIT_HOOK="$HOOKS_DIR/pre-commit"

if [ ! -d ".git" ]; then
    echo "⚠️ Warning: .git directory not found. Skipping hook installation."
    exit 0
fi

mkdir -p "$HOOKS_DIR"

# Create the pre-commit hook that calls scripts/check.sh
cat <<EOF > "$PRE_COMMIT_HOOK"
#!/usr/bin/env bash
# Vibe Coding: Pre-commit Guardrail
set -e

echo "🛑 Running Mandatory Quality Gate (scripts/check.sh)..."
./scripts/check.sh
EOF

chmod +x "$PRE_COMMIT_HOOK"

echo "✅ Git hooks installed and active."
