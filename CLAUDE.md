# CLAUDE.md

This file provides guidance to Claude Code when working with this repository.

## What This Repository Is

This is **Shannon** — a documentation and workflow framework for AI-assisted development with Claude Code. It provides:

1. **Mandated document templates** for project documentation (six core documents)
2. **Unified work item system** (Features, Epics, Tasks, Spikes) with a shared lifecycle and three quality gates
3. **Knowledge base structure** for research, implementation details, and document extensions
4. **Slash commands** built on a Commands + Skills + Subagents architecture

This is **not** a traditional software project. It is a meta-framework for organising how AI (Claude Code) and humans collaborate on software projects. The framework runs entirely on plain Markdown files — no build step, no runtime, no network calls.

## Repository Structure

```
shannon/                                  # Shannon deployables (source)
├── commands/                             # Thin command files (delegate to skills)
│   ├── README.md
│   ├── shannon-setup.md
│   ├── document-create.md / document-review.md
│   ├── feature-{create,elaborate,plan,implement,review}.md
│   ├── epic-{create,elaborate,plan,implement,review}.md
│   ├── task-{create,elaborate,plan,implement,review}.md
│   └── spike-{create,elaborate,plan,implement,review}.md
│
├── skills/                               # Framework logic + templates
│   ├── project-setup/
│   │   ├── skill.md
│   │   └── templates/CLAUDE.md
│   ├── project-documentation/
│   │   ├── skill.md
│   │   └── templates/
│   │       ├── vision.md
│   │       ├── technology_stack.md
│   │       ├── conceptual_design.md
│   │       ├── technical_design.md
│   │       ├── development_guide.md
│   │       ├── ux_guide.md
│   │       ├── knowledge_note.md
│   │       └── knowledge_index.md
│   └── work-items/
│       ├── skill.md
│       └── templates/
│           ├── feature.md  / feature_index.md
│           ├── epic.md     / epic_index.md
│           ├── task.md     / task_index.md
│           └── spike.md    / spike_index.md
│
└── guides/                               # User-facing documentation
    └── shannon_overview.md

docs/                                     # Shannon's own documentation (dogfooding)
├── vision.md
├── technology_stack.md
├── conceptual_design.md
├── technical_design.md
├── development_guide.md
├── ux_guide.md
├── features/
├── epics/
├── tasks/
└── knowledge/

spikes/                                   # Disposable exploratory work (project root)
```

## Core Concepts

### Four-Layer Architecture

```
Documentation Layer (six mandated documents + knowledge base)
    ↓ informs
Vision Layer (supreme authority)
    ↓ elaborates into
Work Item Layer (Features → Epics → Tasks; plus Spikes)
    ↓ produces
Implementation
```

### Work Items

Four types, one unified lifecycle:

```
DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED
     │           │          │                                       │
   Gate 1     Gate 2    (iterative zone)                         Gate 3
```

| Type | Persistence |
|---|---|
| **Feature** | Persistent — what the product IS; accumulates epics over time |
| **Epic** | Coherent unit of work under a feature; remains as historical record |
| **Task** | Atomic implementation work; archived once APPROVED |
| **Spike** | Time-boxed investigation; disposable, knowledge note is durable output |

### Three Quality Gates

Explicit human approval points:

1. **Gate 1** (DRAFT → ELABORATED): Requirements complete and aligned
2. **Gate 2** (ELABORATED → PLANNED): Implementation plan sound
3. **Gate 3** (REVIEW → APPROVED): Implementation meets requirements

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

Lower documents must enable higher ones. Drift is a defect.

### Implementation Layers

- **Commands** — thin entry points; delegate to skills
- **Skills** — reusable framework logic with templates
- **Subagents** — spawned by skills for context-heavy reading; keep main conversation lean

## How to Use This Repository

### Understanding the System

Read in this order:

1. `shannon/guides/shannon_overview.md` — Complete walkthrough
2. `shannon/skills/*/skill.md` — Canonical behaviour of each skill
3. `shannon/commands/README.md` — Command reference

### Deploying into a New Project

```bash
mkdir -p /path/to/new-project/.claude
cp -r shannon/commands /path/to/new-project/.claude/commands
cp -r shannon/skills   /path/to/new-project/.claude/skills
cp -r shannon/guides   /path/to/new-project/.claude/guides
```

Then in the new project:

```
/shannon-setup
```

This instantiates mandated documents and walks through initial vision content.

### Workflow in a New Project

```
/document-review vision.md             # Approve the vision (Gate 1)
/feature-create [hint]                 # Capture a feature
/feature-elaborate FEAT-001            # Drafts requirements (Gate 1)
/feature-plan FEAT-001                 # Identifies epics (Gate 2)
/epic-elaborate EPIC-001               # ...and so on down the chain
/task-elaborate / -plan / -implement / -review
```

## Improving This Repository

When working on Shannon itself:

1. **Command changes** — `shannon/commands/` (keep them thin)
2. **Skill changes** — `shannon/skills/<name>/skill.md` (where workflow logic lives)
3. **Template changes** — `shannon/skills/<name>/templates/`
4. **Guide changes** — `shannon/guides/`
5. **Shannon's own docs** — `docs/` (dogfooding)

Shannon eats its own dog food: changes to templates should be reflected in `docs/` to validate that the templates produce coherent project documentation.

## What NOT to Do

❌ Don't add code (this is a Markdown-only project)
❌ Don't introduce build steps or runtime dependencies
❌ Don't commit without testing changes against a real project workflow
❌ Don't add features that increase maintenance burden without commensurate value
❌ Don't skip the unified status model — every work item uses the same lifecycle

## Key Design Principles

1. **Plain text** — All files readable without special tools
2. **AI does the bookkeeping** — Cross-references, status transitions, alignment checks
3. **Humans direct, AI executes** — Gates exist where human judgement compounds; AI handles the rest
4. **Knowledge accumulates** — Implementation details and learnings captured, not lost
5. **Flat file structure** — No databases, no complex tooling
6. **Single source of truth** — Templates ship inside skills; skills ship inside `.claude/`; no duplication

## Getting Help

- **System overview**: `shannon/guides/shannon_overview.md`
- **Skill definitions**: `shannon/skills/*/skill.md`
- **Command reference**: `shannon/commands/README.md`
- **Shannon's own dogfood docs**: `docs/`

---

**Remember**: Shannon works because AI reads documentation for context, follows the unified workflow for consistency, and captures knowledge for the future. The framework's value comes from the discipline of using it — not bypassing it.
