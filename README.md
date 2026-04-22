# 🌌 The Ultimate Vibe Coding Boilerplate (v3.0)

> **"Code at the speed of thought, governed by the speed of logic."**

This is not just a repository; it is an **Autonomous Software Node**. This boilerplate was designed to solve the three greatest challenges in AI-assisted development: **Context Amnesia**, **Attention Dilution**, and **Architectural Desync**.

By decentralizing project intelligence into the repository itself, this framework ensures that any AI agent (Gemini, Codex, Cursor, etc.) or human developer can pick up the project and immediately understand the "Vibe," the "Why," and the "Next Step."

---

## 🚀 Key Features

### 1. The AI Handshake (Slash Protocols)
Custom-built protocols that synchronize the agent with the project state.
- **/continue**: Triggers a deep-sync. The agent reads the `CONTEXT.md`, the `SYSTEM_STATUS.md`, and the `ACTIVE_TASK.md` to plan and execute the next micro-step.
- **/summarize**: Safely finalizes a session, archiving progress and recording the "handoff state" for the next agent.
- **/review**: An autonomous QA gate where the AI acts as a Senior Staff Engineer to audit its own code before committing.
- **/commit**: Automates high-quality Conventional Commits based on the staged diff.

### 2. The Robustness Suite (Local CI/CD)
The framework enforces a **Mandatory Work Cycle** through a unified `./scripts/sync.sh` script:
- **Linting:** Automatic syntax correction via `Ruff`.
- **Type Safety:** Strict type-checking via `Mypy` to prevent async/logic bugs.
- **Empirical Testing:** Automated `Pytest` execution. Failures are cached in `.vibe/test_failures.log` for self-healing.
- **Dependency Audit:** AST-based scanning to ensure `requirements-dev.txt` is always up to date.

### 3. Infinite Scaling & Token Efficiency
- **The Context Diet**: Protocols ensure the AI only reads what it needs, saving thousands of tokens per hour.
- **Compressed Repo Map**: A structural overview of the codebase that omits internal details to minimize the context footprint.
- **Roadmap Archiver**: Automatically migrates completed tasks to `CHANGELOG.md` to keep the active roadmap lean.

### 4. Human-AI Synchronization (Git Hooks)
A `pre-commit` hook that acts as the "Ultimate Enforcer." Even if a human developer forgets to run the sync script, Git will auto-run the sync and stage all changes.

### 5. The Vibe Bootstrapper (`scripts/bootstrap.sh`)
Turn this template into a new project in seconds. It rebrands files, resets the roadmap, and cleans up example code while keeping the framework intact.

### 6. Token-Saver Search (`scripts/search.sh`)
An AI-optimized search tool. Instead of reading entire knowledge files, the AI can find relevant snippets, saving thousands of tokens.

---

## 📁 Architectural Overview
...
---

## 🛠️ Setup Instructions

### 1. Initialize for a New Project
```bash
git clone https://github.com/venkataramareddy123-tech/Project_Set_UP.git my-new-project
cd my-new-project
./scripts/bootstrap.sh  # Follow the prompts to rebrand
```

### 2. Environment Setup
```bash
python3 -m venv venv
source venv/bin/activate  # Or venv\Scripts\activate on Windows
pip install -r requirements-dev.txt
```

### 3. Initialize the Vibe
```bash
chmod +x scripts/*.sh
mkdir -p .git/hooks && cp scripts/sync.sh .git/hooks/pre-commit # If not already linked
./scripts/sync.sh
```

---

## 🧭 How to Use

1. **Pick a Task:** Look at `docs/ROADMAP.md`.
2. **Trigger /continue:** Tell the AI to `/continue`. It will extract the task into `docs/ACTIVE_TASK.md`.
3. **Build:** The AI works through micro-steps.
4. **Finalize:**
   - `./scripts/sync.sh` (Auto-runs during commit).
   - `/review` (AI-led QA).
   - `/commit` (AI-generated commit).

---

## 🧠 Why we built this?
We built this because AI agents are only as good as the context they are given. By creating a project that **actively maintains its own context**, we eliminate the need for long, repetitive setup prompts. You can fork this repo, start a new AI session, and say "Build me a trading bot," and the framework will handle the focus, the documentation, the testing, and the history for you.

**It is "Smooth like Butter" by design.**
