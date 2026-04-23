# 📜 AGENT CONTRACT: The Vibe Coding Protocol (v3.1)

This contract is a BINDING set of rules for all AI agents. Adherence is mandatory to maintain repository integrity and deterministic state.

## 🛠️ Hard Rules for Agents

1.  **NO MANUAL DASHBOARD EDITS**: Never manually edit `docs/SYSTEM_STATUS.md`. It is machine-generated.
2.  **READ BEFORE CODING**: Always read `docs/ACTIVE_TASK.md` and `docs/CONTEXT.md` at the start of every implementation turn.
3.  **SYNC BEFORE FINALIZE**: You MUST run `./scripts/sync.sh` after any code changes and BEFORE calling `/summarize` or `/commit`.
4.  **MACHINE TRUTH**: Rely EXCLUSIVELY on `.vibe/check_summary.json` as the source of truth for system health.
5.  **NO FALSE CLAIMS**: Never claim checks "passed" unless the `overall_status` in the summary file is explicitly `"pass"`.
6.  **VERIFY THE VIBE**: If `.vibe/check_summary.json` is missing or malformed, assume the system is in a **FAILED** state and run `scripts/sync.sh` immediately.

## 🧬 Machine-Readable State
- **Config**: `.vibe/config.json`
- **Status Schema**: `.vibe/check_summary.json`
- **Protocol Version**: `3.1.0`

## 🚦 Operational Flow
1. `/continue` -> Read context.
2. Code -> Implement changes.
3. `scripts/sync.sh` -> Verify & Document.
4. Check Summary -> Validate "pass" state.
5. `/summarize` -> Handoff.

*Violation of this contract triggers immediate architectural review.*
