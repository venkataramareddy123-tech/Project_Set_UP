# 🗺️ QuantumSurge V2: Repository Map

This map provides a structural overview of the codebase to optimize AI context usage.

### 📄 `scripts/archive_roadmap.py`
#### 🔧 Function: `archive_roadmap()`

### 📄 `scripts/check_deps.py`
#### 🔧 Function: `get_imports(file_path)`
#### 🔧 Function: `check_dependencies()`

### 📄 `scripts/generate_repomap.py`
#### 🔧 Function: `generate_repo_map(root_dir, output_file)`

### 📄 `scripts/generate_status.py`
#### 🔧 Function: `generate_system_status()`

### 📄 `src/__init__.py`

### 📄 `src/core/__init__.py`

### 📄 `src/core/chaos.py`
#### 🔧 Function: `calculate_wealth(amount)`
  > Calculates wealth by doubling the amount.

### 📄 `src/core/database.py`
#### 🏛️ Class: `DatabaseManager`
  > Manages the DuckDB connection and high-performance analytical storage.
  - `def __init__(self, db_path)`
  - `def get_connection(self)`
  - `def close(self)`

### 📄 `src/ingestion/async_fetcher.py`
#### 🏛️ Class: `AsyncFetcher`
  > Base class for high-concurrency data ingestion using httpx and asyncio.
  - `def __init__(self, timeout, concurrency_limit)`
