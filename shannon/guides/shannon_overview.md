# Shannon - Complete System Overview

**Version**: 3.0
**Last Updated**: 2025-11-09

## Purpose

This document provides a complete overview of Shannon, a documentation framework for AI-assisted development with Claude Code. Shannon integrates documentation management, feature planning, task execution, and knowledge capture into a cohesive workflow designed for solo developers working with AI pair programming.

The system is designed for:
- **AI (Claude Code)** - As context for implementing commands and reading documentation
- **Human Developers** - For understanding the workflow and maintaining projects

**Focus**: This overview emphasizes inter-relationships and workflow. For detailed command specifications, see individual how-to guides.

## Installation

To use Shannon in your project:

```bash
# From the Shannon repository
mkdir -p /path/to/your-project/.claude
cp -r shannon/templates /path/to/your-project/.claude/templates
cp -r shannon/commands /path/to/your-project/.claude/commands
cp -r shannon/guides /path/to/your-project/.claude/guides
```

Then run `/project-setup` in your project to initialize the documentation structure.

## Why "Shannon"?

Shannon is named after **Claude Shannon** (1916-2001), the mathematician who founded information theory. The connection is more than just a clever name:

**Shannon's Contribution to Computing:**
- Proved the fundamental limits of data compression and transmission
- Showed how to communicate reliably despite noise (error correction)
- Established that information has measurable structure and can be optimized

**How This Relates to Shannon Framework:**
- **Context Management**: Just as Shannon (person) optimized signal transmission, Shannon (framework) optimizes context transmission to AI
- **Structured Information**: Shannon proved structure enables efficiency—this framework structures documentation for efficient AI consumption
- **Signal vs. Noise**: The framework filters signal (relevant documentation) from noise (redundant information)
- **Lossless Compression**: Mandated docs compress project knowledge into dense, navigable format

In essence: Shannon (person) figured out the math of efficient information transmission. Shannon (framework) applies those principles to AI-assisted development.

**The Name Game:**
- Claude Shannon: Father of information theory
- Shannon Claude: Documentation framework for Claude Code
- One revolutionized how machines process information
- The other helps Claude Code process your project's information

Perfect match. 🎯

## System Architecture

### Four-Layer Flow

```
Mandated Documentation (8 documents: vision, architecture, style guides)
 └─ Well-defined scopes guide all development
 └─ DRAFT/APPROVED status with human review
 └─ Linked to detailed knowledge notes
      ↓ (guides and informs)
Product Requirements (product_requirements.md)
 └─ Sections describe product capabilities (no numbered requirements)
 └─ Cross-references to features
      ↓ (informs vision)
Features (Persistent Product Characteristics)
 └─ What the product IS (e.g., "Secures User Data", "Organizes Ideas")
 └─ Phases break work into manageable units
 └─ Features cycle: STABLE ↔ ACTIVE
 └─ Links to technical_design.md for implementation approach
      ↓ (plans implementation)
Tasks (Discrete Work Items)
 └─ Implementation units with clear completion criteria
 └─ Five-state lifecycle: TODO → READY → IN PROGRESS → REVIEW → COMPLETED
 └─ Pre-reads conceptual_design, technical_design, style guides
 └─ Can be orphans (not everything needs feature alignment)
      ↓ (creates)
Implementation (Code, Tests, Docs)
 └─ Follows code_style_guide, ux_style_guide, development_design
 └─ Updates documentation as implementation evolves
 └─ Captures lessons learned in knowledge base

Complete Traceability:
Mandated Docs ↔ Requirements § Sections → Features → Phases → Tasks → Implementation → Knowledge Notes
```

### Core Principles

1. **Documentation Guides Development** - Well-scoped docs inform planning, design, and implementation
2. **Features Are Persistent** - Features never "complete"; they describe enduring product characteristics
3. **Phases Manage Implementation** - Work happens in phases within features
4. **Tasks Are Discrete** - Clear start, clear end, clear completion criteria
5. **Orphan Tasks Are OK** - Quick fixes don't need feature alignment
6. **User Stories Evolve** - Stories refined during implementation; alignment maintained via reviews
7. **Three Quality Gates** - Documentation approval, planning approval, completion approval
8. **Continuous Alignment** - Built-in drift detection across docs, features, tasks, and code
9. **AI-Assisted Planning** - AI helps during planning and documentation, human approves before implementation
10. **Knowledge Base for Details** - Mandated docs stay high-level; details go in knowledge notes

## Documentation Flow

### Mandated Documents (8 Core Documents)

**Purpose**: Well-scoped, high-level documentation that guides all development activities.

**Documents**:
1. **product_requirements.md** - Product vision, personas, user stories, product pillars
2. **technology_stack.md** - Languages, frameworks, libraries, tools (with rationale)
3. **conceptual_design.md** - Domain model, core concepts, business logic
4. **technical_design.md** - System architecture, technical implementation strategy
5. **code_style_guide.md** - Code style, linting, naming, comment standards
6. **ux_style_guide.md** - UI style, layout patterns, visual design rules
7. **documentation_style_guide.md** - User-facing documentation writing standards
8. **development_design.md** - Version control, testing, CI/CD, deployment

**Status**: Each document has DRAFT or APPROVED status
- DRAFT: Unreviewed AI-generated content (triggers warnings when consumed)
- APPROVED: Human-reviewed and approved (safe to consume)

**Version History**: All changes tracked with dates and rationale

**Human Review**: Use `/document-review` to approve sections interactively

### Knowledge Base (Flexible Detail Storage)

**Purpose**: Project-specific details, research, and implementation specifics that don't fit mandated doc scopes.

**Structure**:
```
./docs/knowledge/
├── knowledge_index.md           # Master index
├── research/                    # General research, comparisons
├── implementation-details/      # Project-specific implementation
├── project-requirements-extra/  # Extends product_requirements.md
├── technical-design-extra/      # Extends technical_design.md
└── [other-doc]-extra/          # Extends other mandated docs
```

**Integration**:
- Mandated docs link to knowledge notes for details
- Knowledge notes link back to mandated docs, features, tasks
- Updated automatically during `/document`, `/task-implement`, `/task-review`

### Documentation Lifecycle Integration

```
Project Setup → Elaborate → Feature Planning → Task Planning → Implementation → Review
      ↓             ↓              ↓                ↓                ↓            ↓
  Instantiate   Progressive   Update tech    Pre-read docs    Follow style  Verify docs
  from          elaboration   design with    Create research  guides        updated
  templates     with human    approach       notes if needed  Update docs   Create
  All DRAFT     approval                                      as needed     knowledge
                                                                            notes
```

## Quick Start Guide

### For New Projects (With Documentation)

```bash
# 1. Initialize project structure
/project-setup "MyApp - Description"
# Creates:
# - 8 mandated documents from templates (all DRAFT)
# - Knowledge base structure
# - Task/feature indexes
# - Pre-populates with context from description

# 2. Progressively elaborate documentation
/project-elaborate
# AI asks clarifying questions to expand:
# - product_requirements.md (product vision, personas, stories)
# - technology_stack.md (language, frameworks, rationale)
# - conceptual_design.md (domain model, entities)
# - technical_design.md (architecture, components)
# Iterative process - doesn't complete all in one sitting
# Marks additions as DRAFT, prompts for review

# 3. Review and approve foundational docs
/document-review project_requirements
# Section-by-section interactive review
# Approve/Edit/Skip/Reject each section
# Mark APPROVED when ready

/document-review technical_design
# Approve architecture decisions
# Status: DRAFT → APPROVED

# 4. Create first feature (reads product_requirements.md)
/feature-create "Secures User Data"
# AI pre-reads: product_requirements.md § "User Authentication"
# AI asks: Ideal state? User stories? Phase 1 MVP?
# Updates: product_requirements.md with feature cross-reference
# Created: FEAT-001 (STABLE)

# 5. Plan Phase 1 (reads/updates technical_design.md)
/feature-phase-plan FEAT-001 1
# AI pre-reads:
# - product_requirements.md § "User Authentication"
# - technical_design.md (architecture)
# - conceptual_design.md (domain model)
# AI may research: /document "OAuth 2.0 vs JWT"
# AI creates: knowledge/research/oauth-vs-jwt-auth.md
# AI updates:
# - technology_stack.md (adds Authlib library + rationale)
# - technical_design.md § Authentication (OAuth approach)
# Both marked DRAFT
# Created: 8 tasks for Phase 1

# 6. Review technical design updates
/document-review technical_design
# Review § Authentication section
# Approve if acceptable
# Status: DRAFT → APPROVED (for reviewed sections)

# 7. Start Phase 1
/feature-phase-start FEAT-001 1
# Feature: STABLE → ACTIVE

# 8. Plan first task (reads docs + creates knowledge if needed)
/task-ready TASK-001
# AI pre-reads:
# - FEAT-001 feature document
# - conceptual_design.md (domain model)
# - technical_design.md § Authentication
# - knowledge/research/oauth-vs-jwt-auth.md
# AI may research implementation details
# AI creates: knowledge/implementation-details/oauth-implementation.md
# AI builds: Phased implementation plan in task
# Task: TODO → READY

# 9. Implement task (follows style guides)
/task-implement TASK-001
# AI pre-reads:
# - Task implementation plan
# - knowledge/implementation-details/oauth-implementation.md
# - development_design.md (testing requirements)
# - code_style_guide.md (naming, docstrings, comments)
# AI implements: Following all style guides
# AI updates: technical_design.md if implementation differs from plan
# AI creates/updates: Knowledge notes for complex patterns
# AI writes: Tests per development_design.md
# User confirms each step
/task-implement TASK-001 --complete
# Task: IN PROGRESS → REVIEW

# 10. Review task (checks docs updated)
/task-review TASK-001
# AI checks:
# - Code follows code_style_guide ✅
# - Tests written and passing (per development_design.md) ✅
# - technical_design.md aligned with implementation ✅
# - Knowledge notes updated with lessons learned ✅
# Options: --approve, --request-changes, --add-notes
/task-review TASK-001 --approve
# Task: REVIEW → COMPLETED (archived)

# 11. Document learnings after several tasks
/document
# AI analyzes recent conversation and completed tasks
# AI updates:
# - technical_design.md (high-level patterns discovered)
# - knowledge notes (detailed implementation, error handling)
# AI marks: technical_design.md as DRAFT
# Prompts: Run /document-review when ready

# 12. Complete Phase 1 (checks alignment)
/feature-phase-complete FEAT-001 1
# Quality gates:
# - All tasks COMPLETED ✅
# - Tests passing ✅
# - Documentation updated (including technical_design.md) ✅
# - Alignment: project_requirements ↔ feature ↔ implementation ✅
# Feature: ACTIVE → STABLE (or continue to Phase 2)

# 13. Navigate when uncertain
/project-whats-next
# Shows: Urgent actions, active work, DRAFT docs, drift warnings
# Provides: Specific next commands to run
```

### For Existing Projects (Quick Start)

```bash
# 1. Initialize with existing codebase
/project-setup
# Analyzes existing project
# Creates mandated docs, populates from code/README
# Initializes knowledge base

# 2. Quick-capture existing work
/task-create "Fix authentication bug"
/task-create "Implement search feature"

# 3. Document existing implementation
/document "./src/auth/oauth.py"
# AI reads implementation
# AI updates: technical_design.md § Authentication
# AI creates: knowledge/implementation-details/oauth-implementation.md
# Marks: technical_design.md as DRAFT

# 4. Plan and implement tasks with documentation
/task-ready TASK-001
# Pre-reads docs, builds plan
/task-implement TASK-001
# Follows style guides, updates docs
/task-review TASK-001 --approve
# Verifies docs updated

# 5. Periodic alignment check
/feature-review all
# Catches drift between docs and implementation
```

## File Structure

```
./docs/
├── product_requirements.md          # Product vision (formerly prd.md)
├── technology_stack.md              # Languages, frameworks, tools
├── conceptual_design.md             # Domain model, concepts
├── technical_design.md              # Architecture, implementation strategy
├── code_style_guide.md              # Code style rules
├── ux_style_guide.md                # UI/UX style rules
├── documentation_style_guide.md     # User docs writing standards
├── development_design.md            # Testing, CI/CD, deployment
├── SYSTEM_OVERVIEW.md               # This file
├── templates/                       # Templates for all document types
│   ├── product_requirements.md.template
│   ├── technology_stack.md.template
│   ├── [... all other templates]
│   └── knowledge_note.md.template
├── knowledge/                       # Knowledge base
│   ├── knowledge_index.md           # Master index
│   ├── research/                    # General research
│   ├── implementation-details/      # Project-specific details
│   ├── project-requirements-extra/  # Extends product_requirements.md
│   ├── technical-design-extra/      # Extends technical_design.md
│   └── [other-doc]-extra/          # Extends other mandated docs
├── tasks/
│   ├── tasks_how_to.md              # Task system guide (899 lines)
│   ├── task_index.md                # Lightweight task index
│   ├── TASK-XXX-slug.md             # Individual task files
│   └── archive/                     # Completed tasks
├── features/
│   ├── features_how_to.md           # Feature system guide (1033 lines)
│   ├── feature_index.md             # Lightweight feature index
│   └── FEAT-XXX-slug.md             # Individual feature files
└── project/
    └── project_how_to.md            # Project system guide (749 lines)
```

## Lifecycles

### Document Lifecycle

```
Template → DRAFT → APPROVED → DRAFT (when changed) → APPROVED
    ↓         ↓         ↓                ↓                 ↓
Instantiate  AI adds   Human      AI updates      Human reviews
during       content   reviews    (marks DRAFT)   again
/project-    (marks    section-
setup        DRAFT)    by-section
```

**Commands**:
- `/project-setup` - Instantiate from templates
- `/project-elaborate` - AI adds content (marks DRAFT)
- `/document` - AI updates docs + creates knowledge notes
- `/document-review` - Human approval (marks APPROVED)
- `/document-lookup` - Search across all documentation

### Task Lifecycle (With Documentation)

```
TODO → READY → IN PROGRESS → REVIEW → COMPLETED
  ↓      ↓          ↓            ↓         ↓
Quick  Pre-read  Follow      Verify     Archive
capture docs     style       docs       task +
        Create   guides      updated    knowledge
        research Update
        notes    docs
```

**Documentation touchpoints**:
- **TODO → READY**: `/task-ready` pre-reads conceptual_design, technical_design, knowledge; may create research notes
- **IN PROGRESS**: `/task-implement` follows code_style_guide, ux_style_guide, development_design; updates technical_design if needed
- **REVIEW**: `/task-review` verifies docs updated, style guides followed, knowledge notes created

### Feature Lifecycle (With Documentation)

```
STABLE ↔ ACTIVE
   ↓       ↓
  No     Phase
 active   in
 work   progress
         ↓
     Updates
     technical_design
     Creates
     knowledge notes
```

**Documentation touchpoints**:
- **Phase Plan**: `/feature-phase-plan` reads technical_design, may update with approach, creates research notes
- **Phase Complete**: `/feature-phase-complete` verifies technical_design aligned, updates with actual implementation

## Key Commands (Organized by Flow)

### Setup and Elaboration

- `/project-setup` - Initialize structure (mandated docs, knowledge base, task/feature indexes)
- `/project-elaborate` - Progressively expand mandated docs with AI assistance
- `/document-review [$doc_type]` - Interactive section-by-section approval of mandated docs
- `/document [$topic]` - Research + update mandated docs + create knowledge notes
- `/document-lookup $topic` - Search across mandated docs and knowledge base

### Feature Planning (Reads/Updates Documentation)

- `/feature-create [name]` - Create persistent feature (reads product_requirements.md)
- `/feature-phase-plan FEAT-XXX [phase]` - Plan tasks (reads technical_design, may research, updates docs)
- `/feature-phase-start FEAT-XXX [phase]` - Start phase (STABLE → ACTIVE)
- `/feature-phase-complete FEAT-XXX [phase]` - Complete phase (verifies docs aligned)
- `/feature-roadmap FEAT-XXX` - Manage phases and align user stories
- `/feature-alignment FEAT-XXX` - Check project_requirements/story/implementation/docs alignment
- `/feature-review FEAT-XXX|all` - Comprehensive drift detection (includes doc drift)
- `/feature-list [filter]` - List features
- `/feature-status FEAT-XXX` - Detailed feature status

### Task Implementation (Reads/Updates Documentation)

- `/task-create [description]` - Quick capture (creates TODO)
- `/task-ready TASK-XXX` - AI-assisted planning (pre-reads docs, creates research notes)
- `/task-implement TASK-XXX [--complete]` - Implement (follows style guides, updates docs)
- `/task-review TASK-XXX [--approve|--request-changes]` - Review (verifies docs updated)
- `/task-list [filter]` - List tasks
- `/task-status` - Generate statistics
- `/task-prioritize` - Re-prioritize tasks
- `/task-coverage-review` - Check task coverage
- `/task-reset TASK-XXX` - Reset to TODO
- `/task-delete TASK-XXX` - Delete task

### Project Navigation

- `/project-whats-next` - Context-aware navigation (includes DRAFT doc warnings)
- `/project-coverage` - Analyze traceability (includes doc alignment)
- `/project-analyze-dependencies` - Check dependency health
- `/project-generate-docs` - Generate user/developer documentation

## Quality Gates (Three Gates)

### Gate 1: Documentation Approval (`/document-review`)

**Purpose**: Ensure documentation is accurate before using it for planning

**Process**:
1. AI generates/updates mandated doc content (marked DRAFT)
2. Human reviews sections interactively
3. Approve/Edit/Skip/Reject each section
4. Mark APPROVED when ready
5. DRAFT status triggers warnings in other commands

**Benefits**:
- Ensures architectural decisions are sound before implementing
- Catches inconsistencies in documentation
- Provides human oversight on AI-generated technical content

### Gate 2: Planning Approval (`/task-ready`)

**Purpose**: Ensure task is fully understood before coding

**Process**:
1. AI pre-reads conceptual_design, technical_design, knowledge notes
2. AI creates research notes if needed
3. AI asks clarifying questions
4. AI builds phased implementation plan
5. Human reviews and approves plan
6. Task moves: TODO → READY

**Benefits**:
- Prevents premature implementation
- Maximizes AI value (planning is where AI helps most)
- Ensures implementation follows documented architecture
- Creates research notes for reuse

### Gate 3: Completion Approval (`/task-review`)

**Purpose**: Ensure implementation meets requirements and docs updated

**Process**:
1. AI reviews implementation against plan
2. AI checks style guides followed
3. AI checks tests written (per development_design.md)
4. AI verifies technical_design aligned with implementation
5. AI verifies knowledge notes created/updated
6. Human decides: approve, request changes, or add notes

**Benefits**:
- Catches incomplete work
- Ensures documentation stays aligned
- Ensures style guides followed
- Captures lessons learned in knowledge base

## Inter-Relationships and Data Flow

### Project Requirements → Features

```
product_requirements.md § "User Authentication"
  ↓ (referenced by)
FEAT-001: Secures User Data
  ↓ (updates)
product_requirements.md: Lists "FEAT-001 (Secures User Data)" in § "User Authentication"
```

**Commands involved**:
- `/feature-create` reads product_requirements.md, updates with cross-reference
- `/feature-alignment` checks sync between project_requirements and feature

### Technical Design → Features → Tasks

```
technical_design.md § "Authentication" (OAuth 2.0 approach)
  ↓ (informs)
/feature-phase-plan FEAT-001 1
  ↓ (creates)
TASK-001, TASK-002, ... (each references technical_design in implementation plan)
  ↓ (during /task-implement)
Follows technical_design § "Authentication"
  ↓ (if implementation differs)
Updates technical_design.md with actual approach
  ↓ (marks)
technical_design.md status: APPROVED → DRAFT
```

**Commands involved**:
- `/feature-phase-plan` reads technical_design, may update with approach
- `/task-ready` reads technical_design, creates implementation plan
- `/task-implement` follows technical_design, updates if implementation differs
- `/task-review` verifies technical_design aligned
- `/feature-phase-complete` checks alignment
- `/document-review` approves changes

### Style Guides → Implementation → Review

```
code_style_guide.md (naming conventions, docstring standards)
ux_style_guide.md (colors, typography, layout patterns)
development_design.md (testing requirements, coverage targets)
  ↓ (pre-read by)
/task-implement TASK-001
  ↓ (follows)
Implementation with proper naming, docstrings, UI style, tests
  ↓ (verified by)
/task-review TASK-001
  ✅ code_style_guide followed
  ✅ ux_style_guide followed (if UI task)
  ✅ development_design testing requirements met
```

**Commands involved**:
- `/task-implement` pre-reads relevant style guides, follows during implementation
- `/task-review` checks style guides followed

### Knowledge Base → Tasks

```
/task-ready TASK-045 (Implement OAuth flow)
  ↓ (needs implementation details)
AI researches OAuth with PKCE
  ↓ (creates)
knowledge/research/oauth-vs-jwt-auth.md (pattern comparison)
knowledge/implementation-details/oauth-implementation.md (PKCE details)
  ↓ (links)
TASK-045 implementation plan references both knowledge notes
  ↓ (during /task-implement)
AI pre-reads knowledge notes, follows patterns
  ↓ (discovers complexity)
AI updates knowledge/implementation-details/oauth-implementation.md with error handling patterns
  ↓ (after /task-review)
Knowledge notes available for future OAuth tasks
```

**Commands involved**:
- `/task-ready` creates research/implementation-detail notes as needed
- `/task-implement` reads knowledge notes, updates with discoveries
- `/document` can explicitly document learnings

### Mandated Docs → Knowledge Notes (Extensions)

```
technical_design.md § "API Design"
  ↓ (high-level approach only)
"RESTful API with FastAPI, WebSocket for real-time"
  ↓ (detailed patterns stored in)
knowledge/technical-design-extra/api-design-patterns.md
  ↓ (linked from)
technical_design.md: "See: knowledge/technical-design-extra/api-design-patterns.md"
  ↓ (indexed in)
knowledge_index.md § "Technical Design Extensions"
  ↓ (also indexed in)
technical_design.md (references at relevant sections)
```

**Commands involved**:
- `/document` creates {doc-type}-extra notes, links from parent doc
- `/document-lookup` searches across both

### Drift Detection and Correction Flow

```
Implementation evolves (JWT mentioned in plan, but OAuth tokens actually used)
  ↓ (detected by)
/feature-alignment FEAT-001
  ↓ (identifies)
technical_design.md § "Authentication" says "JWT for API tokens"
Implementation actually uses "OAuth access tokens"
  ↓ (offers options)
1. Update technical_design.md (implementation is correct)
2. Update implementation (JWT was intended)
3. Mark as acceptable drift
  ↓ (user chooses 1)
Update technical_design.md to match implementation
  ↓ (marks)
technical_design.md: APPROVED → DRAFT
  ↓ (adds)
Version history entry explaining drift correction
  ↓ (prompts)
"Run /document-review technical_design to approve changes"
  ↓ (user reviews and approves)
technical_design.md: DRAFT → APPROVED
```

**Commands involved**:
- `/feature-alignment` detects drift
- `/document-review` approves corrections
- `/feature-phase-complete` includes alignment check

## Workflow Examples (With Documentation Integration)

### Example 1: New Feature from Scratch (Full Documentation Flow)

```bash
# Prerequisites: product_requirements.md has § "Organization & Discovery" (APPROVED)

# 1. Create feature (reads product_requirements.md)
/feature-create "Organizes User Ideas"
# AI reads: product_requirements.md § "Organization & Discovery"
# AI asks: Ideal state? Initial stories? Phase 1 MVP?
# AI updates: product_requirements.md with "FEAT-003 (Organizes User Ideas)" reference
# Created: FEAT-003 (STABLE)

# 2. Plan Phase 1 (reads/updates technical_design.md)
/feature-phase-plan FEAT-003 1
# AI pre-reads:
# - product_requirements.md § "Organization & Discovery"
# - conceptual_design.md (domain: Idea, Collection entities)
# - technical_design.md (current architecture)
#
# AI asks: Storage? → PostgreSQL
#          UI framework? → React
#          Search approach? → Need to research
#
# AI runs: /document "PostgreSQL full-text search"
# AI creates: knowledge/research/search-comparison.md
# AI updates:
# - technology_stack.md (adds PostgreSQL reasoning if not present)
# - technical_design.md § "Search System" (PostgreSQL full-text approach)
# - Both marked DRAFT
#
# AI creates: 8 tasks (TASK-010 through TASK-017)

# 3. Review technical design updates before starting
/document-review technical_design
# Review § "Search System" section
# User: Approve
# Status: DRAFT → APPROVED (for reviewed section)

# 4. Start Phase 1
/feature-phase-start FEAT-003 1
# Feature: STABLE → ACTIVE

# 5. Plan first task (creates detailed knowledge notes)
/task-ready TASK-010
# AI pre-reads:
# - FEAT-003 feature document
# - conceptual_design.md § "Idea" entity
# - technical_design.md § "Search System"
# - knowledge/research/search-comparison.md
#
# AI needs implementation details
# AI researches: PostgreSQL full-text search indexing
# AI creates: knowledge/implementation-details/search-indexing-strategy.md
# AI builds: 3-phase implementation plan in task
# AI links: Both knowledge notes in plan
# Task: TODO → READY

# 6. Implement (follows style guides, updates docs)
/task-implement TASK-010
# AI pre-reads:
# - TASK-010 implementation plan
# - knowledge/implementation-details/search-indexing-strategy.md
# - development_design.md (testing requirements)
# - code_style_guide.md (naming, docstrings)
#
# AI implements: Following plan and style guides
# AI discovers: GIN index performs better than GiST for this use case
# AI updates: knowledge/implementation-details/search-indexing-strategy.md with benchmark results
# AI writes: Tests per development_design.md (pytest, 90%+ coverage)
# User confirms

/task-implement TASK-010 --complete
# Task: IN PROGRESS → REVIEW

# 7. Review (verifies docs updated)
/task-review TASK-010
# AI checks:
# ✅ Code follows code_style_guide (naming: snake_case, docstrings present)
# ✅ Tests written and passing (92% coverage)
# ✅ technical_design.md aligned (search indexing matches)
# ✅ Knowledge notes updated (benchmark results captured)
#
# AI: "All quality gates passed. Approve?"

/task-review TASK-010 --approve
# Task: REVIEW → COMPLETED (archived)

# 8. Continue with remaining tasks...
# [Implement TASK-011 through TASK-017 with same flow]

# 9. Document learnings after several tasks
/document
# AI analyzes: Recent conversation, completed tasks (TASK-010 through TASK-017)
# AI updates:
# - technical_design.md § "Search System" (actual GIN index approach vs planned GiST)
# - knowledge/implementation-details/search-indexing-strategy.md (consolidated patterns)
# AI marks: technical_design.md as DRAFT
# AI prompts: "Run /document-review technical_design"

# 10. Complete Phase 1 (alignment check includes docs)
/feature-phase-complete FEAT-003 1
# Quality gates:
# ✅ All tasks COMPLETED (8/8)
# ✅ Tests passing (92% coverage overall)
# ✅ Documentation updated:
#   - technical_design.md reflects actual implementation ✅
#   - Knowledge notes capture implementation patterns ✅
# ✅ Alignment verified:
#   - project_requirements § "Organization & Discovery" ↔ FEAT-003 ✅
#   - FEAT-003 user stories ↔ technical_design § "Search System" ✅
#   - technical_design ↔ implementation ✅
#
# ⚠️  technical_design.md has DRAFT status (changed to GIN index)
# AI: "Approve technical_design updates before marking phase complete? [y/n]"

# User runs:
/document-review technical_design
# Review § "Search System" changes (GIN vs GiST)
# Approve changes
# Status: DRAFT → APPROVED

# Complete phase:
# Phase 1 marked ✅ Complete
# Feature: ACTIVE → STABLE
```

### Example 2: Quick Bug Fix (Minimal Documentation)

```bash
# User notices typo in README

# 1. Quick capture
/task-create "Fix typo in README introduction"
# AI infers: Priority P3, Tags #docs
# Created: TASK-999 (TODO)

# 2. Plan (simple, minimal doc reads)
/task-ready TASK-999
# AI pre-reads: documentation_style_guide.md (writing standards)
# AI asks: Which section? → Introduction, first paragraph
# AI builds: Minimal plan (read README, fix typo, verify)
# Task: TODO → READY

# 3. Implement (follows doc style guide)
/task-implement TASK-999
# AI pre-reads: documentation_style_guide.md (tone, voice, style)
# AI reads: README introduction
# AI fixes: Typo while maintaining style (active voice, second person)
# User confirms
/task-implement TASK-999 --complete
# Task: IN PROGRESS → REVIEW

# 4. Review (minimal checks for simple task)
/task-review TASK-999 --approve
# AI checks:
# ✅ Typo fixed
# ✅ documentation_style_guide followed (tone, voice)
# Task: REVIEW → COMPLETED (archived)

# No #FEAT-XXX tag - orphan task, no mandated doc updates needed
```

### Example 3: Documentation Drift Correction

```bash
# After implementing several auth tasks, check alignment
/feature-alignment FEAT-001

# AI detects drift:
# - technical_design.md § "Authentication" mentions "JWT for API tokens"
# - Implementation (TASK-045, TASK-046, TASK-047) uses "OAuth access tokens"
# - product_requirements.md unchanged (no JWT/OAuth specifics)
# - knowledge/implementation-details/oauth-implementation.md describes OAuth tokens

# AI: "Drift detected between technical_design.md and implementation.
#
#      technical_design.md says: 'JWT tokens for API access'
#      Actual implementation: OAuth access tokens (no separate JWT)
#      Knowledge notes: OAuth token refresh, no JWT mentioned
#
#      Root cause: Initial technical_design was plan, implementation differed
#
#      Options:
#      1. Update technical_design.md to match implementation (implementation is correct)
#      2. Update implementation to match technical_design.md (JWT was intended)
#      3. Mark as acceptable drift (minor detail, both approaches valid)
#
#      Which option? [1/2/3]"

# User: 1 (implementation is correct)

# AI updates:
# - technical_design.md § "Authentication"
#   Old: "JWT tokens for API access"
#   New: "OAuth access tokens for API access (no separate JWT)"
# - Adds version history entry explaining drift correction
# - Marks: technical_design.md: APPROVED → DRAFT

# AI: "technical_design.md updated to match implementation.
#      Run /document-review technical_design to approve changes."

# User reviews and approves:
/document-review technical_design
# Review § "Authentication" change
# Approve
# Status: DRAFT → APPROVED
```

## Traceability (Complete Flow)

### End-to-End Example

```
Mandated Documents (guides vision and architecture)
  ↓
product_requirements.md § "User Authentication"
  - Product vision: Secure, frictionless login
  - User needs: Social login, password reset
  - Features: FEAT-001 (Secures User Data)
  ↓
technology_stack.md
  - Authlib library for OAuth 2.0 (rationale: standards-compliant)
  ↓
conceptual_design.md
  - User entity (email, password_hash, oauth_provider)
  - Session entity (token, expiry, user_id)
  ↓
technical_design.md § "Authentication"
  - OAuth 2.0 with PKCE flow
  - Session management with Redis
  - See: knowledge/implementation-details/oauth-implementation.md
  ↓
FEAT-001: Secures User Data
  - product requirements Reference: § "User Authentication"
  - Phase 1: Basic email/password ✅
  - Phase 2: OAuth integration 🔄 (active)
  ↓
TASK-045: Implement OAuth flow [COMPLETED]
  - Tags: #backend #feature #FEAT-001
  - Implementation plan references:
    - conceptual_design.md § "User", "Session"
    - technical_design.md § "Authentication"
    - knowledge/research/oauth-vs-jwt-auth.md
    - knowledge/implementation-details/oauth-implementation.md
  ↓
Implementation (code following style guides)
  - src/auth/oauth.py (follows code_style_guide.md)
    - Naming: snake_case ✅
    - Docstrings: Google-style ✅
    - Comments: Explain WHY, reference conceptual_design ✅
  - tests/auth/test_oauth.py (follows development_design.md)
    - Coverage: 95% ✅
    - pytest conventions ✅
  ↓
Knowledge Notes (lessons learned)
  - knowledge/implementation-details/oauth-implementation.md
    - Updated with token refresh error handling patterns
    - Referenced by future OAuth tasks
  ↓
User Documentation (follows documentation_style_guide.md)
  - docs/api/authentication.md
    - Tone: Friendly but professional ✅
    - Voice: Active, second person ✅
    - Code examples with context ✅
```

## Best Practices

### Documentation Management

1. **Elaborate progressively** - Use `/project-elaborate` to expand docs iteratively, not all at once
2. **Review before use** - Approve DRAFT docs with `/document-review` before planning features/tasks
3. **High-level in mandated docs** - Keep mandated docs concise, detailed patterns in knowledge notes
4. **Document as you go** - Use `/document` after decisions, task completion, learnings
5. **Link bidirectionally** - Mandated docs → knowledge notes, knowledge notes → tasks/features
6. **Trust DRAFT warnings** - If command warns about DRAFT doc, review and approve first
7. **Update when drift detected** - Use `/feature-alignment` to catch and correct doc drift

### Task Management (With Documentation)

1. **Quick capture** - Use `/task-create` immediately, planning comes later
2. **Plan with docs** - `/task-ready` pre-reads docs automatically, creates research notes
3. **Follow style guides** - `/task-implement` enforces code_style_guide, ux_style_guide, development_design
4. **Review docs updated** - `/task-review` verifies technical_design aligned, knowledge notes created
5. **Tag consistently** - Component + Type + Feature (if applicable)
6. **Allow orphans** - Quick fixes don't need feature alignment or doc updates

### Feature Management (With Documentation)

1. **Link to requirements** - Features reference product_requirements.md sections
2. **Update tech design** - `/feature-phase-plan` reads/updates technical_design.md
3. **Check alignment** - `/feature-phase-complete` verifies docs aligned before marking complete
4. **Accept evolution** - User stories and docs evolve during implementation (use `/feature-alignment`)
5. **Review periodically** - `/feature-review all` catches doc drift

### Integration Best Practices

1. **Start with vision** - Elaborate product_requirements.md before creating features
2. **Design before build** - Approve technical_design.md before starting phases
3. **Pre-read docs** - Tasks automatically pre-read relevant docs during planning
4. **Update as learned** - Implementation informs docs, not just docs informing implementation
5. **Capture in knowledge base** - Detailed patterns, research, lessons learned go in knowledge notes
6. **Navigate with `/project-whats-next`** - Shows DRAFT docs, urgent reviews, active work

## Troubleshooting (Documentation-Related)

**"Where should this information go?"**

Use `/document $topic` - AI analyzes and routes to correct mandated doc or knowledge note.

**"DRAFT warning when planning task"**

```bash
# Command warns: "Warning: technical_design.md has DRAFT status"
# Review and approve before continuing:
/document-review technical_design
# Approve relevant sections
# Status: DRAFT → APPROVED
# Retry task planning
```

**"Documentation out of sync with implementation"**

```bash
/feature-alignment FEAT-XXX
# Detects drift between:
# - project_requirements ↔ feature
# - technical_design ↔ implementation
# - conceptual_design ↔ code entities
# Options: Update docs, update code, or mark acceptable
```

**"Forgot to update docs during task"**

```bash
# /task-review catches missing doc updates
# Or run after completion:
/document
# AI analyzes recent work, updates docs and knowledge notes
```

**"Can't find documentation for topic"**

```bash
/document-lookup "authentication"
# Searches:
# - All 8 mandated documents
# - Knowledge base (research/ and implementation-details/)
# - Features and tasks
# Shows: file:line references for easy navigation
```

**"Too many DRAFT documents"**

```bash
/document-review all
# Batch-review all DRAFT docs
# Approve sections that are stable
# Defer detailed review of others
```

**"Knowledge base growing too large"**

- Split large notes (>500 lines) into subtopics
- Archive outdated research (create archive/ directory)
- Consolidate duplicate information

**"Not sure which style guide applies"**

- Code implementation → code_style_guide.md
- UI/UX work → ux_style_guide.md
- User-facing docs → documentation_style_guide.md
- Testing, CI/CD → development_design.md

## Complete Documentation

### Primary Guides (Read These)

1. **./docs/tasks/tasks_how_to.md** (899 lines)
   - Complete task system reference
   - Five-state lifecycle
   - Documentation integration in task flow
   - All task commands

2. **./docs/features/features_how_to.md** (1033 lines)
   - Complete feature system reference
   - Persistent feature philosophy
   - Documentation updates during phases
   - All feature commands

3. **./docs/project/project_how_to.md** (749 lines)
   - Complete system architecture
   - Traceability model
   - All project commands

4. **./docs/documentation_how_to.md** (1452 lines)
   - Complete documentation system reference
   - 8 mandated documents explained
   - Knowledge base structure
   - Documentation commands
   - Integration with task/feature lifecycle

5. **./docs/SYSTEM_OVERVIEW.md** (this file)
   - High-level system overview
   - Inter-relationships and flow
   - Quick start guide
   - Troubleshooting

### Change Documentation (Context)

6. **./docs/tasks/CHANGES_SUMMARY.md**
   - Lifecycle changes (4 states → 5 states)
   - Two quality gates philosophy

7. **./docs/tasks/INDEX_UPDATE_SUMMARY.md**
   - Task index format changes
   - Tag system details

## Summary

This system provides a complete, cohesive approach to solo software development:

**Four-Layer Architecture**:
- **Mandated Documentation** (8 docs) - Well-scoped guides for all development
- **Product Requirements** - Vision and user stories
- **Features** - Persistent characteristics with phases
- **Tasks** - Discrete work items
- **Knowledge Base** - Detailed research and implementation patterns

**Three Quality Gates**:
1. Documentation approval (ensure docs sound before use)
2. Planning approval (ensure task understood before coding)
3. Completion approval (ensure implementation meets requirements and docs updated)

**Continuous Alignment**:
- Documentation guides planning
- Planning informs implementation
- Implementation updates documentation
- Drift detection catches misalignment
- Periodic reviews provide safety net

**AI-Assisted Flow**:
- AI reads docs before planning
- AI creates research notes when needed
- AI follows style guides during implementation
- AI updates docs as implementation evolves
- AI captures lessons in knowledge base
- Human approves at three quality gates

**Flexible Pragmatism**:
- Orphan tasks allowed (not everything needs feature alignment)
- User stories evolve (alignment maintained via `/feature-alignment`)
- Documentation evolves (DRAFT/APPROVED status with version history)
- Knowledge base captures details (mandated docs stay high-level)

The system is designed to:
- Match real development patterns
- Prevent premature implementation
- Maintain quality without bureaucracy
- Keep documentation aligned with implementation
- Scale from quick fixes to complex multi-phase features
- Provide context-aware navigation at any point

**Total documentation**: ~4,100 lines across 5 comprehensive guides + templates, ready for implementation or adaptation.
