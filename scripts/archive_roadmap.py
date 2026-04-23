import time
from pathlib import Path


DEFAULT_CHANGELOG_HEADER = "# Changelog\n"


def archive_roadmap() -> None:
    root_path = Path(__file__).parent.parent
    roadmap_path = root_path / "docs" / "ROADMAP.md"
    changelog_path = root_path / "docs" / "CHANGELOG.md"

    if not roadmap_path.exists():
        print("Roadmap not found. Skipping archive.")
        return

    with roadmap_path.open("r", encoding="utf-8") as file:
        lines = file.readlines()

    completed_tasks: list[str] = []
    remaining_lines: list[str] = []

    for line in lines:
        if "- [x]" in line.lower():
            completed_tasks.append(line.strip())
        else:
            remaining_lines.append(line)

    if not completed_tasks:
        print("No completed tasks found to archive.")
        return

    with roadmap_path.open("w", encoding="utf-8") as file:
        file.writelines(remaining_lines)

    log_entry = [f"\n## [{time.strftime('%Y-%m-%d')}] Sync Archive\n"]
    log_entry.extend(completed_tasks)
    log_entry.append("\n")

    if changelog_path.exists():
        with changelog_path.open("a", encoding="utf-8") as file:
            file.write("\n".join(log_entry))
    else:
        with changelog_path.open("w", encoding="utf-8") as file:
            file.write(DEFAULT_CHANGELOG_HEADER)
            file.write("\n".join(log_entry))

    relative_path = changelog_path.relative_to(root_path)
    print(f"✅ Archived {len(completed_tasks)} tasks to {relative_path}")


if __name__ == "__main__":
    archive_roadmap()
