import json
from pathlib import Path


def test_vibe_config_lists_required_files() -> None:
    root = Path(__file__).resolve().parent.parent
    config = json.loads((root / ".vibe" / "config.json").read_text())
    for relative_path in config["required_scripts"]:
        assert (root / relative_path).exists()
    for relative_path in config["required_docs"]:
        assert (root / relative_path).exists()


def test_check_summary_is_generated_file_not_template_source() -> None:
    root = Path(__file__).resolve().parent.parent
    gitignore = (root / ".gitignore").read_text()
    assert ".vibe/check_summary.json" in gitignore


def test_vibe_config_lists_expected_checks() -> None:
    root = Path(__file__).resolve().parent.parent
    config = json.loads((root / ".vibe" / "config.json").read_text())
    assert config["expected_checks"] == [
        "lint",
        "typecheck",
        "tests",
        "dependency_audit",
    ]
