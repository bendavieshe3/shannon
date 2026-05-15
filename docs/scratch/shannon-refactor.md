# Shannon

Shannon is a development framework for Claude Code enabling low effort and high quality development project outputs. Easy project installation, automatically maintained documentation, and fully traceable aligned implementation make projects built with Shannon rapidly progress while maintaining coherence, code quality, and alignment to requirements.

Built with solo-developers and knowledge workers in mind, Shannon's command-based implementation allows a state of development flow while shouldering the burdens of documentation, context management, and implementation.

## Overview

Conceptually Shannon consists of *Work Items* - Features, Epics, Tasks and Spikes - and *Project Documentation*. All work items are ultimately elaborations of a single vision document. Other Project Documentation and a knowledge base for ad hoc knowledge capture describes the project across different scopes of conceptual and technical design.

When users interact with the work items and documentation using the Shannon process:

- Work asked of Claude is well defined
- Operates in an optimal context
- Planning and implementation are clearly separated
- Clear quality gates ensure the effectiveness of AI operations and alignment
- Documentation is maintained and used as a guardrail

Shannon implements this using markdown templates, custom commands, some project structure conventions and CLAUDE.md inclusions

## Project Structure

### Shannon Development Structure

The Shannon project itself (this repository):

```text
/shannon/                        # Shannon source (deployed to other projects)
├── skills/                      # Skill definitions with templates
│   ├── project-setup/
│   │   ├── skill.md
│   │   └── templates/
│   │       └── CLAUDE.md
│   ├── project-documentation/
│   │   ├── skill.md
│   │   └── templates/
│   │       ├── vision.md
│   │       ├── technology_stack.md
│   │       ├── conceptual_design.md
│   │       ├── technical_design.md
│   │       ├── development_guide.md
│   │       └── ux_guide.md
│   └── work-items/
│       ├── skill.md
│       └── templates/
│           ├── feature.md
│           ├── epic.md
│           ├── task.md
│           ├── spike.md
│           └── *_index.md
├── commands/                    # Command definitions
│   ├── shannon-setup.md
│   ├── task-*.md
│   ├── epic-*.md
│   ├── feature-*.md
│   ├── spike-*.md
│   └── document-*.md
└── guides/                      # User documentation
    ├── shannon_overview.md
    └── *.md

/docs/                           # Shannon's own documentation (dogfooding)
├── vision.md
├── features/
├── epics/
├── tasks/
└── knowledge/
```

### Deployed Structure

When Shannon is deployed into a project:

```text
/.claude/
├── CLAUDE.md                    # Project AI guidance (from template)
├── commands/                    # User-invoked commands
│   ├── shannon-setup.md
│   ├── task-create.md
│   ├── task-elaborate.md
│   ├── task-plan.md
│   ├── task-implement.md
│   ├── task-review.md
│   ├── epic-*.md
│   ├── feature-*.md
│   ├── spike-*.md
│   ├── document-create.md
│   └── document-review.md
└── skills/
    ├── project-setup/
    │   ├── skill.md
    │   └── templates/
    ├── project-documentation/
    │   ├── skill.md
    │   └── templates/
    └── work-items/
        ├── skill.md
        └── templates/

/docs/                           # Project documentation
├── vision.md
├── technology_stack.md
├── conceptual_design.md
├── technical_design.md
├── development_guide.md
├── ux_guide.md
├── features/
│   ├── feature_index.md
│   └── FEAT-XXX-slug.md
├── epics/
│   ├── epic_index.md
│   └── EPIC-XXX-slug.md
├── tasks/
│   ├── task_index.md
│   ├── TASK-XXX-slug.md
│   └── archive/
└── knowledge/
    ├── knowledge_index.md
    └── *.md

/spikes/                         # Separate from docs (disposable)
├── spike_index.md
└── SPIKE-XXX-slug.md
```

## Project Documents

Projects documents as described here are mandated. They are stored in the ./docs folder

### Product Vision

Where: ./docs/vision.md

#### Purpose

- Articulate the "why" — Defines the problem being solved and why it matters
- Align stakeholders — Creates shared understanding of what success looks like
- Guide decisions — Provides a north star for feature prioritisation and design trade-offs
- Communicate value — Explains the product to potential users, investors, or collaborators

#### Scope

- Problem Statement — What pain exists today
- Vision Statement — The aspirational future state
- Core Principles — The philosophical guardrails that shape the product
- Key Features — What the product does (high-level, not implementation details)
- Target Users — Who it's for (and implicitly, who it's not for)
- Success Metrics — How you'll know if it's working
- Future Vision — Where it could go (establishes ambition without over-committing)

What it's NOT:

- Not a requirements document (no detailed specs)
- Not a technical architecture (no implementation decisions)
- Not a roadmap (no timelines or sequencing)
- Not a business plan (no pricing, go-to-market, or financials)

### Technology Stack

Where: ./doc/technology.md

#### Purpose

Record decisions — Documents what technologies were chosen and why
Onboard contributors — Helps new developers understand the stack quickly
Guide implementation — Provides a reference for consistent technical choices
Enable planning — Shows dependencies and infrastructure needs upfront

#### Scope

- Architecture overview — High-level system structure and data flow
- Core technologies — Framework, language, runtime choices with versions
- Data layer — Database, ORM, and persistence strategy
- External integrations — APIs, third-party services
- Development tooling — Package manager, linting, testing, formatting
- Infrastructure — Hosting, CI/CD, source control
- Dependencies — Key packages for production and development
- Security considerations — Data handling, secrets management
- Performance targets — Measurable benchmarks
- Future considerations — Known directions without commitment

What it's NOT:

- Not implementation details (no code snippets or configs)
- Not a setup guide (no step-by-step instructions)
- Not API documentation (no endpoints or schemas)
- Not a changelog (tracks current state, not history)

### Conceptual Design

Where: ./docs/conceptual_design.md

#### Purpose

- Model the domain — Defines the core concepts, entities, and their relationships
- Establish shared language — Creates a ubiquitous language for the project
- Guide feature design — Provides the mental model that features elaborate
- Bridge vision to implementation — Translates product vision into structural concepts

#### Scope

- Domain Model — Core entities, their attributes, and relationships
- Business Rules — Invariants and constraints that govern the domain
- Key Workflows — How entities interact to accomplish user goals
- Bounded Contexts — Logical boundaries between different parts of the system
- Glossary — Definitions of domain terms

What it's NOT:

- Not implementation details (no classes, tables, or code)
- Not UI design (no screens or interactions)
- Not API specification (no endpoints or payloads)
- Not data modelling (no schemas or ERDs)

### Technical Design

Where: ./docs/technical_design.md

#### Purpose

- Bridge concept to code — Translates conceptual design into implementation approach
- Document architecture — Records structural decisions and patterns
- Guide implementation — Provides reference for consistent technical decisions
- Enable review — Makes architectural choices explicit and reviewable

#### Scope

- System Architecture — Components, layers, and their interactions
- Data Model — Database schema, storage patterns
- API Design — Endpoints, contracts, integration patterns
- Key Algorithms — Non-trivial logic requiring documentation
- Security Model — Authentication, authorisation, data protection approach
- Error Handling — Strategy for failures, logging, recovery
- Performance Approach — Caching, optimisation strategies

What it's NOT:

- Not code (no implementations, just approach)
- Not deployment configuration (that's Development Guide)
- Not user-facing behaviour (that's Conceptual Design)

### Development Guide

Where: ./docs/development_guide.md

#### Purpose

- Standardise development — Ensures consistent code style and practices
- Enable contribution — Provides everything needed to work on the codebase
- Document workflow — Records how code moves from idea to production
- Capture conventions — Makes implicit team knowledge explicit

#### Scope

- Code Style — Formatting, naming conventions, file organisation
- Testing Strategy — What to test, how to test, coverage expectations
- Git Workflow — Branching strategy, commit conventions, PR process
- Build & Run — Commands for development, testing, building
- CI/CD — Pipeline stages, deployment process
- Environment Setup — Prerequisites, configuration, secrets management

What it's NOT:

- Not architecture (that's Technical Design)
- Not technology choices (that's Technology Stack)
- Not coding tutorials (assumes developer competence)

### User Interface Guide

Where: ./docs/ux_guide.md

#### Purpose

- Ensure visual consistency — Standardises look and feel across the product
- Guide design decisions — Provides framework for UI choices
- Document patterns — Records reusable UI patterns and components
- Align to vision — Ensures UI reflects product principles

#### Scope

- Design Principles — Core UX philosophy aligned to product vision
- Component Library — Standard UI elements and their usage
- Layout Patterns — Page structures, spacing, responsive behaviour
- Typography — Fonts, sizes, hierarchy
- Colour System — Palette, semantic colours, accessibility
- Interaction Patterns — Common behaviours, feedback, states
- Accessibility — Standards and requirements

What it's NOT:

- Not wireframes or mockups (those live in design tools)
- Not implementation code (that's in the codebase)
- Not user research (that informs the vision)

## Other Project Knowledge

The Knowledge Base captures ad-hoc knowledge that doesn't belong in mandated documents:

- **Research Notes** — General comparisons and investigations (e.g., "OAuth vs JWT comparison")
- **Implementation Details** — How something was actually built (e.g., "oauth-implementation.md")
- **Extensions** — Elaborations that extend mandated docs without changing them

Knowledge notes are stored in `./docs/knowledge/` with a simple index.

Spikes produce knowledge notes as their primary output.

## Document Authority & Relationships

Documents form a directed authority graph, not a strict hierarchy:

```text
                        Vision
                       (supreme)
                      /         \
                     /           \
        Technology Stack    Conceptual Design
                     \           /
                      \         /
                    Technical Design
                           |
                    ┌──────┴──────┐
                    │             │
               Development    UX Guide
                 Guide
```

### Authority Rules

1. **Vision** is the supreme authority. All other documents must align to and support the Vision.
2. **Technology Stack** and **Conceptual Design** are siblings, both derived from the Vision.
3. **Technical Design** must align to both Technology Stack (what we build with) and Conceptual Design (what we're modelling).
4. **Development Guide** aligns to Technology Stack and Technical Design.
5. **UX Guide** aligns to Vision and Conceptual Design.

### Document Alignment Principle

Lower documents must **enable** higher documents. If the Vision describes a web application, the Technology Stack cannot specify desktop-only technology. If the Conceptual Design defines a "Subscription" entity, the Technical Design must model it.

## Work Items

"Work Items" is the collective name for Features, Epics, Tasks and Spikes.

All work items:

- Describe work to be done on a project
- Share a common set of statuses they move through
- Have a consistent file structure with common sections
- Follow the same lifecycle commands pattern

### Work Item Hierarchy

```text
Feature (persistent, what the product IS)
    └── Epic (groups related tasks, historical record)
            └── Task (specific implementation work)

Spike (standalone exploratory work, produces knowledge)
```

- **Features → Epics → Tasks** is the primary traceability chain
- Tasks CAN be orphaned (not linked to an epic/feature) for one-off work
- Spikes are standalone but MAY link to a feature when exploring for a known purpose

### Work Item Types

#### Feature

A Feature describes a persistent capability of the product — what the product IS, not work to be done.

- **Persistence**: Features never "complete" — they describe ongoing capabilities
- **Lifecycle**: Features cycle between STABLE (no active work) and ACTIVE (epic in progress)
- **Granularity**: A project typically has 5-15 features
- **Traceability**: Features elaborate the Vision; Epics elaborate Features
- **Location**: `./docs/features/FEAT-XXX-slug.md`

Examples:

- "Authenticates Users" (capability)
- "Processes Payments" (capability)
- "Provides Analytics Dashboard" (capability)

#### Epic

An Epic groups related tasks into a coherent unit of work, replacing the informal "phases" concept.

- **Persistence**: Epics are historical records — completed epics remain as documentation
- **Lifecycle**: Epics flow through all statuses from DRAFT to APPROVED
- **Granularity**: An epic contains 3-10 tasks typically
- **Traceability**: Epics belong to a Feature; Tasks belong to an Epic
- **Location**: `./docs/epics/EPIC-XXX-slug.md`

Examples:

- "Add OAuth Providers" (under "Authenticates Users" feature)
- "Implement Stripe Integration" (under "Processes Payments" feature)
- "Build Usage Charts" (under "Provides Analytics Dashboard" feature)

#### Task

A Task is a discrete development assignment — the atomic unit of implementation work.

- **Persistence**: Tasks are archived when completed
- **Lifecycle**: Tasks flow through all statuses from DRAFT to APPROVED
- **Granularity**: A task should be completable in a single focused session
- **Traceability**: Tasks typically belong to an Epic, but can be orphaned
- **Location**: `./docs/tasks/TASK-XXX-slug.md` (archived to `./docs/tasks/archive/`)

Examples:

- "Add Google OAuth provider" (under "Add OAuth Providers" epic)
- "Create Stripe webhook handler" (under "Implement Stripe Integration" epic)
- "Fix login redirect bug" (orphan task)

#### Spike

A Spike is exploratory work to reduce uncertainty — the output is knowledge, not implementation.

- **Persistence**: Spikes are disposable; knowledge is captured in knowledge notes
- **Lifecycle**: Spikes flow through statuses but focus on ELABORATED → IMPLEMENTED
- **Granularity**: Time-boxed investigation, typically hours not days
- **Traceability**: Standalone, but MAY link to a feature for context
- **Location**: `./spikes/SPIKE-XXX-slug.md`
- **Output**: Knowledge notes in `./docs/knowledge/`

Examples:

- "Evaluate Stripe vs Square for payments"
- "Prototype WebSocket architecture"
- "Investigate performance bottleneck in dashboard"

### Work Item Indexes

Each work item type has a simple index file:

- Tasks: `./docs/tasks/task_index.md`
- Epics: `./docs/epics/epic_index.md`
- Features: `./docs/features/feature_index.md`
- Spikes: `./spikes/spike_index.md`

Index format is a simple list:

```markdown
- [TASK-001](./TASK-001-add-oauth.md) - ELABORATED - Add Google OAuth provider #auth
- [TASK-002](./TASK-002-webhook-handler.md) - DRAFT - Create Stripe webhook handler #payments
```

No tables, no statistics — just links with status and tags for quick navigation.

### Work Item Statuses

All work items share a unified status model:

```text
DRAFT ──► ELABORATED ──► PLANNED ──► IMPLEMENTING ◄──► IMPLEMENTED ◄──► REVIEW ──► APPROVED
      │              │           │                                              │
   GATE 1         GATE 2     (iterative zone)                                GATE 3
```

#### Status Definitions

| Status | Meaning | Exit Criteria |
|--------|---------|---------------|
| **DRAFT** | Captured but not elaborated. High-level intent only. | Requirements section complete |
| **ELABORATED** | Requirements complete, aligned to documentation. Ready for planning. | **GATE 1**: User approves requirements |
| **PLANNED** | Implementation approach defined. Ready to implement. | **GATE 2**: User approves plan |
| **IMPLEMENTING** | Active implementation in progress. | Implementation complete |
| **IMPLEMENTED** | Implementation complete, awaiting review. | Review complete |
| **REVIEW** | Under review, may iterate back to IMPLEMENTING. | All acceptance criteria met |
| **APPROVED** | Complete and approved. | **GATE 3**: User final approval |

#### Quality Gates

Three hard gates require explicit user approval:

1. **Gate 1 (DRAFT → ELABORATED)**: Are the requirements complete and aligned?
2. **Gate 2 (ELABORATED → PLANNED)**: Is the implementation plan sound?
3. **Gate 3 (REVIEW → APPROVED)**: Does the implementation meet requirements?

The IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW zone is iterative — AI and user work back and forth until ready for final approval.

### Work Item Sections

All work items share a common file structure:

#### Metadata

```markdown
## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-003](../epics/EPIC-003-oauth-providers.md)
- **Feature**: [FEAT-001](../features/FEAT-001-authenticates-users.md)
- **Created**: 2025-01-15
- **Updated**: 2025-01-18
```

#### Requirements

Filled during elaboration. Contains:

- **Overview**: What this work item accomplishes
- **User Stories**: Who benefits and how (where applicable)
- **Acceptance Criteria**: Checkbox list of success criteria
- **Context**: Links to and summaries of relevant documentation

#### Plan

Filled during planning. Contains:

- **Approach**: How the work will be accomplished
- **Steps**: Ordered implementation steps
- **Dependencies**: What must exist before this can proceed
- **Risks**: Known risks and mitigations

#### Activity Log

Timestamped entries recording the history:

```markdown
## Activity Log

- **2025-01-18 14:30** - ELABORATED: Requirements approved by user
- **2025-01-17 10:15** - DRAFT: Created from conversation about OAuth providers
```

### Work Item ↔ Document Relationships

Different work item types interact with different documents at different stages.

#### Relationship Types

- **Must Align To**: Read-only authority. Work item must not contradict this document.
- **Informed By / May Update**: Work item consults this document and may elaborate it with specifics.

#### Feature Relationships

| Stage | Must Align To | Informed By / May Update |
|-------|---------------|--------------------------|
| Elaboration | Vision | — |
| Planning | Vision, Conceptual Design | Technology Stack |

#### Epic Relationships

| Stage | Must Align To | Informed By / May Update |
|-------|---------------|--------------------------|
| Elaboration | Vision, parent Feature, Conceptual Design | — |
| Planning | Technology Stack, parent Feature | Technical Design |

#### Task Relationships

| Stage | Must Align To | Informed By / May Update |
|-------|---------------|--------------------------|
| Elaboration | Parent Epic/Feature, relevant Guides (UX Guide) | — |
| Planning/Implementation | Development Guide, Technical Design | — |

#### Spike Relationships

| Stage | Must Align To | Informed By / May Update |
|-------|---------------|--------------------------|
| Elaboration | — | — |
| Implementation | — | Knowledge Base (output) |

#### Key Pattern

As work items move down the hierarchy (Feature → Epic → Task) and through stages:

- Authority shifts from high-level docs (Vision) to implementation docs (Guides)
- Higher work items can update mid-level docs; lower work items only consume them
- **Guides are never updated by work items** — they are reference material


## Implementation

Shannon is implemented using three layers: **Commands**, **Skills**, and **Subagents**.

### Architecture Overview

```text
Commands (user-facing, thin)
    │
    ├── Invoke Skills (framework logic, reusable)
    │       │
    │       └── Spawn Subagents (context-heavy work)
    │               - Read multiple docs
    │               - Check alignment
    │               - Draft elaborations
    │               - Return structured summaries
    │
    └── Project-specific extensions (optional per-project customization)
```

### Commands

Commands are user-invoked entry points. They are intentionally thin — identifying what to do, then delegating to skills.

Location: `/.claude/commands/`

Commands handle:

- Parsing user arguments
- Identifying the target work item or document
- Invoking the appropriate skill
- Project-specific extensions (optional)

Example command structure:

```markdown
# /task-create

Create a new task work item.

Use the work-items skill to create a task with the provided title hint.
If no title provided, suggest from recent conversation context.

After creation, resume the original topic of conversation.
```

### Skills

Skills contain the core framework logic. They are reusable across commands and enforce consistency.

Location: `/.claude/skills/`

Proposed skills:

| Skill | Purpose |
|-------|---------|
| `project-setup` | Initialize a new project with Shannon |
| `project-documentation` | Manage mandated documents (create, review, approve) |
| `work-items` | Manage all work item types through their lifecycle |

Skills handle:

- The actual process logic (how to elaborate, plan, implement)
- Document relationship rules (what aligns to what)
- Quality gate enforcement
- Template instantiation
- Index updates

Skills contain their templates:

```text
/.claude/skills/
├── project-setup/
│   ├── skill.md
│   └── templates/
│       └── CLAUDE.md
├── project-documentation/
│   ├── skill.md
│   └── templates/
│       ├── vision.md
│       ├── technology_stack.md
│       ├── conceptual_design.md
│       ├── technical_design.md
│       ├── development_guide.md
│       └── ux_guide.md
└── work-items/
    ├── skill.md
    └── templates/
        ├── feature.md
        ├── epic.md
        ├── task.md
        ├── spike.md
        ├── feature_index.md
        ├── epic_index.md
        ├── task_index.md
        └── spike_index.md
```

### Subagents

Subagents handle context-heavy operations that would bloat the main conversation.

Subagents are spawned by skills for:

- Reading multiple documents to check alignment
- Drafting elaborations or plans
- Performing alignment checks across work items
- Any operation requiring significant document reading

Subagent communication:

- Subagent reads work item file and relevant documents
- Subagent writes updates directly to the work item file
- Subagent returns a structured summary to the main agent
- Main agent presents summary to user

Benefits:

- **Context management**: Main conversation stays focused
- **Model optimization**: Subagents can use faster/cheaper models for routine work
- **Parallelization**: Multiple subagents can work concurrently

### Command Reference

#### Project Setup

| Command | Purpose |
|---------|---------|
| `/shannon-setup` | Initialize project with Shannon framework |

#### Work Item Lifecycle

All work item types follow the same command pattern:

| Command Pattern | Purpose | Gate |
|-----------------|---------|------|
| `/[type]-create [hint]` | Create new work item in DRAFT | — |
| `/[type]-elaborate [ID]` | Elaborate requirements | Gate 1 |
| `/[type]-plan [ID]` | Create implementation plan | Gate 2 |
| `/[type]-implement [ID]` | Execute implementation | — |
| `/[type]-review [ID]` | Review and approve | Gate 3 |

Where `[type]` is: `feature`, `epic`, `task`, or `spike`

#### Document Management

| Command | Purpose |
|---------|---------|
| `/document-create [type]` | Create a mandated document |
| `/document-review [path]` | Review and approve a document |

### Lifecycle Commands Detail

#### Creation → DRAFT

**Command**: `/[type]-create [optional title-hint]`

**Purpose**: Fast capture without blocking developer flow.

**What it does**:

- Prompts for title if not provided (suggests from conversation context)
- Creates work item file from template with slug-based filename
- Captures only high-level intent (AI adds available context)
- Adds to relevant index
- Confirms creation
- **Resumes original conversation topic**

#### Elaboration → ELABORATED (Gate 1)

**Command**: `/[type]-elaborate [optional ID or hint]`

**Purpose**: Complete requirements, ensure alignment to documentation.

**What it does**:

- Identifies target work item (prompts if ambiguous)
- Spawns subagent to:
  - Read work item and parent work items
  - Read required documents (per relationship rules)
  - Draft requirements section
  - Check alignment
- Presents elaboration to user
- **Requires explicit approval** to mark ELABORATED
- Updates index
- **Resumes original conversation topic**

#### Planning → PLANNED (Gate 2)

**Command**: `/[type]-plan [optional ID or hint]`

**Purpose**: Define implementation approach, get approval before work begins.

**What it does**:

- Identifies target work item
- Spawns subagent to:
  - Read elaborated requirements
  - Read technical documents (per relationship rules)
  - Draft implementation plan
  - Identify dependencies and risks
- Presents plan to user
- **Requires explicit approval** to mark PLANNED
- Updates index
- **Resumes original conversation topic**

#### Implementation → IMPLEMENTING → IMPLEMENTED

**Command**: `/[type]-implement [optional ID or hint]`

**Purpose**: Execute the plan, iterating with user as needed.

**What it does**:

- Identifies target work item (must be PLANNED)
- Marks as IMPLEMENTING
- Executes plan steps
- Updates Activity Log with progress
- Marks IMPLEMENTED when complete
- May iterate back from REVIEW

#### Review → APPROVED (Gate 3)

**Command**: `/[type]-review [optional ID or hint]`

**Purpose**: Verify implementation meets requirements.

**What it does**:

- Identifies target work item
- Reviews against acceptance criteria
- Presents review summary
- **Requires explicit approval** to mark APPROVED
- Archives if applicable (tasks)
- Updates index

### Cascading Operations

When operating on higher-level work items, the question arises: should child items be processed too?

**Recommended approach: Batch Preparation, Individual Gates**

```text
/epic-plan EPIC-002
    │
    ├── Plans the epic itself
    ├── Identifies child tasks needed
    ├── Drafts plans for each task (marks as PLAN-PENDING)
    └── Presents summary to user

/task-approve TASK-034
    └── Approves individual task plan (PLAN-PENDING → PLANNED)
```

Benefits:

- AI does bulk preparation work
- User reviews at their own pace
- Granular approval maintained
- No overwhelming approval surfaces

Alternative statuses for pending approval:

- `ELABORATE-PENDING` → awaiting Gate 1
- `PLAN-PENDING` → awaiting Gate 2
- `APPROVE-PENDING` → awaiting Gate 3

### Skill Activation

Skills are invoked explicitly by commands. To ensure reliable activation:

1. **Explicit command wording**: Commands state "You MUST invoke the [skill] skill"
2. **Skill self-identification**: Skills begin with confirmation of purpose
3. **Fallback handling**: Commands include "If skill did not activate, report error"

Example command with explicit invocation:

```markdown
# /task-elaborate

Elaborate a task's requirements.

You MUST invoke the work-items skill to elaborate this task.
Pass the task ID or hint provided by the user.

If the work-items skill does not activate, inform the user:
"Error: work-items skill failed to activate. Please try again."
```

### Implementation Considerations

#### Open Questions

1. **Command naming**: `/task-create` vs `/create-task`? Current preference: `/task-create` (noun-verb groups related commands)

2. **Skill granularity**: One `work-items` skill covering all types, or separate skills per type? Current preference: Single skill with type parameter for consistency.

3. **Pending statuses**: Add `*-PENDING` statuses for cascading operations, or handle differently?

#### Required Alignment

Any implementation must ensure consistency across:

- Commands in `/.claude/commands/`
- Skills in `/.claude/skills/`
- The CLAUDE.md template
- This specification document

## Why "Shannon"?

Named after **Claude Shannon** (1916-2001), the father of information theory. Shannon's groundbreaking work on efficient information transmission and storage directly mirrors this framework's approach to AI context management:

- **Shannon's Theory**: How to transmit maximum information with minimum bandwidth
- **Shannon Framework**: How to provide maximum context to AI with minimum overhead

Shannon (the person) proved that you can communicate perfectly despite noise if you structure information correctly. Shannon (the framework) proves you can develop perfectly despite context limits if you structure documentation and context correctly.
