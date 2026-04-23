"""Restore a workspace snapshot created by snapshot_workspace.py."""

from __future__ import annotations

import json
import shutil
import sys
from pathlib import Path


def restore_snapshot(snapshot_name: str) -> Path:
    if not snapshot_name:
        raise ValueError("Snapshot name is required.")

    root = Path(__file__).resolve().parent.parent
    snapshot_dir = root / ".snapshots" / snapshot_name
    files_dir = snapshot_dir / "files"
    manifest_path = snapshot_dir / "manifest.json"

    if not manifest_path.exists() or not files_dir.exists():
        raise FileNotFoundError(f"Snapshot '{snapshot_name}' is missing or incomplete.")

    with manifest_path.open("r", encoding="utf-8") as file:
        manifest = json.load(file)

    for relative in manifest.get("files", []):
        source = files_dir / relative
        destination = root / relative
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source, destination)

    return snapshot_dir


def main(argv: list[str]) -> int:
    if len(argv) < 2:
        raise SystemExit("Usage: python3 scripts/restore_snapshot.py <snapshot-name>")

    snapshot_dir = restore_snapshot(argv[1])
    print(f"✅ Restored snapshot from {snapshot_dir}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
