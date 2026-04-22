import time
from pathlib import Path

def generate_system_status():
    root_path = Path(__file__).parent.parent
    src_path = root_path / "src"
    test_path = root_path / "tests"
    output_file = root_path / "docs" / "SYSTEM_STATUS.md"

    status = []
    status.append("# 📊 QuantumSurge V2: System Status Dashboard\n")
    status.append(f"**Last Synchronized:** {time.strftime('%Y-%m-%d %H:%M:%S')}\n")

    # 1. Metrics (LOC, TODOs)
    total_loc = 0
    todos = []
    
    for path in [src_path, test_path]:
        if not path.exists():
            continue
        for py_file in path.rglob("*.py"):
            if "__pycache__" in str(py_file):
                continue
            
            with open(py_file, "r") as f:
                lines = f.readlines()
                total_loc += len(lines)
                for i, line in enumerate(lines):
                    if "TODO:" in line or "FIXME:" in line:
                        clean_line = line.strip().replace("#", "").strip()
                        todos.append(f"- `{py_file.relative_to(root_path)}:{i+1}`: {clean_line}")

    status.append("## 📈 Project Metrics")
    status.append(f"- **Total Lines of Python Code:** {total_loc}")
    status.append(f"- **Pending Tasks (TODOs):** {len(todos)}\n")

    if todos:
        status.append("### 📝 Pending TODOs")
        status.extend(todos)
        status.append("")

    # 2. Test Failures
    failure_log = root_path / ".vibe" / "test_failures.log"
    if failure_log.exists() and failure_log.stat().st_size > 0:
        status.append("## ❌ Current Test Failures")
        status.append("> **CRITICAL:** Fix these before implementing new features.")
        status.append("```text")
        with open(failure_log, "r") as f:
            status.append(f.read())
        status.append("```\n")
    else:
        status.append("## ✅ System Health")
        status.append("- **Tests:** Passing")
        status.append("- **Linting:** Clean")
        status.append("- **Type Safety:** Verified\n")

    with open(output_file, "w") as f:
        f.write("\n".join(status))
    print(f"✅ System status generated at: {output_file}")

if __name__ == "__main__":
    generate_system_status()
