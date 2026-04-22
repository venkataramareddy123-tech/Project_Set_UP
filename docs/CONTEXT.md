# ⚡ The "/continue" & "/summarize" Protocols (AI Handshake)

## 📌 Integrated Slash Commands
This project uses a shared handoff workflow across Gemini and Codex.
- In Gemini, project commands may be exposed through that client's custom command system.
- In Codex, treat `/continue` and `/summarize` as manual workflow prompts interpreted through `AGENTS.md` and this file.

## 📌 Command: "/continue"
When this command is triggered, the AI agent MUST:
1.  **Context Diet**: Read ONLY `docs/CONTEXT.md`, `docs/SYSTEM_STATUS.md`, and `docs/ACTIVE_TASK.md` by default.
2.  **Verify Tasks**: Check `.vibe/test_failures.log`. If it exists, fix reported errors before proceeding.
3.  **Lazy Load Knowledge**:
    -   ONLY read `docs/REPO_MAP.md` if architectural context is missing for the current task.
    -   ONLY read `docs/ROADMAP.md` if `docs/ACTIVE_TASK.md` is empty and a new task needs to be picked up.
    -   Check `docs/knowledge/` for API specs before performing new integrations.
4.  **Execute**: Follow the micro-steps in `docs/ACTIVE_TASK.md`.
5.  **Sync & Correct**: Run `./scripts/sync.sh` after any code change.

## 📌 Command: "/review" (The QA Gate)
Before calling `/commit`, you MUST run `/review`:
1.  Act as a senior QA lead.
2.  Analyze the diff and verify against `docs/ACTIVE_TASK.md`.
3.  Ensure edge cases, logging, and error handling are present.

## 📌 Command: "/commit" (The Finalizer)
Once `/review` passes and `sync.sh` is green:
1.  Run `/commit`.
2.  Generate a Conventional Commit message.

## 📌 Architectural Memory (ADRs)
For any significant architectural decision (changing databases, libraries, or core logic patterns), you MUST:
1.  Create a new Markdown file in `docs/ADRs/` (e.g., `0002-async-strategy.md`).
2.  Explain the Context, Decision, and Consequences.
3.  This ensures future AI sessions understand the "Why" behind the code.

## 📌 Command: "/summarize"
When this command is triggered (meaning the end of the session), the AI agent MUST:
1.  **Review the work** accomplished during the current session.
2.  **Update Session Notes:** Append a concise handoff summary to the bottom of `docs/ROADMAP.md`.
3.  **Final Cleanup:** Run `./scripts/sync.sh` one last time.
4.  **Output Summary:** Confirm state is saved, what changed, and what should happen next.

## 🛠️ Vibe Coding Rules (MANDATORY for AI)
- **Token Optimization:** Use the `REPO_MAP.md`.
- **Architecture Sovereignty:** Keep work in `/home/ram/QuantumSurge`.
- **Auto-Maintenance:** Always run `./scripts/sync.sh` after edits.
