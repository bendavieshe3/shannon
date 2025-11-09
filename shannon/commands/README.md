# Claude Code Commands

This directory contains slash command definitions for the documentation system.

## Command Overview

### Project Setup
- **`/project-setup`** - Initialize or update project (idempotent - safe to run anytime)

### Documentation Management
- **`/document [type]`** - Create knowledge notes (research, implementation details, doc extensions)
- **`/document-review [doc]`** - Review and approve DRAFT mandated documents (Gate 1)

### Feature Lifecycle
- **`/feature-create`** - Create a new feature
- **`/feature-phase-plan FEAT-XXX [#]`** - Plan a feature phase (with AI reading docs)
- **`/feature-phase-start FEAT-XXX [#]`** - Start active work on a phase
- **`/feature-phase-complete FEAT-XXX [#]`** - Complete a phase (with alignment check)
- **`/feature-alignment FEAT-XXX`** - Check alignment between product requirements ↔ feature ↔ implementation
- **`/feature-review FEAT-XXX`** - Comprehensive feature health check

### Task Lifecycle
- **`/task-create`** - Create a new task
- **`/task-ready TASK-XXX`** - Plan task implementation (TODO → READY, Gate 2)
- **`/task-implement TASK-XXX`** - Implement task (READY → IN_PROGRESS → REVIEW)
- **`/task-review TASK-XXX`** - Review and approve completed task (REVIEW → COMPLETED, Gate 3)

## Installation

Copy this commands directory to `.claude/commands/` in your project:

```bash
cp -r ./shannon/commands/* .claude/commands/
```

## Workflow Example

### Starting a New Project

1. **Initialize project**:
   ```
   /project-setup
   ```
   Creates all mandated documents (DRAFT status) and CLAUDE.md

2. **Review core documents**:
   ```
   /document-review product_requirements.md
   /document-review technical_design.md
   ```
   Approve documents (DRAFT → APPROVED)

3. **Create first feature**:
   ```
   /feature-create
   ```
   Define "Secures User Data" feature

4. **Plan Phase 1**:
   ```
   /feature-phase-plan FEAT-001 1
   ```
   AI reads docs, creates tasks for email/password auth

5. **Start Phase 1**:
   ```
   /feature-phase-start FEAT-001 1
   ```
   Feature becomes ACTIVE

6. **Work on tasks**:
   ```
   /task-ready TASK-001
   /task-implement TASK-001
   /task-implement TASK-001 --complete
   /task-review TASK-001 --approve
   ```
   Complete task lifecycle

7. **Complete phase**:
   ```
   /feature-phase-complete FEAT-001 1
   ```
   Phase done, feature returns to STABLE

### Maintenance

- Run `/feature-alignment FEAT-XXX` every 2-4 weeks to catch drift
- Run `/feature-review FEAT-XXX` monthly for health check
- Use `/document` to capture implementation details as you build
- Run `/project-setup` after changing style guides (updates Quick Reference in CLAUDE.md)
- Run `/project-setup` when template guidance is updated

### Adding System to Existing Project

If you have an existing project and want to add the documentation system:

1. **Copy templates and commands**:
   ```bash
   mkdir -p .claude/commands
   cp -r /path/to/claude-conf/shannon/commands/* .claude/commands/
   ```

2. **Run setup**:
   ```
   /project-setup
   ```
   This intelligent command:
   - Detects what exists (docs, CLAUDE.md, etc.)
   - Creates missing mandated documents
   - Adds/updates documentation system guidance in CLAUDE.md
   - Preserves all existing content
   - Updates Quick Reference from style guides
   - Safe to run multiple times (idempotent)

## Three Quality Gates

The system has three human review gates:

**Gate 1: Document Approval**
- Command: `/document-review`
- When: After creating/updating mandated documents
- Purpose: Ensure documentation is accurate before AI uses it for context

**Gate 2: Task Planning Approval**
- Command: `/task-ready` (human reviews plan before proceeding)
- When: Before implementing a task
- Purpose: Ensure AI's implementation plan is sound

**Gate 3: Task Completion Approval**
- Command: `/task-review --approve`
- When: After task implementation
- Purpose: Ensure implementation meets acceptance criteria

## Command Naming

Commands use verb-noun pattern:
- `feature-create` not `create-feature`
- `task-ready` not `ready-task`
- `document-review` not `review-document`

## Design Philosophy

These commands are designed for **AI-assisted development** where:
- Human provides direction and approval
- AI handles documentation reading, planning, and implementation
- AI maintains cross-references and alignment
- System prevents AI mistakes through strategic review gates
- Knowledge accumulates in searchable notes

## See Also

- [documentation_how_to.md](../guides/documentation_how_to.md) - Documentation system overview
- [project_how_to.md](../guides/project_how_to.md) - Product requirements layer
- [features_how_to.md](../guides/features_how_to.md) - Feature layer
- [tasks_how_to.md](../guides/tasks_how_to.md) - Task layer
