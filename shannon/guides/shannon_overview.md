# Shannon — System Overview

**Version**: 4.0
**Last Updated**: 2026-05-15

---

## What Shannon Is

Shannon is a development framework for Claude Code, designed for solo developers and knowledge workers building software with AI assistance.

It solves a specific problem: the bottleneck in AI-assisted development is no longer "can the AI write the code" — it's "does the AI have the right context, and does the code stay aligned with intent?" Shannon takes the context-management burden off the developer by providing a structured documentation system, a unified work item lifecycle, and explicit human review gates at the highest-leverage moments.

The framework is built from four kinds of artefact:

- **Mandated documents** — Six core project documents describing the product at every relevant scope
- **Work items** — Features, Epics, Tasks, and Spikes, sharing a single status lifecycle
- **Knowledge notes** — Captured research, implementation details, and document extensions
- **Commands + Skills + Subagents** — The implementation layer: thin commands invoke reusable skills, which spawn subagents for context-heavy work

Everything is plain Markdown. Nothing requires a build step, a runtime, or network access.

---

## The Four Layers

```
Documentation Layer (six mandated documents + knowledge base)
    ↓ informs
Vision Layer (the supreme authority)
    ↓ elaborates into
Work Item Layer (Features → Epics → Tasks; plus Spikes)
    ↓ produces
Implementation Layer (code, content, deliverables)
```

The whole framework is in service of one principle: **information flows down, alignment flows up**. Lower documents must enable higher ones; lower work items must serve their parents.

---

## The Six Mandated Documents

Every Shannon project has these six documents, each with a defined purpose and scope:

| Document | Purpose |
|---|---|
| **vision.md** | Problem, vision statement, principles, target users, success metrics |
| **technology_stack.md** | Languages, frameworks, libraries, infrastructure, and why |
| **conceptual_design.md** | Domain entities, business rules, key workflows |
| **technical_design.md** | System architecture, data model, API design, key algorithms |
| **development_guide.md** | Code style, testing, git workflow, build, CI/CD, environment setup |
| **ux_guide.md** | Design principles, colours, typography, components, accessibility |

### Document Authority Graph

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

Lower documents must align to and enable higher documents. If the Vision describes a web application, the Technology Stack cannot specify desktop-only technology. The framework treats drift between layers as a defect, and `/document-review` checks for it.

### Document Status

Each mandated document has one of two statuses:

- **DRAFT** — Work in progress; not authoritative
- **APPROVED** — Human-reviewed and trustworthy as AI context

AI is expected to use APPROVED documents as authoritative context. When using DRAFT documents, AI surfaces the uncertainty to the user.

---

## The Four Work Item Types

| Type | What it is | Lifetime |
|---|---|---|
| **Feature** | A persistent capability of the product (what it *is*) | Forever — features accumulate epics over time |
| **Epic** | A coherent unit of work delivering part of a feature | Approved epics remain as historical record |
| **Task** | An atomic implementation work item | Archived once approved |
| **Spike** | A time-boxed investigation producing knowledge | Disposable; the knowledge note is the durable artefact |

### Hierarchy

```
Feature (persistent capability)
    └── Epic (coherent chunk of work)
            └── Task (atomic implementation)

Spike (standalone investigation)
```

- **Features → Epics → Tasks** is the primary traceability chain
- Tasks can be orphans (no epic) for one-off work
- Spikes are standalone but may link to a feature for context

### Unified Status Lifecycle

All four types use the same status flow:

```
DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED
     │           │          │                                       │
   Gate 1     Gate 2    (iterative zone)                         Gate 3
```

Three quality gates require explicit user approval:

1. **Gate 1 (DRAFT → ELABORATED)**: Are the requirements complete and aligned?
2. **Gate 2 (ELABORATED → PLANNED)**: Is the implementation plan sound?
3. **Gate 3 (REVIEW → APPROVED)**: Does the implementation meet requirements?

Between IMPLEMENTING, IMPLEMENTED, and REVIEW, AI and user iterate freely without crossing a gate.

### Shared Section Structure

Every work item file has the same sections:

- **Metadata** — Status, type, parent, dates
- **Requirements** — Filled at elaboration (Gate 1). What and why
- **Plan** — Filled at planning (Gate 2). How
- **Activity Log** — Timestamped history

Tasks add **Implementation Notes** and **Review** sections. Spikes have **Investigation Notes** and **Output** in place of typical Plan/Review content.

---

## The Three Quality Gates

Shannon's review model is built around three explicit human approval points. No micromanagement, no code review — just decisions where human judgement compounds.

### Gate 1: Requirements Elaboration

**Command**: `/[type]-elaborate [ID]` for work items, `/document-review [path]` for documents

**Question**: "Are the requirements (or this document's content) complete and correctly aligned to higher-authority documents?"

This is where the AI's reading of vision and prior context gets ratified by the human. After Gate 1, AI can confidently use these requirements as a basis for planning.

### Gate 2: Implementation Plan

**Command**: `/[type]-plan [ID]`

**Question**: "Is the proposed implementation approach sound?"

The plan describes *how* — components, dependencies, risks, ordered steps. This is where the developer applies architectural judgement before code (or content) gets written.

### Gate 3: Completion Review

**Command**: `/[type]-review [ID]`

**Question**: "Does the delivered work meet the agreed acceptance criteria?"

The human verifies outcomes against requirements. On approval, tasks are archived; epics and features stay in place as historical records.

---

## Knowledge Base

The knowledge base captures ad-hoc knowledge that doesn't fit in a mandated document:

- **Research** — General comparisons and investigations ("OAuth vs JWT")
- **Implementation Details** — How something was actually built ("oauth-implementation.md")
- **Extensions** — Detailed elaborations of mandated doc sections without changing the source doc

Knowledge notes live in `./docs/knowledge/`. Spikes produce knowledge notes as their primary output.

---

## Implementation: Commands + Skills + Subagents

Shannon's behaviour is implemented in three layers.

### Commands

User-invoked entry points at `./.claude/commands/`. Intentionally thin — each command identifies what to do and delegates to a skill.

Naming follows `[type]-[verb]` for predictability:

- `/shannon-setup` (one-off setup)
- `/document-create`, `/document-review` (documents)
- For each work item type (`feature`, `epic`, `task`, `spike`): `-create`, `-elaborate`, `-plan`, `-implement`, `-review`

### Skills

Reusable framework logic at `./.claude/skills/`. Three skills cover everything:

| Skill | Purpose |
|---|---|
| `project-setup` | Initialise a project with Shannon |
| `project-documentation` | Manage mandated documents and knowledge notes |
| `work-items` | Manage all work item types through their lifecycle |

Each skill ships with its templates (in `templates/` alongside the `skill.md` definition) and encodes the framework's process logic — how to elaborate, plan, implement, review, and which documents to consult at which stage.

### Subagents

Skills spawn subagents for context-heavy reading: pulling multiple documents into context, drafting elaborations or plans, running alignment checks. The subagent reads, writes drafts directly into work item files, and returns a structured summary to the main conversation. The main conversation stays focused on the user's actual work.

---

## Typical Workflows

### Setting Up a New Project

```
/shannon-setup
```

The `project-setup` skill detects existing state, deploys templates, instantiates mandated documents, and walks you through initial vision content.

### Creating and Approving a Mandated Document

```
/document-create vision        # Drafts vision.md
# Iterate on content
/document-review vision.md     # Gate 1: DRAFT → APPROVED
```

### Working a Task End-to-End

```
/task-create [hint]            # Captures intent → DRAFT
/task-elaborate TASK-042       # Reads parent epic/feature, drafts requirements
# Gate 1 — user approves → ELABORATED
/task-plan TASK-042            # Drafts implementation approach
# Gate 2 — user approves → PLANNED
/task-implement TASK-042       # Executes plan → IMPLEMENTING → IMPLEMENTED
/task-review TASK-042          # Verifies acceptance criteria
# Gate 3 — user approves → APPROVED → archived
```

### Running a Spike

```
/spike-create [hint]
/spike-elaborate SPIKE-001     # Sharpens question, agrees time-box (Gate 1)
/spike-plan SPIKE-001          # Defines investigation approach (Gate 2)
/spike-implement SPIKE-001     # Investigates within time-box; produces knowledge note
/spike-review SPIKE-001        # Confirms output captured (Gate 3)
```

The spike file is the activity record. The knowledge note in `./docs/knowledge/` is the durable artefact.

---

## File Structure

```
./.claude/
├── CLAUDE.md                 # Project-level AI guidance
├── commands/                 # Thin command files
├── skills/                   # Framework logic + templates
│   ├── project-setup/
│   ├── project-documentation/
│   └── work-items/
└── guides/                   # User-facing how-to (this file)

./docs/
├── vision.md
├── technology_stack.md
├── conceptual_design.md
├── technical_design.md
├── development_guide.md
├── ux_guide.md
├── features/                 # FEAT-XXX files + feature_index.md
├── epics/                    # EPIC-XXX files + epic_index.md
├── tasks/
│   ├── task_index.md
│   ├── TASK-XXX files
│   └── archive/              # Approved tasks land here
└── knowledge/                # Knowledge notes + knowledge_index.md

./spikes/                     # Spike files + spike_index.md (project root, not under docs/)
```

---

## Why "Shannon"?

Named after Claude Shannon (1916–2001), the father of information theory. Shannon's groundbreaking work on efficient information transmission and storage directly mirrors this framework's approach to AI context management:

- **Shannon's theory**: How to transmit maximum information with minimum bandwidth, despite noise
- **Shannon framework**: How to provide maximum context to AI with minimum overhead, despite long-running projects

Shannon (the person) proved that you can communicate perfectly despite noise if you structure information correctly. Shannon (the framework) bets that you can develop perfectly despite context limits if you structure documentation and workflow correctly.

---

## Where to Look Next

- **Skill definitions** — `./.claude/skills/*/skill.md` for the canonical behaviour of each skill
- **Command reference** — `./.claude/commands/README.md` for the full command surface
- **Templates** — `./.claude/skills/*/templates/` for the shape of each document and work item type
- **Dogfood docs** — `./docs/*.md` for an example of the framework applied to a real project (Shannon itself)
