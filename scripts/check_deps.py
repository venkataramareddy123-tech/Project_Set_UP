import ast
import sys
from pathlib import Path

def get_imports(file_path):
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
        try:
            tree = ast.parse(content)
        except Exception:
            return set()
    
    imports = set()
    for node in ast.walk(tree):
        if isinstance(node, ast.Import):
            for n in node.names:
                imports.add(n.name.split('.')[0])
        elif isinstance(node, ast.ImportFrom):
            if node.module:
                imports.add(node.module.split('.')[0])
    return imports

def check_dependencies():
    root_path = Path(__file__).parent.parent
    req_file = root_path / "requirements-dev.txt"
    src_path = root_path / "src"
    
    if not req_file.exists():
        print("❌ requirements-dev.txt not found!")
        return False
        
    with open(req_file, "r") as f:
        requirements = {line.split('==')[0].split('>=')[0].strip().lower() 
                        for line in f if line.strip() and not line.startswith('#')}
    
    std_libs = {"os", "sys", "pathlib", "ast", "asyncio", "json", "datetime", "typing", "collections", "abc", "functools", "logging"}
    requirements.update(std_libs)
    
    requirements.add("src")
    requirements.add("core")
    requirements.add("ingestion")
    requirements.add("bot")
    requirements.add("ui")

    found_missing = False
    for py_file in src_path.rglob("*.py"):
        file_imports = get_imports(py_file)
        for imp in file_imports:
            if imp.lower() not in requirements:
                print(f"⚠️  Missing dependency: '{imp}' imported in {py_file.relative_to(root_path)}")
                found_missing = True
    
    if found_missing:
        print("❌ Dependency audit failed. Please update requirements-dev.txt.")
        return False
    
    print("✅ Dependency audit passed.")
    return True

if __name__ == "__main__":
    if not check_dependencies():
        sys.exit(1)
