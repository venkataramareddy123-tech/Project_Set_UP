"""Create a restorable snapshot of the current workspace state."""

from __future__ import annotations

import json
import shutil
import sys
import time
from pathlib import Path


EXCLUDE_DIRS = {
    ".git",
    "venv",
    ".venv",
    "__pycache__",
    ".mypy_cache",
    ".pytest_cache",
    ".ruff_cache",
    ".snapshots",
}
EXCLUDE_FILES = {".vibe/check_summary.json"}


def should_copy(path: Path, root: Path) -> bool:
    relative = path.relative_to(root)
    if any(part in EXCLUDE_DIRS for part in relative.parts):
        return False
    if str(relative) in EXCLUDE_FILES:
        return False
    if relative.parts and relative.parts[0] == ".vibe" and relative.suffix == ".log":
        return False
    return True


def snapshot_workspace(snapshot_name: str) -> Path:
    root = Path(__file__).resolve().parent.parent
    snapshots_dir = root / ".snapshots"
    snapshots_dir.mkdir(exist_ok=True)

    if not snapshot_name:
        snapshot_name = time.strftime("snapshot-%Y%m%d-%H%M%S")

    snapshot_dir = snapshots_dir / snapshot_name
    if snapshot_dir.exists():
        raise FileExistsError(f"Snapshot '{snapshot_name}' already exists.")

    files_dir = snapshot_dir / "files"
    files_dir.mkdir(parents=True)

    tracked_files: list[str] = []
    for path in root.rglob("*"):
        if not path.is_file():
            continue
        if not should_copy(path, root):
            continue

        relative = path.relative_to(root)
        destination = files_dir / relative
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, destination)
        tracked_files.append(str(relative))

    manifest = {
        "name": snapshot_name,
        "created_at": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "file_count": len(tracked_files),
        "files": tracked_files,
    }
    with (snapshot_dir / "manifest.json").open("w", encoding="utf-8") as file:
        json.dump(manifest, file, indent=2)

    return snapshot_dir


def main(argv: list[str]) -> int:
    snapshot_name = argv[1] if len(argv) > 1 else ""
    snapshot_dir = snapshot_workspace(snapshot_name)
    print(f"✅ Snapshot created at {snapshot_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
