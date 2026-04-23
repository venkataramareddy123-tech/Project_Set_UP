# 🌌 The Ultimate Vibe Coding Boilerplate (v3.1)

> **"Machine-Trustworthy. Agent-First. Deterministic."**

This is an **Autonomous Software Node** designed for the age of AI coding agents. Unlike traditional boilerplates, this framework prioritizes **machine-truthful verification** over human-readable promises. It is built to ensure that any CLI agent (Gemini, Codex, Cursor) can operate with 100% architectural sovereignty through rigid contracts and deterministic status signals.

---

## 🚀 Key Features

### 1. The Machine-Truth Protocol
- **Deterministic State**: System health is not "guessed"; it is verified and stored in `.vibe/check_summary.json` following a strict schema.
- **Agent Contract**: A binding set of rules in `docs/AGENT_CONTRACT.md` that governs how AI interacts with your code.
- **Hard Guardrails**: The `./scripts/check.sh` command is a strict quality gate that blocks commits and deployment on any failure (lint, type, test, or dependency).

### 2. Agent-First Architecture
- **Automatic Context Maintenance**: The repository actively maintains its own `REPO_MAP.md` and `SYSTEM_STATUS.md`.
- **Slash Protocol Sync**: Custom protocols ensure agents always have a "Context Diet"—reading only what they need to execute the next micro-step.
- **Zero-Ambiguity Setup**: `./scripts/bootstrap.sh` and `./scripts/install_hooks.sh` ensure the environment is perfectly primed for autonomous work.

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

The framework operates on a continuous feedback loop designed for both AI and human efficiency:

1.  **Agent Commands (`/continue`)**: AI reads the current state from `docs/` and plans the next step.
2.  **Implementation**: Changes are applied to `src/` and `tests/`.
3.  **Sync & Check (`scripts/sync.sh`)**: 
    -   `fix.sh` auto-heals linting/formatting.
    -   `check.sh` enforces strict verification (types, tests, dependencies).
    -   Failure results in a non-zero exit code, blocking commits.
4.  **Status Generation**: `generate_status.py` parses machine-readable results into the `SYSTEM_STATUS.md` dashboard.
5.  **Handoff (`/summarize`)**: Progress is archived, and the next session is primed.

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
