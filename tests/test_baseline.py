from pathlib import Path


def test_required_docs_exist() -> None:
    root = Path(__file__).resolve().parent.parent
    required = [
        "docs/ACTIVE_TASK.md",
        "docs/AGENT_CONTRACT.md",
        "docs/CONTEXT.md",
        "docs/ROADMAP.md",
    ]
    for relative_path in required:
        assert (root / relative_path).exists(), f"Missing required file: {relative_path}"


def test_required_scripts_exist() -> None:
    root = Path(__file__).resolve().parent.parent
    required = [
        "scripts/check.sh",
        "scripts/fix.sh",
        "scripts/install_hooks.sh",
        "scripts/sync.sh",
        "scripts/snapshot_workspace.py",
        "scripts/restore_snapshot.py",
    ]
    for relative_path in required:
        assert (root / relative_path).exists(), f"Missing required file: {relative_path}"
