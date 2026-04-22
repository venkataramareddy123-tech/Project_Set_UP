import time
from pathlib import Path

def archive_roadmap():
    root_path = Path(__file__).parent.parent
    roadmap_path = root_path / "docs" / "ROADMAP.md"
    changelog_path = root_path / "docs" / "CHANGELOG.md"

    if not roadmap_path.exists():
        print("Roadmap not found. Skipping archive.")
        return

    with open(roadmap_path, "r") as f:
        lines = f.readlines()

    completed_tasks = []
    remaining_lines = []
    
    for line in lines:
        if "- [x]" in line.lower() or "- [X]" in line:
            completed_tasks.append(line.strip())
        else:
            remaining_lines.append(line)

    if not completed_tasks:
        print("No completed tasks found to archive.")
        return

    # Update Roadmap (Remove [x] items)
    with open(roadmap_path, "w") as f:
        f.writelines(remaining_lines)

    # Append to Changelog
    log_entry = [f"\n## [{time.strftime('%Y-%m-%d')}] Sync Archive\n"]
    log_entry.extend([f"{task}" for task in completed_tasks])
    log_entry.append("\n")

    mode = "a" if changelog_path.exists() else "w"
    with open(changelog_path, mode) as f:
        if mode == "w":
            f.write("# 📜 QuantumSurge V2: Project Changelog\n")
        f.write("\n".join(log_entry))

    print(f"✅ Archived {len(completed_tasks)} tasks to {changelog_path.relative_to(root_path)}")

if __name__ == "__main__":
    archive_roadmap()
