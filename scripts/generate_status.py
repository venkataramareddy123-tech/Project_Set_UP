import time
import json
from pathlib import Path

def generate_system_status():
    root_path = Path(__file__).parent.parent
    src_path = root_path / "src"
    test_path = root_path / "tests"
    output_file = root_path / "docs" / "SYSTEM_STATUS.md"
    summary_file = root_path / ".vibe" / "check_summary.json"

    status_md = []
    status_md.append("# 📊 System Status Dashboard\n")
    status_md.append(f"**Last Synchronized:** {time.strftime('%Y-%m-%d %H:%M:%S')}\n")

    # 1. Load and Validate Check Summary
    checks = {}
    overall_status = "UNKNOWN"
    summary_data = {}
    
    if summary_file.exists():
        try:
            with open(summary_file, "r") as f:
                summary_data = json.load(f)
                
            # Strict validation of schema
            required_keys = ["schema_version", "overall_status", "tools"]
            if all(k in summary_data for k in required_keys):
                checks = summary_data.get("tools", {})
                overall_status = summary_data.get("overall_status", "fail").upper()
                template_version = summary_data.get("template_version", "Unknown")
                status_md.append(f"**Template Version:** {template_version}")
                status_md.append(f"**Overall Health:** `{overall_status}`\n")
            else:
                overall_status = "COMPROMISED"
                status_md.append("> 🚨 **CRITICAL:** Check summary is malformed. Verification is untrustworthy.\n")
        except Exception as e:
            overall_status = "ERROR"
            status_md.append(f"> 🚨 **CRITICAL:** Could not parse check summary: {e}\n")
    else:
        overall_status = "MISSING"
        status_md.append("> ⚠️ **Warning:** No check summary found. Run `./scripts/sync.sh` to initialize.\n")

    # 2. Metrics (LOC, TODOs)
    total_loc = 0
    todos = []
    
    for path in [src_path, test_path]:
        if not path.exists():
            continue
        for py_file in path.rglob("*.py"):
            if "__pycache__" in str(py_file):
                continue
            try:
                with open(py_file, "r", encoding="utf-8") as f:
                    lines = f.readlines()
                    total_loc += len(lines)
                    for i, line in enumerate(lines):
                        if "TODO:" in line or "FIXME:" in line:
                            clean_line = line.strip().replace("#", "").strip()
                            todos.append(f"- `{py_file.relative_to(root_path)}:{i+1}`: {clean_line}")
            except Exception:
                pass

    status_md.append("## 📈 Project Metrics")
    status_md.append(f"- **Total Lines of Python Code:** {total_loc}")
    status_md.append(f"- **Pending Tasks (TODOs):** {len(todos)}\n")

    if todos:
        status_md.append("### 📝 Pending TODOs")
        status_md.extend(todos)
        status_md.append("")

    # 3. System Health (Truthful)
    status_md.append("## ✅ System Health (Machine-Verified)")
    
    def get_icon(status_val):
        if status_val == "pass":
            return "✅"
        if status_val == "fail":
            return "❌"
        return "❓"

    if checks:
        for tool, data in checks.items():
            name = tool.replace("_", " ").capitalize()
            status_val = data.get("status", "unknown")
            duration = data.get("duration_ms", 0)
            status_md.append(f"- **{name}:** {get_icon(status_val)} {status_val.capitalize()} ({duration}ms)")
    else:
        status_md.append("> 🚫 **No verification data available.**")

    # 4. Git Info
    if "git_commit" in summary_data:
        status_md.append(f"\n**Git Commit:** `{summary_data['git_commit']}`")

    with open(output_file, "w") as f:
        f.write("\n".join(status_md))
    print(f"✅ System status generated at: {output_file}")

if __name__ == "__main__":
    generate_system_status()
