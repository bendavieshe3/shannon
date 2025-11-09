# Project Management System - Complete Guide

## Overview

The project management system provides the top-level orchestration across product requirements, Features, and Tasks. It ensures traceability from product requirements through implementation while supporting the natural evolution of software development.

## System Architecture

```
product requirements (Product Requirements Document)
 └─ Sections describe product capabilities
      ↓ (informs)
Features (Persistent Product Characteristics)
 └─ "What the product IS" (e.g., "Secures User Data", "Organizes Ideas")
 └─ Phases break work into manageable units
      ↓ (plans implementation)
Tasks (Discrete Work Items)
 └─ Implementation units with clear completion criteria
 └─ Can be orphans (e.g., "Fix typo in README") ✅

Traceability: product requirements → Features → Implementation
Tasks optionally link to features, but not required.
```

## Philosophy

### Core Principles

1. **Features are Persistent**: Features describe product characteristics, not projects. They evolve continuously.
2. **Features are Aspirational**: Named for what the product IS ("Secures User Data"), not what you're building
3. **Features are Few**: Limited to fundamental product characteristics (typically 5-15 for most products)
4. **Phases Manage Implementation**: Break large features into phases, don't create multiple features
5. **product requirements → Features → Tasks**: Clear traceability chain
6. **Orphan Tasks Are Fine**: Not everything needs feature alignment (typos, small fixes, etc.)
7. **Continuous Alignment**: Features drift during development; regular reviews catch this

### What Makes This Different

- Features **never complete** - they cycle between STABLE (no active work) and ACTIVE (being improved)
- Features **accumulate phases** over time as product matures
- Features **align to product requirements sections**, not numbered requirements
- Tasks **can be orphans** - practical, not dogmatic

## File Structure

```
./
├── docs/
│   ├── product_requirements.md                          # Product Requirements Document
│   │                                   # Sections describe capabilities
│   │                                   # No REQ-XXX numbering needed
│   │
│   ├── features/
│   │   ├── feature_index.md           # All features with phase status
│   │   ├── FEAT-001-secures-data.md   # Persistent feature
│   │   ├── FEAT-003-organizes-ideas.md
│   │   └── features_how_to.md         # This system guide
│   │
│   ├── tasks/
│   │   ├── task_index.md              # Scannable task list with tags
│   │   ├── TASK-XXX-slug.md           # Individual task files
│   │   ├── archive/                   # Completed tasks
│   │   └── tasks_how_to.md
│   │
│   └── project/
│       └── project_how_to.md          # This file
```

## product requirements Structure

Simple, section-based (no numbered requirements):

```markdown
# Product Requirements Document

**Last Updated**: 2025-10-05

## User Authentication

**Priority**: P0-Critical
**Status**: Phase 1 Complete, Phase 2 In Progress
**Features**: FEAT-001 (Secures User Data)

### What & Why

Users need secure authentication to protect their data and access personalized features.

### User Needs
- Secure login without friction
- Multiple authentication options
- Password recovery
- Account security

### Acceptance Criteria
- Users can register and login
- Sessions managed securely
- Password reset works end-to-end
- Protection from brute force attacks

### Non-Functional Requirements
- Login response < 500ms
- OWASP security compliance
- Works on mobile and desktop

---

## Organization & Discovery

**Priority**: P1-High
**Status**: Phase 3 Active (Search)
**Features**: FEAT-003 (Organizes User Ideas)

### What & Why
[...]
```

## Feature Structure

Features are **persistent product characteristics**:

```markdown
# FEAT-003: Organizes User Ideas

**product requirements Reference**: § "Organization & Discovery"
**Type**: Core Capability
**First Implemented**: 2025-01-15
**Last Reviewed**: 2025-10-05

## Product Vision

Users need to capture, organize, and rediscover ideas effortlessly. This feature ensures ideas never get lost.

## User Stories (Living Document)

As a user, I want to:
- Capture ideas quickly → Phase 1 ✅
- Organize into collections → Phase 2 ✅
- Find through search → Phase 3 🔄
- Get AI suggestions → Phase 4 ⏳
- Access on mobile → Phase 5 ⏳

## Implementation Phases

### Phase 1: MVP ✅ Complete (2025-01-15)
Goal: Basic idea capture
Tasks: TASK-010, TASK-011, TASK-012, TASK-013
Outcome: Users can capture and view ideas

### Phase 2: Collections ✅ Complete (2025-03-20)
Goal: Organize hierarchically
Tasks: TASK-030, TASK-031, TASK-032, TASK-033
Outcome: Collections working well

### Phase 3: Search 🔄 Active (50%)
Goal: Find ideas easily
Started: 2025-09-15, Target: 2025-11-15
Tasks: 12 total (8 complete, 4 pending)
Current: TASK-120 (Tag filtering)

### Phase 4: AI Assistance ⏳ Planned (Q1 2026)
Goal: Intelligent suggestions
Dependencies: Phase 3, ML infrastructure

### Phase 5: Mobile ⏳ Planned (Q2 2026)
Goal: Full mobile support
```

## Available Commands

### `/project-setup`

Initialize or verify project structure.

**Purpose**: First-time setup or verification of directory structure and core files.

**Process**:
1. Check for required directories (./docs/, ./docs/features/, ./docs/tasks/, ./docs/project/)
2. Check for core files (product_requirements.md, feature_index.md, task_index.md)
3. Create missing structure from templates
4. Optionally guide through first product requirements section and feature

**Usage**:
```bash
/project-setup

# Checks structure, creates missing files
# Guides through initial product requirements and feature creation
```

**When to Use**:
- Starting a new project
- Verifying structure is correct
- After cloning a project template

### `/project-whats-next`

Smart guidance on what to do next based on project state.

**Purpose**: Your navigation command - shows immediate actions, blockers, and recommendations.

**Analyzes**:
- Tasks in review (need human approval)
- Active tasks (continue working)
- Ready tasks (planned, can start)
- Features needing review (drift detection)
- Phases needing planning
- Overall project health

**Context-Aware Output**:
- New project: Suggests `/project-setup`
- Tasks in review: Prompts `/task-review`
- No active work: Suggests tasks to start
- Drift detected: Warns about features needing review
- All stable: Suggests next phases or new features

**Usage**:
```bash
/project-whats-next

# Shows personalized guidance with specific commands to run

/project-whats-next --brief
# Condensed summary only

/project-whats-next --focus tasks
# Only task-related suggestions

/project-whats-next --focus features
# Only feature-related suggestions
```

**Example Output**:
```
What's Next
===========

🔴 URGENT:
- TASK-120 in REVIEW for 3 days → /task-review TASK-120

🔄 IN PROGRESS:
- TASK-121: Date search → /task-implement TASK-121 --complete

✅ READY TO START:
- TASK-050: Password reset [P0] → /task-implement TASK-050

⚠️ NEEDS REVIEW:
- FEAT-003 not reviewed in 18 days → /feature-review FEAT-003

💡 RECOMMENDATION: Review TASK-120 to unblock work
```

### `/project-coverage`

Analyze traceability: product requirements → Features → Tasks → Implementation.

**Purpose**: Holistic view of what's covered, what's missing, and overall alignment.

**Checks**:
1. **product requirements Coverage**: Which sections have features
2. **Feature Coverage**: Which features have phases/tasks
3. **Implementation Status**: What's actually built
4. **Gaps**: product requirements sections with no features, features with no tasks
5. **Orphans**: Tasks not linked to features (reported but OK)
6. **Drift**: Features out of sync with product requirements

**Output**:
```
product requirements Coverage Analysis
=====================

§ User Authentication
  ✅ FEAT-001: Secures User Data (Phase 2/4)
     Stories aligned: 8/8 ✅
     Implementation: 50%

§ Organization & Discovery
  🔄 FEAT-003: Organizes User Ideas (Phase 3/5)
     Stories aligned: 12/15 ⚠️ (3 new stories)
     Implementation: 40%
     ⚠️ DRIFT: 3 stories added since planning
     → Run /feature-review FEAT-003

§ Collaboration
  ❌ NO FEATURES - Gap in coverage!

Orphan Tasks: 8 (OK - typos, quick fixes, etc.)

Recommendations:
  1. Review FEAT-003 (drift detected)
  2. Create feature for Collaboration section
  3. Run /feature-review on 2 features
```

**Usage**:
```bash
/project-coverage

# Full analysis

/project-coverage --gaps-only
# Only show missing coverage

/project-coverage --drift-only
# Only show alignment issues
```

### `/project-analyze-dependencies`

Analyze project dependencies for security, performance, and optimization.

**Purpose**: Keep dependencies healthy and up-to-date.

**Analyzes** (technology-specific):
- Outdated packages
- Security vulnerabilities
- Bundle size impact (JS/TS)
- Unused dependencies
- Upgrade recommendations

**Creates Tasks**: Can optionally create tasks for critical updates.

**Usage**:
```bash
/project-analyze-dependencies

# Analyzes and reports

/project-analyze-dependencies --create-tasks
# Creates P0 tasks for critical security updates
```

### `/project-generate-docs`

Generate documentation from codebase analysis.

**Purpose**: Keep documentation in sync with implementation.

**Can Generate**:
- API documentation from code
- Database schema docs
- Architecture diagrams
- Updated README sections

**Usage**:
```bash
/project-generate-docs

/project-generate-docs api
# Only API docs

/project-generate-docs schema
# Only database schema
```

## Feature Commands

### `/feature-create [name]`

Create a new persistent feature.

**Purpose**: Define a new product characteristic.

**Process**:
1. Infer product requirements section from name
2. Ask about initial phases
3. Create feature file with vision and user stories
4. Update feature_index.md

**Usage**:
```bash
/feature-create "Secures User Data"

# Guides through:
# - product requirements section linkage
# - Initial phase definition
# - User story capture
```

### `/feature-roadmap FEAT-XXX`

Manage phases and align to user stories.

**Purpose**: Plan, reorder, or add phases. Ensure all user stories assigned to phases.

**Process**:
1. Show current phases and user story assignment
2. Identify unassigned user stories
3. Allow adding/reordering phases
4. Check phase coherence and size

**Usage**:
```bash
/feature-roadmap FEAT-003

# Interactive:
# - Shows phase mapping
# - Finds unassigned stories
# - Suggests new phases
# - Checks dependencies
```

### `/feature-alignment FEAT-XXX`

Check and update alignment between product requirements, user stories, and implementation.

**Purpose**: Collaborative refinement - update stories, check product requirements alignment, verify implementation.

**Process**:
1. **product requirements Check**: Feature still aligned with product requirements section?
2. **Story Analysis**: New stories added? Removed? Modified?
3. **Acceptance Criteria**: Match current implementation?
4. **Roadmap Sync**: Are phases still right?

**Usage**:
```bash
/feature-alignment FEAT-003

# Interactive session:
# - Validates new user stories against product requirements
# - Updates acceptance criteria
# - Adjusts roadmap if needed
# - Creates missing tasks
```

### `/feature-review FEAT-XXX`

**Comprehensive health check with automatic drift detection.**

**Purpose**: The safety net - run periodically (every 2-4 weeks during active development).

**Checks**:
1. **product requirements Alignment**: Still matches product requirements section?
2. **User Story Drift**: Stories added/removed/modified?
3. **Implementation Status**: Do completed tasks match acceptance criteria?
4. **Roadmap Health**: Phases still coherent? Timeline realistic?
5. **Quality Gates**: Tests, performance, coverage OK?
6. **Dependencies**: Blockers identified?

**Output**: Health score, issues found, recommendations.

**Usage**:
```bash
/feature-review FEAT-003

# Comprehensive analysis:
# - Detects drift automatically
# - Flags quality issues
# - Checks dependencies
# - Recommends actions
```

### `/feature-phase-plan FEAT-XXX [phase]`

Plan tasks for a specific phase.

**Purpose**: Break phase down into concrete implementation tasks.

**Process**:
1. Read phase goals and acceptance criteria
2. Analyze codebase and architecture
3. Generate task breakdown
4. Create tasks with feature linkage
5. Update feature file with task references

**Usage**:
```bash
/feature-phase-plan FEAT-003 1

# AI analyzes phase and creates tasks
# All tasks tagged with #FEAT-003 #phase-1
```

### `/feature-phase-start FEAT-XXX [phase]`

Start working on a phase.

**Purpose**: Shortcut for planning phase + starting first task.

**Usage**:
```bash
/feature-phase-start FEAT-003 2

# Plans phase (if needed) and starts first task
```

### `/feature-phase-complete FEAT-XXX [phase]`

Mark phase as complete.

**Purpose**: Enforce quality gates before marking complete.

**Checks**:
- All acceptance criteria met?
- All tasks completed?
- Tests passing?
- Quality metrics met?

**Blocks if**: Quality gates fail.

**Usage**:
```bash
/feature-phase-complete FEAT-003 3

# Runs quality checks
# Marks complete if passing
# Archives phase, suggests next phase
```

### `/feature-list [filter]`

List all features with phase status.

**Usage**:
```bash
/feature-list

# Shows all features grouped by status

/feature-list active
# Only features with active phases

/feature-list stable
# Only stable features (no active work)
```

### `/feature-status FEAT-XXX`

Detailed status of a feature and all phases.

**Usage**:
```bash
/feature-status FEAT-003

# Shows:
# - Phase completion status
# - Current work
# - Timeline
# - product requirements alignment
# - Recommendations
```

## Workflow Examples

### Starting a New Project

```bash
# 1. Initialize
/project-setup

# 2. Define first product requirements section and feature
# (guided by /project-setup)

# 3. Plan feature roadmap
/feature-roadmap FEAT-001

# 4. Plan first phase
/feature-phase-plan FEAT-001 1

# 5. Start implementing
/task-implement TASK-001
```

### Daily Development Workflow

```bash
# Morning: Check what's next
/project-whats-next

# Work on suggested tasks
/task-implement TASK-120
# ... make changes ...
/task-implement TASK-120 --complete

# Review completed work
/task-review TASK-120 --approve

# Check what's next again
/project-whats-next
```

### Periodic Maintenance (Every 2-4 Weeks)

```bash
# Check overall health
/project-coverage

# Review active features
/feature-review FEAT-003
/feature-review FEAT-004

# Update product requirements if needed
# (edit ./docs/product_requirements.md)

# Re-align features to product requirements
/feature-alignment FEAT-003
```

### When Starting New Phase

```bash
# Complete current phase
/feature-phase-complete FEAT-003 3

# Plan next phase
/feature-phase-plan FEAT-003 4

# Or check what to do
/project-whats-next
```

### When Requirements Change

```bash
# Update product requirements section
# (edit ./docs/product_requirements.md)

# Realign feature
/feature-alignment FEAT-003

# May create new tasks or adjust roadmap

# Verify coverage
/project-coverage
```

## Integration Between Systems

### product requirements → Features

- product requirements sections describe **what** the product should do
- Features describe **how** the product achieves those capabilities
- One product requirements section can inform multiple features
- Features reference product requirements sections: `**product requirements Reference**: § "User Authentication"`

### Features → Tasks

- Features **plan** tasks via `/feature-phase-plan`
- Tasks **link back** via tags: `#FEAT-003`
- Tasks can be **orphans** (not linked to features) - this is OK

### Tasks → Implementation

- Tasks describe discrete work with completion criteria
- Implementation notes track what was actually done
- Completed tasks feed back into feature status

### Traceability Chain

```
product requirements § "Organization"
    ↓
FEAT-003: Organizes User Ideas
    ↓
Phase 3: Search
    ↓
TASK-120: Tag filtering
    ↓
Code: search.py:145-230
```

Can trace: Code → Task → Feature → product requirements section

## Command Prefixes

All commands follow consistent prefixing:

- **`/project-*`**: Cross-cutting, whole project operations
- **`/feature-*`**: Feature-level operations (persistent characteristics)
- **`/task-*`**: Task-level operations (discrete work items)

## Best Practices

### For product requirements

1. **Keep sections focused** - One capability per section
2. **Update regularly** - product requirements evolves with product understanding
3. **Link features** - Always reference which features cover each section
4. **No numbered requirements** - Section names are enough
5. **Describe user needs** - Focus on "what" and "why", not "how"

### For Features

1. **Name for characteristics** - "Secures Data", not "Build Auth System"
2. **Review regularly** - Every 2-4 weeks during active development
3. **Embrace evolution** - User stories will be added/refined
4. **Keep phases focused** - 4-12 tasks per phase is good
5. **Run `/feature-review`** - Your alignment safety net

### For Tasks

6. **Orphans are OK** - Not everything needs a feature
7. **Link when relevant** - Use `#FEAT-XXX` tags for traceability
8. **Be specific** - Clear acceptance criteria
9. **One task at a time** - Maintain focus

### For Project Health

10. **Use `/project-whats-next`** - Your navigation command
11. **Run `/project-coverage`** - Monthly health check
12. **Don't skip reviews** - Drift happens, catch it early
13. **Update product requirements as you learn** - It's a living document
14. **Traceability over rigidity** - Practical, not dogmatic

## Troubleshooting

**"product requirements is getting too large"**
- Good! That means product is complex
- Keep sections focused and well-organized
- Consider splitting into multiple docs if needed

**"Feature has too many phases"**
- Features can have 5-10+ phases over years
- This is natural evolution
- Keep completed phases for history

**"Lost track of what's implemented"**
- Run `/feature-status FEAT-XXX` for specific feature
- Run `/project-coverage` for full picture
- Check task_index.md for recent completions

**"Not sure if feature aligns with product requirements"**
- Run `/feature-review FEAT-XXX`
- Automatically checks alignment
- Provides specific recommendations

**"Too many orphan tasks"**
- This is actually OK!
- Not everything needs feature alignment
- Quick fixes, typos, etc. should be orphans

**"Feature drifted during development"**
- Normal! Requirements evolve
- Run `/feature-review` to detect drift
- Use `/feature-alignment` to sync
- Update product requirements if product understanding changed

## Summary

**The system enables**:
- ✅ Clear traceability: product requirements → Features → Tasks → Code
- ✅ Persistent features that evolve over time
- ✅ Practical approach (orphan tasks OK)
- ✅ Continuous alignment checking
- ✅ Natural development workflow
- ✅ Smart guidance (`/project-whats-next`)

**Key insight**: Features are **what the product IS**, not what you're building. They persist and evolve as your product matures.

**Navigate with**: `/project-whats-next` - Your compass in the system.
