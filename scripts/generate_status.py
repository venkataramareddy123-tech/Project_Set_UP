import json
import time
from pathlib import Path


def get_icon(status_value: str) -> str:
    if status_value == "pass":
        return "✅"
    if status_value == "fail":
        return "❌"
    return "⚠️"


def load_expected_checks(config_file: Path) -> list[str]:
    if not config_file.exists():
        return ["lint", "typecheck", "tests", "dependency_audit"]

    with config_file.open("r", encoding="utf-8") as file:
        config = json.load(file)

    return config.get(
        "expected_checks",
        ["lint", "typecheck", "tests", "dependency_audit"],
    )


def generate_system_status() -> None:
    root_path = Path(__file__).parent.parent
    src_path = root_path / "src"
    test_path = root_path / "tests"
    output_file = root_path / "docs" / "SYSTEM_STATUS.md"
    summary_file = root_path / ".vibe" / "check_summary.json"
    config_file = root_path / ".vibe" / "config.json"

    expected_checks = load_expected_checks(config_file)
    status_md: list[str] = []
    status_md.append("# 📊 System Status Dashboard\n")
    status_md.append(f"**Last Synchronized:** {time.strftime('%Y-%m-%d %H:%M:%S')}\n")

    checks: dict[str, dict[str, object]] = {}
    summary_data: dict[str, object] = {}
    verification_warning: str | None = None

    if summary_file.exists():
        try:
            with summary_file.open("r", encoding="utf-8") as file:
                summary_data = json.load(file)

            required_keys = {"schema_version", "overall_status", "tools"}
            if required_keys.issubset(summary_data):
                checks = summary_data.get("tools", {})
                template_version = summary_data.get("template_version", "Unknown")
                overall_status = str(summary_data.get("overall_status", "fail")).upper()
                status_md.append(f"**Template Version:** {template_version}")
                status_md.append(f"**Overall Health:** `{overall_status}`\n")
            else:
                verification_warning = (
                    "> 🚨 **Critical:** Check summary is malformed. Verification is untrustworthy.\n"
                )
        except Exception as exc:
            verification_warning = (
                f"> 🚨 **Critical:** Could not parse check summary: {exc}\n"
            )
    else:
        verification_warning = (
            "> ⚠️ **Warning:** No check summary found. Run `./scripts/sync.sh` to initialize.\n"
        )

    if verification_warning:
        status_md.append(verification_warning)

    total_loc = 0
    todos: list[str] = []

    for path in [src_path, test_path]:
        if not path.exists():
            continue
        for py_file in path.rglob("*.py"):
            if "__pycache__" in str(py_file):
                continue
            try:
                with py_file.open("r", encoding="utf-8") as file:
                    lines = file.readlines()
            except OSError:
                continue

            total_loc += len(lines)
            for index, line in enumerate(lines, start=1):
                if "TODO:" in line or "FIXME:" in line:
                    clean_line = line.strip().replace("#", "").strip()
                    todos.append(f"- `{py_file.relative_to(root_path)}:{index}`: {clean_line}")

    status_md.append("## 📈 Project Metrics")
    status_md.append(f"- **Total Lines of Python Code:** {total_loc}")
    status_md.append(f"- **Pending Tasks (TODOs):** {len(todos)}\n")

    if todos:
        status_md.append("### 📝 Pending TODOs")
        status_md.extend(todos)
        status_md.append("")

    status_md.append("## ✅ System Health (Machine-Verified)")

    if checks:
        missing_checks = [name for name in expected_checks if name not in checks]
        for check_name in expected_checks:
            data = checks.get(check_name)
            if not data:
                status_md.append(
                    f"- **{check_name.replace('_', ' ').capitalize()}:** ⚠️ Missing from check summary"
                )
                continue

            status_value = str(data.get("status", "unknown"))
            duration = data.get("duration_ms", 0)
            status_md.append(
                f"- **{check_name.replace('_', ' ').capitalize()}:** "
                f"{get_icon(status_value)} {status_value.capitalize()} ({duration}ms)"
            )

        for check_name, data in checks.items():
            if check_name in expected_checks:
                continue
            status_value = str(data.get("status", "unknown"))
            duration = data.get("duration_ms", 0)
            status_md.append(
                f"- **{check_name.replace('_', ' ').capitalize()}:** "
                f"{get_icon(status_value)} {status_value.capitalize()} ({duration}ms)"
            )

        if missing_checks:
            status_md.append(
                "\n> ⚠️ **Verification gap:** one or more expected checks were not recorded in "
                "`.vibe/check_summary.json`."
            )
    else:
        status_md.append("> 🚫 **No verification data available.**")

    git_commit = summary_data.get("git_commit")
    if git_commit:
        status_md.append(f"\n**Git Commit:** `{git_commit}`")

    with output_file.open("w", encoding="utf-8") as file:
        file.write("\n".join(status_md))
    print(f"✅ System status generated at: {output_file}")


if __name__ == "__main__":
    generate_system_status()
