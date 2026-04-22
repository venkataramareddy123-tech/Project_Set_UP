# ADR 0001: The Vibe Coding Framework

## Status
Accepted

## Context
As project complexity grows and multiple AI agents (Gemini, Codex, etc.) or human developers interact with the codebase, project "drift" and architectural amnesia become significant risks. LLMs often lose track of the project's roadmap, coding standards, and architectural decisions as session context resets.

## Decision
We implement a "Vibe Coding" framework that decentralizes project intelligence into the repository itself. This includes:
1.  **Context-First Protocols**: `docs/CONTEXT.md` and `docs/ROADMAP.md` as the primary system prompts.
2.  **Structural Mapping**: `docs/REPO_MAP.md` for token-efficient architecture discovery.
3.  **Mandatory Work Cycles**: `scripts/sync.sh` to enforce linting, type-checking, and status generation.
4.  **Autonomous State Management**: Auto-updating status dashboards and test failure logs.

## Consequences
- **Positive**: Seamless handoffs between AI agents, reduced context window costs, and high architectural consistency.
- **Negative**: Adds a small amount of overhead (1-2 seconds) to the edit/commit loop.
