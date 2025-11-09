# Conceptual Design

**Status**: DRAFT
**Last Reviewed**: 2025-01-09
**Approved By**: Not yet reviewed

---

**Project Name**: Shannon

## Overview

Shannon is a **documentation framework**, not traditional software. The "domain model" consists of documentation concepts and their relationships.

---

## Core Concepts

### Document
A piece of written guidance (markdown file) that provides context to AI or humans.

**Types**:
- **Mandated Documents**: 8 core documents that define the project (product_requirements.md, technology_stack.md, etc.)
- **Working Templates**: Reusable templates deployed to home directories (TASK-XXX.md, FEAT-XXX.md, knowledge_note.md)
- **Knowledge Notes**: Detailed implementation notes or research

**States**:
- **DRAFT**: Not yet reviewed by human
- **APPROVED**: Human-reviewed and authoritative

**Properties**:
- file_path: Location in filesystem
- status: DRAFT | APPROVED
- last_reviewed: Date
- content: Markdown text

### Feature
A persistent product characteristic (what the product IS, not a project task).

**Properties**:
- id: FEAT-XXX
- name: Aspirational name (e.g., "Secures User Data")
- state: STABLE | ACTIVE
- type: Core Capability | Enhancement | Infrastructure
- product_requirements_reference: Which section this implements

**Lifecycle**:
- Created ’ STABLE (no active work)
- STABLE ” ACTIVE (phases being worked on)
- Never "completed" - features evolve with phases

### Task
A discrete work item with clear completion criteria.

**Properties**:
- id: TASK-XXX
- description: What needs to be done
- state: TODO | READY | IN_PROGRESS | REVIEW | COMPLETED
- priority: P0 | P1 | P2 | P3
- acceptance_criteria: Checklist of requirements

**Lifecycle**:
- TODO ’ READY (via `/task-ready` - AI creates plan)
- READY ’ IN_PROGRESS (via `/task-implement`)
- IN_PROGRESS ’ REVIEW (mark complete)
- REVIEW ’ COMPLETED (via `/task-review --approve`)
- COMPLETED ’ Archived

### Phase
A unit of work within a feature, consisting of multiple tasks.

**Properties**:
- feature_id: Parent feature
- phase_number: Sequential number (1, 2, 3...)
- description: What this phase achieves
- state: PLANNED | IN_PROGRESS | COMPLETED
- tasks: List of TASK-XXX ids

**Behavior**:
- Phases are planned (via `/feature-phase-plan`)
- Phases activate the parent feature (STABLE ’ ACTIVE)
- Phases complete when all tasks are COMPLETED

### Index
A navigation file that lists related items.

**Types**:
- task_index.md: Lists all tasks with state and tags
- feature_index.md: Lists all features with state and tags
- knowledge_index.md: Lists all knowledge notes

**Properties**:
- Simple flat list (no tables, no statistics)
- Inline state and tags for quick scanning
- Lightweight maintenance

---

## Relationships

```
Product Requirements § Section
    “ implements
Feature (FEAT-XXX)
    “ breaks into
Phase (Phase 1, 2, 3...)
    “ consists of
Tasks (TASK-XXX, TASK-YYY, ...)
    “ produces
Implementation (code, docs, etc.)
    “ generates
Knowledge Notes (learnings, gotchas)
```

**Cross-references**:
- Features reference product_requirements.md sections
- Tasks can reference features (optional)
- Knowledge notes can reference any document
- Documents can reference knowledge notes

---

## Business Rules

### Document Status Rules
1. New documents start as DRAFT
2. Only humans can approve documents (DRAFT ’ APPROVED)
3. Changes to APPROVED docs reset them to DRAFT
4. AI should prefer APPROVED docs over DRAFT for authoritative guidance

### Feature State Rules
1. Features start in STABLE state
2. Starting a phase transitions feature to ACTIVE
3. Completing a phase returns feature to STABLE
4. Features never reach "COMPLETED" - they persist

### Task Lifecycle Rules
1. Tasks cannot skip states (must go TODO ’ READY ’ IN_PROGRESS ’ REVIEW ’ COMPLETED)
2. `/task-ready` must be run before implementing (enforces Gate 2)
3. Tasks in REVIEW require human approval to complete (enforces Gate 3)
4. COMPLETED tasks are archived (moved to ./docs/tasks/archive/)

### Index Maintenance Rules
1. Creating a task/feature must update corresponding index
2. Changing task/feature state must update index
3. Indexes are flat lists (no complex structures)
4. AI handles index updates (human doesn't manually edit)

---

## Critical Business Logic

### Three Quality Gates

**Gate 1: Document Approval**
- **When**: After creating/updating mandated documents
- **Who**: Human
- **Command**: `/document-review [doc]`
- **Purpose**: Ensure docs are accurate before AI uses them
- **Transition**: DRAFT ’ APPROVED

**Gate 2: Task Planning**
- **When**: Before implementing a task
- **Who**: AI creates plan, human reviews
- **Command**: `/task-ready TASK-XXX`
- **Purpose**: Ensure AI read docs and has sound plan
- **Transition**: TODO ’ READY
- **Reads**: conceptual_design.md, technical_design.md, code_style_guide.md, knowledge notes

**Gate 3: Task Completion**
- **When**: After task implementation
- **Who**: Human
- **Command**: `/task-review TASK-XXX --approve`
- **Purpose**: Ensure acceptance criteria met
- **Transition**: REVIEW ’ COMPLETED ’ archive

### AI Context Reading Rules

When AI executes `/task-ready`:
1. Read ./docs/conceptual_design.md for domain concepts
2. Read ./docs/technical_design.md for architecture
3. Read ./docs/code_style_guide.md for code patterns
4. Read related knowledge notes (if referenced)
5. Create implementation plan
6. Present plan to human for approval

When AI executes `/feature-phase-plan`:
1. Read ./docs/product_requirements.md for user needs
2. Read ./docs/technical_design.md for architecture
3. Read ./docs/conceptual_design.md for domain model
4. Break phase into 5-15 tasks
5. Create research notes if technical unknowns exist

---

## Version History

### 2025-01-09 - v1.0
- Initial conceptual design
- Defined core concepts: Document, Feature, Task, Phase, Index
- Documented relationships and business rules
- Status: DRAFT (pending review)
