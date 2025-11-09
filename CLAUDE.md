# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## What This Repository Is

This is a **documentation system for AI-assisted development**. It provides:

1. **Complete template set** for project documentation (8 mandated documents)
2. **Feature and task tracking system** optimized for AI context management
3. **Knowledge base structure** for capturing implementation details
4. **Slash commands** that guide AI through the development workflow

This is NOT a traditional software project - it's a meta-system for organizing how AI (Claude Code) and humans collaborate on software projects.

## Repository Structure

```
shannon/                           # Shannon deployables (source)
├── templates/                     # Document templates for projects
│   ├── product_requirements.md   # Product vision, personas, user stories
│   ├── technology_stack.md       # Tech choices with rationale
│   ├── conceptual_design.md      # Domain model, business logic
│   ├── technical_design.md       # Architecture, implementation approach
│   ├── code_style_guide.md       # Code formatting, naming, testing
│   ├── ux_style_guide.md         # UI components, colors, typography
│   ├── documentation_style_guide.md  # User-facing docs standards
│   ├── development_design.md     # Git workflow, CI/CD, deployment
│   ├── FEAT-XXX.md              # Feature template
│   ├── TASK-XXX.md              # Task template
│   ├── knowledge_note.md         # Knowledge base note template
│   ├── feature_index.md          # Feature navigation
│   ├── task_index.md             # Task navigation
│   ├── knowledge_index.md        # Knowledge base navigation
│   └── CLAUDE.md                 # AI guidance template
│
├── commands/                      # Slash command definitions
│   ├── README.md                 # Command overview
│   ├── project-setup.md          # Initialize new project
│   ├── task-*.md                 # Task lifecycle commands
│   ├── feature-*.md              # Feature lifecycle commands
│   └── document*.md              # Documentation commands
│
└── guides/                        # How-to guides
    ├── shannon_overview.md       # Complete system walkthrough
    ├── documentation_how_to.md   # Mandated docs explained
    ├── project_how_to.md         # Product requirements layer
    ├── features_how_to.md        # Feature layer
    ├── tasks_how_to.md           # Task layer
    └── knowledge_how_to.md       # Knowledge base

docs/                              # Shannon's own documentation
├── product_requirements.md       # Shannon's product requirements
├── features/                     # Shannon's features
├── tasks/                        # Shannon's tasks
└── knowledge/                    # Shannon's knowledge base
```

## The Documentation System

This system implements a **four-layer architecture**:

```
Documentation Layer (8 mandated documents + knowledge base)
    ↓ informs
Requirements Layer (product_requirements.md)
    ↓ breaks into
Feature Layer (persistent product characteristics, phases)
    ↓ breaks into
Task Layer (specific work items with lifecycle)
    ↓ produces
Implementation (code)
```

### Core Philosophy

This system solves **AI context management problems**:

- **Context amnesia**: AI forgets past decisions → Documented in mandated docs
- **Inconsistent decisions**: AI makes different choices → Style guides enforce consistency
- **Repetitive questions**: AI re-asks same things → Knowledge base provides answers
- **Architectural drift**: Implementation diverges from design → Alignment checks detect drift

### Three Quality Gates

Human review happens at three strategic points:

1. **Gate 1: Document Approval** (`/document-review`)
   - Review mandated documents before AI uses them for context
   - DRAFT → APPROVED status

2. **Gate 2: Task Planning** (`/task-ready`)
   - Review AI's implementation plan before coding
   - TODO → READY → IN_PROGRESS

3. **Gate 3: Task Completion** (`/task-review`)
   - Review completed implementation
   - REVIEW → COMPLETED → archive

## How to Use This Repository

### For Understanding the System

Read in this order:
1. `shannon/guides/shannon_overview.md` - Complete walkthrough with examples
2. `shannon/guides/documentation_how_to.md` - Mandated documents explained
3. `shannon/guides/project_how_to.md` - Product requirements layer
4. `shannon/guides/features_how_to.md` - Feature layer
5. `shannon/guides/tasks_how_to.md` - Task layer

### For Using Templates in a New Project

1. Copy Shannon to new project:
   ```bash
   mkdir -p /path/to/new-project/.claude
   cp -r shannon/templates /path/to/new-project/.claude/templates
   cp -r shannon/commands /path/to/new-project/.claude/commands
   cp -r shannon/guides /path/to/new-project/.claude/guides
   ```

2. In new project, run:
   ```
   /project-setup
   ```
   This instantiates all templates with project-specific information.

3. Follow the workflow:
   - Review/approve documents: `/document-review product_requirements.md`
   - Create features: `/feature-create`
   - Plan phases: `/feature-phase-plan FEAT-001 1`
   - Work on tasks: `/task-ready`, `/task-implement`, `/task-review`

### For Improving This System

When working on this repository:

1. **Template changes**: Update files in `shannon/templates/`
2. **Command changes**: Update files in `shannon/commands/`
3. **Guide changes**: Update how-to guides in `shannon/guides/`
4. **Shannon's own docs**: Update files in `docs/` (Shannon eats its own dog food!)

## Important Concepts

### Features vs Tasks

- **Features** are persistent (what the product IS)
  - Example: "Secures User Data" (capability)
  - Cycle between STABLE ↔ ACTIVE
  - Have phases that accumulate over time
  - Never "complete" - they evolve

- **Tasks** are transient (specific work items)
  - Example: "Add Google OAuth provider" (work item)
  - Flow: TODO → READY → IN_PROGRESS → REVIEW → COMPLETED
  - Get archived when done
  - Can be orphans (not linked to features)

### Knowledge Base

Three types of notes:

- **Research**: General comparisons (OAuth vs JWT)
- **Implementation Details**: How we actually built it (oauth-implementation.md)
- **Extensions**: Elaborations of mandated docs (api-design-patterns.md)

AI reads these during `/task-ready` and `/feature-phase-plan` to inform planning.

### DRAFT vs APPROVED

Mandated documents have status:
- **DRAFT**: Work in progress, not reviewed
- **APPROVED**: Human-reviewed and ready to use

AI can read DRAFT docs but knows they're not final. Gate 1 is approving docs.

## Working with This Repository

### When Adding Features to the System

1. Update relevant how-to guide in `docs/`
2. Update templates if structure changes
3. Update command definitions if workflow changes
4. Test with a real project before committing

### When Reviewing Documentation

- This is meta-documentation about the system itself
- Examples should be clear and realistic
- Templates should be complete and self-documenting
- Commands should be actionable step-by-step instructions

### What NOT to Do

- ❌ Don't run build/test commands (this isn't a code project)
- ❌ Don't modify project-a or project-b (they're frozen examples)
- ❌ Don't commit without testing templates in a real project
- ❌ Don't add features that increase maintenance burden

## Key Design Principles

1. **Lightweight indexes**: No tables, no statistics, minimal maintenance
2. **AI does the bookkeeping**: Cross-references, updates, alignment checks
3. **Human provides direction**: Reviews at strategic gates only
4. **Knowledge accumulates**: Implementation details captured, not lost
5. **Plain text readable**: All files readable without special tools
6. **Flat file structure**: No databases, no complex tooling

## Getting Help

- **System overview**: Read `shannon/guides/shannon_overview.md`
- **Command reference**: Read `shannon/commands/README.md`
- **Layer details**: Read individual how-to guides in `shannon/guides/`

## This Repository Is For

- ✅ Creating new projects with the documentation system
- ✅ Understanding the AI context management approach
- ✅ Copying templates and commands to other projects
- ✅ Learning the Shannon workflow

## This Repository Is NOT For

- ❌ Running as an application (it's a template repository)
- ❌ Building or testing code (no code to build)
- ❌ Tracking actual work (use the templates in a real project)

---

**Remember**: This system is designed for AI-human collaboration where AI handles documentation reading, cross-referencing, and bookkeeping, while humans provide direction and strategic review at three quality gates.
