# CLAUDE.md

This file provides guidance to Claude Code when working in this project.

## Project Overview

**Project Name**: [Your project name]

[One or two sentence description of what this project does.]

---

## Documentation System

This project uses **Shannon** — a structured documentation system for AI-assisted development. All project documentation lives in `./docs/`.

### Core Principle

**Always read the relevant documentation before planning or implementing.** Documentation is the AI's context. Skipping it means re-asking questions, contradicting prior decisions, and drifting from the vision.

### Documentation Structure

```
./docs/
├── vision.md                 # Problem, vision, principles, target users
├── technology_stack.md       # Tech choices and rationale
├── conceptual_design.md      # Domain model and business rules
├── technical_design.md       # Architecture and implementation approach
├── development_guide.md      # Code style, testing, git, build, CI/CD, setup
├── ux_guide.md               # Design principles, colours, components, a11y
├── features/                 # Persistent product capabilities (FEAT-XXX)
├── epics/                    # Coherent units of work under a feature (EPIC-XXX)
├── tasks/                    # Atomic implementation work (TASK-XXX)
│   └── archive/              # Approved tasks live here
└── knowledge/                # Research, implementation details, doc extensions

./spikes/                     # Disposable exploratory work — output is knowledge
```

---

## Work Items

Shannon organises work into four types, each with the same lifecycle and file structure:

| Type | Persistence | Granularity |
|---|---|---|
| **Feature** | Persistent — what the product IS | 5-15 per project |
| **Epic** | Historical record once complete | 3-10 tasks each |
| **Task** | Archived once approved | One focused session |
| **Spike** | Disposable; output is a knowledge note | Hours, not days |

Primary chain: **Features → Epics → Tasks**. Spikes stand alone (may link to a feature for context). Tasks can be orphaned for one-off work.

### Unified Status Model

All work items move through the same lifecycle:

```
DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED
     │           │          │                                       │
   Gate 1     Gate 2    (iterative zone)                         Gate 3
```

**Three quality gates require explicit directing-party approval:**

1. **Gate 1 (DRAFT → ELABORATED)**: Are the requirements complete and aligned?
2. **Gate 2 (ELABORATED → PLANNED)**: Is the implementation plan sound?
3. **Gate 3 (REVIEW → APPROVED)**: Does the implementation meet requirements?

Between IMPLEMENTING, IMPLEMENTED, and REVIEW, the implementer and directing party iterate freely.

---

## Document Authority

Documents form a directed authority graph. Lower documents must **enable** higher documents — they must not contradict them.

```
                  Vision (supreme)
                 /              \
        Technology Stack    Conceptual Design
                 \              /
                  Technical Design
                        |
              ┌─────────┴─────────┐
        Development Guide      UX Guide
```

**Work items consume guides; they do not update them.** Higher-level work items (features, epics) may elaborate mid-level documents (technical_design.md); tasks only consume them.

---

## Slash Commands

### Project Setup

- `/shannon-setup` — Initialise this project with the Shannon framework

### Document Management

- `/document-create [type]` — Create a mandated document or knowledge note
- `/document-review [path]` — Review and approve a document

### Work Item Lifecycle

For each work item type (`feature`, `epic`, `task`, `spike`):

| Command | Purpose | Gate |
|---|---|---|
| `/[type]-create [hint]` | Create work item in DRAFT | — |
| `/[type]-elaborate [ID]` | Complete requirements | Gate 1 |
| `/[type]-plan [ID]` | Define implementation plan | Gate 2 |
| `/[type]-implement [ID]` | Execute the plan | — |
| `/[type]-review [ID]` | Verify and approve | Gate 3 |

See `./.claude/commands/README.md` for full command reference.

---

## Critical Guardrails

### Always

✅ Read relevant documents before elaborating, planning, or implementing
✅ Update the relevant index when creating or transitioning work items
✅ Capture decisions in the Activity Log of the work item
✅ Capture reusable learnings as knowledge notes
✅ Treat DRAFT documents as not-yet-authoritative

### Never

❌ Skip a quality gate — every gate requires explicit directing-party approval
❌ Plan or implement without reading the documents listed in the work item's Context section
❌ Update a Guide (Development Guide, UX Guide) from a task — guides are reference material
❌ Use DRAFT mandated documents as authoritative context

---

## Project-Specific Notes

[Add project-specific guidance here — anything Claude should know that isn't already captured in the mandated documents.]
