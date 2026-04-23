# Architecture

This is the canonical high-level design document for the software being built in this repository.

Agents should treat this file as the top-down source of intent before turning work into milestones, tasks, and code changes.

## Product Vision

Describe the big idea here: what the system should become, who it serves, and what outcome it should produce.

## Target Users

- Primary users:
- Secondary users:
- Operators or maintainers:

## Core Capabilities

- Capability 1:
- Capability 2:
- Capability 3:

## System Shape

Describe the intended architecture at a high level. Include major apps, services, modules, storage, external APIs, queues, background jobs, agents, or local tools.

## Data Model

Describe the important entities, state, files, databases, events, and data ownership boundaries.

## Interfaces

Describe user interfaces, APIs, CLIs, background jobs, integrations, and automation entrypoints.

## Quality Requirements

- Reliability:
- Security:
- Privacy:
- Performance:
- Observability:
- Maintainability:

## Constraints

List technical, business, platform, budget, timeline, or deployment constraints that should guide implementation choices.

## Open Questions

- Question 1:
- Question 2:

## Agent Planning Rules

1. Use this file to understand the full intended system before proposing work.
2. Convert architecture intent into milestones in `docs/ROADMAP.md`.
3. Convert the next milestone into one concrete task in `docs/ACTIVE_TASK.md`.
4. Keep code changes small enough to verify with `./scripts/sync.sh`.
5. Update this file when the big system idea or architecture changes materially.
