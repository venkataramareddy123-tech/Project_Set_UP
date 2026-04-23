import ast
from pathlib import Path

def generate_repo_map(root_dir, output_file):
    repo_map = []
    root_path = Path(root_dir)
    
    # Exclude directories that are not part of the source code or docs
    exclude_dirs = {".venv", "venv", ".git", ".ruff_cache", "__pycache__", "data", "tests"}
    
    repo_map.append("# Repository Map\n")
    repo_map.append("This file is generated to give agents a lightweight overview of the repository.\n")

    # Scan all python files in the project root
    for py_file in sorted(root_path.rglob("*.py")):
        # Check if any part of the path is in the exclusion list
        if any(ex in py_file.parts for ex in exclude_dirs):
            continue
        
        relative_path = py_file.relative_to(root_path)
        repo_map.append(f"### 📄 `{relative_path}`")
        
        with open(py_file, "r") as f:
            try:
                tree = ast.parse(f.read())
            except Exception as e:
                repo_map.append(f"  - *Error parsing file: {e}*")
                continue

            # 1. Extract Module Docstring
            module_doc = ast.get_docstring(tree)
            if module_doc:
                repo_map.append(f"  > **Module Context:** {module_doc.splitlines()[0]}")

            for node in tree.body:
                if isinstance(node, ast.ClassDef):
                    doc = ast.get_docstring(node)
                    repo_map.append(f"#### 🏛️ Class: `{node.name}`")
                    if doc:
                        repo_map.append(f"  > {doc.splitlines()[0]}")
                    
                    for item in node.body:
                        if isinstance(item, ast.FunctionDef):
                            # Skip internal/private functions to save tokens
                            if item.name.startswith("_") and item.name != "__init__":
                                continue
                            args = [arg.arg for arg in item.args.args]
                            repo_map.append(f"  - `def {item.name}({', '.join(args)})`")
                
                elif isinstance(node, ast.FunctionDef):
                    # Skip internal/private functions
                    if node.name.startswith("_"):
                        continue
                    doc = ast.get_docstring(node)
                    args = [arg.arg for arg in node.args.args]
                    repo_map.append(f"#### 🔧 Function: `{node.name}({', '.join(args)})`")
                    if doc:
                        repo_map.append(f"  > {doc.splitlines()[0]}")
        repo_map.append("")

    with open(output_file, "w") as f:
        f.write("\n".join(repo_map))
    print(f"✅ Repository map generated at: {output_file}")

if __name__ == "__main__":
    base_dir = Path(__file__).parent.parent
    output = base_dir / "docs" / "REPO_MAP.md"
    generate_repo_map(base_dir, output)
