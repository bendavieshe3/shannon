# CLAUDE.md

This file provides guidance to Claude Code when working in this project.

## Project Overview

**Project Name**: [Your Project Name]

[Brief 1-2 sentence description of what this project does]

**Example**:
> IdeaFlow helps users capture and organize ideas effortlessly with a focus on serendipitous rediscovery.

---

## Quick Reference

**Critical rules extracted from style guides. Always check full guides before implementing.**

### Code Style → ./docs/code_style_guide.md
<!-- QUICK_REF_START: code_style_guide -->
- **Language**: [Primary language and version, e.g., "Python 3.11+, PEP 8 (100 char lines)"]
- **Naming**: [Convention, e.g., "snake_case (functions/vars), PascalCase (classes)"]
- **Types**: [Type hint policy, e.g., "Type hints required for all public functions"]
- **Tests**: [Testing requirements, e.g., "Required, 80%+ coverage, pytest"]
- **Before commit**: [Commands, e.g., "ruff format . && ruff check . && mypy src/"]
<!-- QUICK_REF_END: code_style_guide -->

### UX Style → ./docs/ux_style_guide.md
<!-- QUICK_REF_START: ux_style_guide -->
- **Colors**: [Primary colors, e.g., "Primary #3B82F6, Success #10B981, Error #EF4444"]
- **Typography**: [Font and sizing, e.g., "Inter font, 16px body (1.5 line height)"]
- **Spacing**: [Base unit, e.g., "8px base unit (multiples: 8, 16, 24, 32)"]
- **Components**: [Component library, e.g., "Material Design, see guide for specs"]
- **Accessibility**: [Requirements, e.g., "4.5:1 contrast, keyboard nav required"]
<!-- QUICK_REF_END: ux_style_guide -->

### Documentation Style → ./docs/documentation_style_guide.md
<!-- QUICK_REF_START: documentation_style_guide -->
- **Voice**: [Writing voice, e.g., "Second person (you), active voice, friendly professional"]
- **Sentences**: [Structure, e.g., "15-20 words, one idea per sentence"]
- **Code blocks**: [Formatting, e.g., "Always specify language, include context"]
- **Examples**: [Approach, e.g., "Show don't tell, use realistic values"]
<!-- QUICK_REF_END: documentation_style_guide -->

**Note**: These are summaries. `/project-setup` auto-updates this section from style guides.

---

## Documentation System

This project uses a **structured documentation system** designed for AI-assisted development. All documentation lives in `./docs/`.

### Core Principle

**Always read the relevant documentation BEFORE planning or implementing**. The documentation provides essential context that prevents:
- Re-asking questions that are already answered
- Making decisions inconsistent with existing architecture
- Implementing features that contradict product requirements
- Writing code that doesn't follow established patterns

### Documentation Structure

```
./docs/
├── product_requirements.md       # Product vision, personas, user stories
├── technology_stack.md           # Tech choices and rationale
├── conceptual_design.md          # Domain model, business logic
├── technical_design.md           # Architecture, implementation approach
├── code_style_guide.md           # Code formatting, naming, testing
├── ux_style_guide.md            # UI components, colors, typography
├── documentation_style_guide.md # User-facing docs standards
├── development_design.md        # Git workflow, CI/CD, deployment
├── features/                     # Feature tracking
│   ├── feature_index.md
│   └── FEAT-XXX-*.md
├── tasks/                        # Task tracking
│   ├── task_index.md
│   ├── archive/
│   └── TASK-XXX-*.md
└── knowledge/                    # Detailed implementation notes
    ├── knowledge_index.md
    ├── research/
    ├── implementation-details/
    └── *-extra/
```

### Slash Commands Available

**Project Setup** (once per project):
- `/project-setup` - Initialize documentation structure

**Documentation**:
- `/document [type]` - Create knowledge notes
- `/document-review [doc]` - Review and approve DRAFT documents

**Features**:
- `/feature-create` - Create new feature
- `/feature-phase-plan FEAT-XXX [#]` - Plan a phase
- `/feature-phase-start FEAT-XXX [#]` - Start active work
- `/feature-phase-complete FEAT-XXX [#]` - Complete phase
- `/feature-alignment FEAT-XXX` - Check for drift
- `/feature-review FEAT-XXX` - Health check

**Tasks**:
- `/task-create` - Create new task
- `/task-ready TASK-XXX` - Plan implementation (reads docs!)
- `/task-implement TASK-XXX` - Implement task
- `/task-review TASK-XXX` - Review completion

See `./.claude/commands/README.md` for complete command documentation.

---

## Critical Guardrails

### ALWAYS Do

✅ **Read documentation before planning**:
- Run `/task-ready TASK-XXX` BEFORE implementing (reads docs, creates plan)
- Run `/feature-phase-plan` BEFORE starting phases (reads docs, creates tasks)
- Check conceptual_design.md for domain concepts
- Check technical_design.md for architecture
- Check style guides before writing code

✅ **Follow the workflow**:
- Tasks: TODO → `/task-ready` → `/task-implement` → `/task-review` → COMPLETED
- Features: Create → Plan Phase → Start Phase → Complete Phase
- Documents: Create DRAFT → `/document-review` → APPROVED

✅ **Maintain cross-references**:
- Update indexes when creating tasks/features
- Link tasks to features (if applicable)
- Reference knowledge notes in docs
- Update feature roadmaps when completing tasks

✅ **Capture knowledge**:
- Create knowledge notes for complex implementations
- Document decisions and gotchas
- Update technical_design.md if implementation differs (mark DRAFT)
- Add implementation details that don't fit in mandated docs

### NEVER Do

❌ **Skip documentation reading**:
- Don't implement tasks without running `/task-ready` first
- Don't guess at architecture - read technical_design.md
- Don't assume patterns - check code_style_guide.md
- Don't ignore existing knowledge notes

❌ **Bypass quality gates**:
- Don't use unapproved DRAFT documents as authoritative (Gate 1)
- Don't implement without a plan (Gate 2: `/task-ready`)
- Don't mark tasks complete without review (Gate 3: `/task-review`)

❌ **Make isolated changes**:
- Don't update task state without updating task_index.md
- Don't create features without updating feature_index.md
- Don't create knowledge notes without updating knowledge_index.md
- Don't change implementation without updating technical_design.md

❌ **Lose context**:
- Don't implement features without checking product_requirements.md
- Don't write code without checking style guides
- Don't duplicate research - check knowledge/research/ first
- Don't forget to document learnings in knowledge notes

---

## Three Quality Gates

This system has three human review points:

### Gate 1: Document Approval
**Command**: `/document-review [doc]`
**When**: After creating/updating mandated documents
**Purpose**: Ensure documentation is accurate before AI uses it for context
**Status**: DRAFT → APPROVED

### Gate 2: Task Planning
**Command**: `/task-ready TASK-XXX`
**When**: Before implementing a task
**Purpose**: Ensure AI's implementation plan is sound
**What happens**: AI reads relevant docs, creates plan, human reviews
**Status**: TODO → READY → (human approval) → IN_PROGRESS

### Gate 3: Task Completion
**Command**: `/task-review TASK-XXX [--approve]`
**When**: After task implementation
**Purpose**: Ensure implementation meets acceptance criteria
**Status**: REVIEW → (human approval) → COMPLETED → archive

---

## Workflow Examples

### Working on a Task

```bash
# 1. AI creates task (or human requests it)
/task-create

# 2. AI plans task (READS DOCS!)
/task-ready TASK-XXX
# AI reads: conceptual_design.md, technical_design.md,
#          code_style_guide.md, related knowledge notes
# AI creates: implementation plan with phases and key decisions
# Human: Reviews plan, approves or requests changes

# 3. AI implements
/task-implement TASK-XXX
# AI follows: code_style_guide.md, ux_style_guide.md
# AI tracks: implementation notes, gotchas, doc updates

# 4. AI marks complete
/task-implement TASK-XXX --complete
# Task moves to REVIEW state

# 5. Human reviews and approves
/task-review TASK-XXX --approve
# Task moves to COMPLETED, archived
```

### Working on a Feature

```bash
# 1. Create feature
/feature-create
# Define: product vision, ideal state, user stories

# 2. Plan Phase 1 (AI READS DOCS!)
/feature-phase-plan FEAT-XXX 1
# AI reads: product_requirements.md, technical_design.md,
#          conceptual_design.md
# AI creates: phase plan with tasks
# Human: Reviews plan

# 3. Start phase
/feature-phase-start FEAT-XXX 1
# Feature becomes ACTIVE

# 4. Work through tasks (see task workflow above)

# 5. Complete phase
/feature-phase-complete FEAT-XXX 1
# All tasks done, alignment check, phase marked complete
```

---

## Common Mistakes to Avoid

### ❌ "I'll just implement this task quickly without planning"
**Problem**: Skips Gate 2, misses important context from docs
**Fix**: Always run `/task-ready` first - it reads docs and creates a plan

### ❌ "I'll update the code but the docs can wait"
**Problem**: Creates drift between docs and implementation
**Fix**: Update technical_design.md as you go (mark DRAFT if changed)

### ❌ "I don't need to check the style guide, I'll just follow common conventions"
**Problem**: Creates inconsistent code
**Fix**: Read code_style_guide.md before writing code

### ❌ "I'll create the task file but skip updating task_index.md"
**Problem**: Task becomes invisible in navigation
**Fix**: Commands handle this automatically - use them!

### ❌ "This implementation detail isn't worth documenting"
**Problem**: Next time, AI (or you) will re-discover it the hard way
**Fix**: Create knowledge note in ./docs/knowledge/implementation-details/

---

## Project-Specific Notes

[Add project-specific guidance here]

**Example**:
> - Our API uses REST, not GraphQL (see technical_design.md § "API Design")
> - All database migrations must be reversible (see development_design.md)
> - UI components follow Material Design (see ux_style_guide.md)
> - Error messages must be user-friendly (see documentation_style_guide.md)

---

## Getting Help

- **System overview**: Read `./.claude/guides/shannon_overview.md` (if installed)
- **Command reference**: Read `./.claude/commands/README.md`
- **Layer guides**: Read `./.claude/guides/*_how_to.md` files
- **Mandated docs**: Read `./docs/*.md` (8 core documents)

---

**Remember**: This system works because AI reads documentation for context, follows workflows for consistency, and captures knowledge for the future. Don't bypass it - use it!
