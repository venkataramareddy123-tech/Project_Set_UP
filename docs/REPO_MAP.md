# Repository Map

This file is generated to give agents a lightweight overview of the repository.

### 📄 `scripts/archive_roadmap.py`
#### 🔧 Function: `archive_roadmap()`

### 📄 `scripts/check_deps.py`
#### 🔧 Function: `get_imports(file_path)`
#### 🔧 Function: `check_dependencies()`

### 📄 `scripts/generate_repomap.py`
#### 🔧 Function: `generate_repo_map(root_dir, output_file)`

### 📄 `scripts/generate_status.py`
#### 🔧 Function: `get_icon(status_value)`
#### 🔧 Function: `load_expected_checks(config_file)`
#### 🔧 Function: `generate_system_status()`

### 📄 `scripts/restore_snapshot.py`
  > **Module Context:** Restore a workspace snapshot created by snapshot_workspace.py.
#### 🔧 Function: `restore_snapshot(snapshot_name)`
#### 🔧 Function: `main(argv)`

### 📄 `scripts/snapshot_workspace.py`
  > **Module Context:** Create a restorable snapshot of the current workspace state.
#### 🔧 Function: `should_copy(path, root)`
#### 🔧 Function: `snapshot_workspace(snapshot_name)`
#### 🔧 Function: `main(argv)`

### 📄 `src/__init__.py`

### 📄 `src/starter.py`
  > **Module Context:** Starter helpers that describe the template's supported project profiles.
#### 🔧 Function: `starter_message()`
  > Return the current starter positioning.
#### 🔧 Function: `supported_profiles()`
  > Return the bootstrap profiles shipped with the template.
