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
├── epics/                    # Optional execution organisation (EPIC-XXX)
├── tasks/                    # Optional execution notes (TASK-XXX)
│   └── archive/              # Existing archives; no automatic move
└── knowledge/                # Research, implementation details, doc extensions

./spikes/                     # Disposable exploratory work — output is knowledge
```

---

## Work Items

Features are persistent, human-governed product capabilities. Epics, Tasks and Spikes are optional agent-managed execution aids. Work directly against an approved Feature when useful; do not introduce a replacement work-order layer or require child files.

### Feature Status Model

`DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`

Human Gate 1 approves requirements/acceptance criteria; Gate 2 approves approach/consequential trade-offs; Gate 3 accepts delivered capability against evidence. Reuse actual explicit approval; silence and technical review cannot substitute for human acceptance.

Agents choose/revise execution plans and maintain factual documentation below approved Features. Optional records may retain legacy progress labels but have no mandatory sequence or human gates. Preserve old identifiers and history. Explicit project holds still require disposition.

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

Everything traces from the Vision through relevant documents and Features to implementation, checks and independent review. Maintenance traces through its governing engineering rule and product purpose. Agents maintain all relevant documents within approved meaning. Material scope, meaning, design, acceptance, access or cost changes return to the human before affected work.

---

## Slash Commands

### Project Setup

- `/shannon-setup` — Initialise this project with the Shannon framework

### Document Management

- `/document-create [type]` — Create a mandated document or knowledge note
- `/document-review [path]` — Review and approve a document

### Work Item Lifecycle

All four types retain create/elaborate/plan/implement/review commands. Only Feature elaborate/plan/review cross human gates. `/feature-implement` delivers directly; optional verbs do not require prior progress labels. Read the work-items skill and current governing context. Existing indexes must agree with bodies, but missing optional indexes are not defects.

### Idea Capture

- `/scratchpad-add [idea]` — Capture an idea in `docs/scratchpad.md` without classifying it
- `/scratchpad-process` — Give each scratchpad item a disposition: act, promote, move to knowledge, or drop

## Critical Guardrails

- Read relevant Vision, Feature, design/Guide context and actual implementation before changing it.
- Preserve traceability, prior decisions, outstanding obligations and honest status; keep enough evidence to resume.
- Run appropriate checks, maintain affected documents and obtain independent technical review from a reviewer who did not implement the work.
- Present delivered behaviour, checks, review verdict, remaining defects and limitations for human Feature acceptance. Never self-accept or infer acceptance from merge.
- Resolve routine execution details within approved authority. Stop affected work on consequential divergence; continue independent authorised work.
- Respect existing permissions for publication, deployment, external actions, credentials and spending.
- Do not silently overwrite another writer, bulk migrate historical records or automatically archive/delete them.

## Project-Specific Notes

[Add project-specific guidance here — anything Claude should know that isn't already captured in the mandated documents.]
