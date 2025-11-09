# Feature Management System

## Overview

The feature management system organizes persistent product characteristics and ensures alignment between product requirements vision, user stories, and implementation. Features describe what the product IS, not temporary work items.

## Core Philosophy

### Features Are Persistent

**Features never "complete"** - they describe enduring product characteristics:
- ❌ **Not**: "Add user authentication" (temporary work)
- ✅ **Yes**: "Secures User Data" (persistent characteristic)

**Examples of persistent features**:
- FEAT-001: Secures User Data
- FEAT-003: Organizes User Ideas
- FEAT-007: Provides Smart Recommendations
- FEAT-012: Enables Team Collaboration

### Features Are Aspirational

Features describe the ideal state, refined over time through phases:
- **Phase 1**: MVP implementation (basic capability)
- **Phase 2**: Enhancement (more robust)
- **Phase 3**: Advanced features (richer experience)
- **Phase N**: Continuous evolution

### Features Are Few

Typical projects have **5-15 core features**:
- Too few (2-3): Not enough structure
- Too many (30+): Not high-level enough
- Sweet spot: 8-12 for most products

### Phases Manage Implementation

**Phases accumulate over product lifetime**:
- Features cycle: STABLE ↔ ACTIVE
- STABLE: No current work, mature implementation
- ACTIVE: Phase in progress

## File Structure

```
./docs/features/                     # Feature documentation directory
./docs/features/FEAT-XXX-*.md        # Individual feature documents
./docs/features/feature_index.md     # Lightweight index of all features
./docs/product_requirements.md                        # Product Requirements Document (sections, no numbering)
```

## Feature States

Features cycle between two states:

**STABLE**: No active work
- Implementation exists and is mature
- May have planned future phases
- Enters ACTIVE when phase starts

**ACTIVE**: Phase in progress
- Current phase being implemented
- Tasks actively being worked on
- Returns to STABLE when phase completes

**No "COMPLETED" state** - features are persistent product characteristics.

## Feature ID Format

Features use the format: `FEAT-XXX` where XXX is a sequential number (e.g., FEAT-001, FEAT-003, FEAT-042)

Files are named: `FEAT-XXX-kebab-case-characteristic.md`

Example: `FEAT-003-organizes-user-ideas.md`

## Priority Levels

Features inherit priority from product requirements sections or set independently:
- **P0-Critical**: Core product value, essential capability
- **P1-High**: Important differentiator or major user need
- **P2-Medium**: Enhances experience, not essential
- **P3-Low**: Nice-to-have, future consideration

## Feature Document Structure

```markdown
# FEAT-XXX: [Persistent Characteristic Name]

**product requirements Reference**: § "Section Name"
**Type**: Core Capability | Enhancement | Integration | Infrastructure
**First Implemented**: YYYY-MM-DD (Phase 1 completion)
**Last Updated**: YYYY-MM-DD
**Last Reviewed**: YYYY-MM-DD

## Product Vision

[What this feature means for the product - the ideal state]

## User Stories (Living Document)

As a user, I want to:
- [User story 1] → Phase 1 ✅
- [User story 2] → Phase 2 ✅
- [User story 3] → Phase 3 🔄 (Active)
- [User story 4] → Phase 4 ⏳ (Planned)
- [User story 5] → Phase 5 💡 (Future)

**Note**: User stories evolve during implementation - alignment maintained via `/feature-alignment`.

## Implementation Phases

### Phase 1: [Phase Name] ✅ Complete (YYYY-MM-DD)

**Goal**: [What this phase accomplished]

**User Stories Addressed**:
- [Story from above]

**Tasks**: TASK-XXX, TASK-YYY, TASK-ZZZ

**Outcome**: [What users can now do]

### Phase 2: [Phase Name] ✅ Complete (YYYY-MM-DD)

**Goal**: [What this phase accomplished]

**User Stories Addressed**:
- [Story from above]

**Tasks**: TASK-AAA, TASK-BBB, TASK-CCC

**Outcome**: [Enhanced capability]

### Phase 3: [Phase Name] 🔄 Active (XX% complete)

**Goal**: [What this phase will accomplish]

**Status**: ACTIVE
**Started**: YYYY-MM-DD
**Target Completion**: YYYY-MM-DD

**User Stories Addressed**:
- [Story from above]

**Tasks**:
- Total: 12
- Completed: 8 (TASK-120, TASK-121, ...)
- In Progress: 2 (TASK-135, TASK-136)
- Pending: 2 (TASK-140, TASK-141)

**Current Work**: TASK-135 (Implement tag filtering)

### Phase 4: [Phase Name] ⏳ Planned (Target: QXXX)

**Goal**: [What this phase will accomplish]

**User Stories Addressed**:
- [Story from above]

**Estimated Effort**: X weeks/months

**Dependencies**:
- Phase 3 completion
- External API availability

### Phase 5: [Phase Name] 💡 Future Exploration

**Goal**: [Aspirational capability]

**User Stories Addressed**:
- [Future story]

**Notes**: Depends on user feedback from Phases 3-4

## Technical Architecture

### Current Implementation

[High-level technical approach for implemented phases]

**Components**:
- Component 1: [description]
- Component 2: [description]

**API Endpoints** (if applicable):
- `GET /api/resource` - [description]
- `POST /api/resource` - [description]

**Database Schema** (if applicable):
[Key tables and relationships]

### Planned Evolution

[How architecture will evolve in future phases]

## Review History

### YYYY-MM-DD - Phase X Review

**Alignment Status**: ✅ Aligned | ⚠️ Minor Drift | ❌ Major Drift

**Findings**:
- [Finding 1]
- [Finding 2]

**Actions Taken**:
- [Action 1]
- [Action 2]

### YYYY-MM-DD - Feature Review

**Comprehensive review via `/feature-review`**

**Status**: STABLE
**Phases Completed**: 1, 2
**Next Phase**: 3 (planned for Q2)

**Notes**: Feature functioning well, user satisfaction high

## Notes

[Additional context, architectural decisions, learnings across phases]
```

## product requirements Integration

### product requirements Structure (No Numbered Requirements)

Features link directly to product requirements sections:

```markdown
# Product Requirements Document

**Last Updated**: YYYY-MM-DD

## User Authentication

**Priority**: P0-Critical
**Status**: Phase 1 Complete, Phase 2 In Progress
**Features**: FEAT-001 (Secures User Data)

### What & Why

Users need secure authentication to protect their data and personalize their experience.

### User Needs

- Secure login without friction
- Multiple authentication options
- Password recovery
- Session management

### Acceptance Criteria

- Users can register and login
- Sessions managed securely
- Password reset works end-to-end
- OAuth integration (Google, GitHub)

### Non-Functional Requirements

- Login response < 500ms
- OWASP security compliance
- Accessibility (WCAG 2.1 AA)
```

### Traceability

```
product requirements Section → Feature → Phases → Tasks → Implementation

Example:
§ "User Authentication"
  ↓
FEAT-001: Secures User Data
  ↓
Phase 1: Basic Auth ✅
Phase 2: OAuth 🔄
  ↓
TASK-045: Implement OAuth flow
  ↓
src/auth/oauth.py (implementation)
```

## Available Commands

### `/feature-create [name]`

Create a new persistent feature.

**Parameters**:
- `name`: Characteristic name (e.g., "Secures User Data", "Organizes Ideas")

**Process**:
1. Analyze project context and product requirements
2. Generate next available FEAT-XXX ID
3. Ask clarifying questions:
   - Which product requirements section does this relate to?
   - What's the ideal state for this characteristic?
   - What are the initial user stories?
   - What's the MVP (Phase 1) scope?
4. Create feature file in ./docs/features/
5. Set initial state to STABLE (no active work yet)
6. Add to feature_index.md
7. Suggest running `/feature-phase-plan FEAT-XXX 1` to plan Phase 1

**Example**:
```
/feature-create "Organizes User Ideas"
```

**Output**:
```
Created: FEAT-003: Organizes User Ideas
product requirements Reference: § "Organization & Discovery"
State: STABLE (no active work)
File: ./docs/features/FEAT-003-organizes-user-ideas.md

Next steps:
- Review feature document
- Run `/feature-phase-plan FEAT-003 1` to plan Phase 1 (MVP)
```

**Notes**:
- Feature name should describe persistent characteristic
- Initial creation doesn't start implementation
- Use `/feature-phase-plan` to begin work

### `/feature-list [filter]`

Show all features and their current status.

**Parameters**:
- `filter`: (Optional) State/type filter
  - `active`: Features with active phases
  - `stable`: Features with no active work
  - `p0` / `p1` / `p2` / `p3`: By priority

**Display Format**:
```
FEATURES (Total: 12, Active: 3, Stable: 9)
===========================================

🔄 ACTIVE (3 features)

FEAT-003: Organizes User Ideas [ACTIVE - Phase 3]
  product requirements: § "Organization & Discovery"
  Priority: P1-High
  Progress: Phase 3 (50% - 8/12 tasks done)
  Current: TASK-135 (Tag filtering)

FEAT-001: Secures User Data [ACTIVE - Phase 2]
  product requirements: § "User Authentication"
  Priority: P0-Critical
  Progress: Phase 2 (75% - 6/8 tasks done)

FEAT-007: Provides Smart Recommendations [ACTIVE - Phase 1]
  product requirements: § "AI Features"
  Priority: P2-Medium
  Progress: Phase 1 (25% - 2/8 tasks done)

✅ STABLE (9 features)

FEAT-002: Manages User Profile [4 phases complete]
  product requirements: § "User Management"
  Last Updated: 2025-09-15

FEAT-004: Enables Collaboration [2 phases complete]
  product requirements: § "Team Features"
  Last Updated: 2025-08-20

[... 7 more stable features ...]

💡 Summary:
- 3 features actively being improved
- 9 features in stable state
- Next review: FEAT-001 (due 2025-10-20)
```

**Examples**:
```
/feature-list              # Show all features
/feature-list active       # Show features with active phases
/feature-list p0           # Show critical features
```

### `/feature-status FEAT-XXX`

Show detailed status for a specific feature.

**Parameters**:
- `FEAT-XXX`: Feature ID

**Display**:
```
FEAT-003: Organizes User Ideas
===============================

product requirements Reference: § "Organization & Discovery"
Type: Core Capability
State: ACTIVE (Phase 3 in progress)
Priority: P1-High

Phase History:
  Phase 1: MVP ✅ Complete (2025-01-15) - 8 tasks
  Phase 2: Collections ✅ Complete (2025-03-20) - 12 tasks
  Phase 3: Search 🔄 Active (50%) - 8/12 tasks done
  Phase 4: AI Assistance ⏳ Planned (Q1 2026)
  Phase 5: Mobile ⏳ Planned (Q2 2026)

Current Phase 3 Tasks:
  ✅ TASK-120: Basic search (completed 2025-09-10)
  ✅ TASK-121: Search indexing (completed 2025-09-12)
  🔄 TASK-135: Tag filtering (in progress)
  ⏳ TASK-140: Advanced queries (pending)

Last Review: 2025-09-01
Alignment Status: ✅ Aligned

User Stories Implemented:
  ✅ Capture ideas quickly (Phase 1)
  ✅ Organize into collections (Phase 2)
  🔄 Find through search (Phase 3 - partial)
  ⏳ Get AI suggestions (Phase 4)
  ⏳ Access on mobile (Phase 5)

Next Actions:
  - Complete TASK-135 (tag filtering)
  - Start TASK-140 (advanced queries)
  - Run `/feature-review FEAT-003` when Phase 3 done
```

**Example**:
```
/feature-status FEAT-003
```

### `/feature-phase-plan FEAT-XXX [phase-number]`

Plan tasks for a specific phase.

**Parameters**:
- `FEAT-XXX`: Feature ID
- `phase-number`: Phase to plan (e.g., 1, 2, 3)

**Process**:
1. Read feature document and product requirements reference
2. Analyze user stories for this phase
3. Review current codebase and architecture
4. Ask clarifying questions:
   - Maintain backward compatibility?
   - Performance targets?
   - Testing strategy?
5. Generate task breakdown
6. Create tasks with #FEAT-XXX tags
7. Link tasks to feature document
8. Update feature with task list

**Example**:
```
/feature-phase-plan FEAT-003 3
```

**Output**:
```
Planning Phase 3 for FEAT-003: Organizes User Ideas

User Stories for Phase 3:
  - Find ideas through search
  - Filter by tags
  - Sort by relevance/date

Clarifying Questions:
  1. Use existing search library or build custom?
  2. Real-time indexing or batch?
  3. Search scope: title only or full content?

[After user answers...]

Created 12 tasks for Phase 3:
  TASK-120: Implement search indexing [P1] #backend #FEAT-003
  TASK-121: Create search API endpoint [P1] #api #FEAT-003
  TASK-122: Build search UI component [P1] #frontend #FEAT-003
  ...

Updated FEAT-003 with Phase 3 task list.

Next: Run `/feature-phase-start FEAT-003 3` to begin implementation.
```

### `/feature-phase-start FEAT-XXX [phase-number]`

Start working on a phase (moves feature to ACTIVE).

**Parameters**:
- `FEAT-XXX`: Feature ID
- `phase-number`: Phase to start

**Prerequisites**:
- Phase must have task plan (via `/feature-phase-plan`)
- Previous phases should be complete (warning if not)

**Process**:
1. Check prerequisites
2. Update feature state to ACTIVE
3. Update feature_index.md
4. Mark phase status as 🔄 Active
5. Show first tasks to work on

**Example**:
```
/feature-phase-start FEAT-003 3
```

**Output**:
```
Started Phase 3 for FEAT-003: Organizes User Ideas

Feature state: STABLE → ACTIVE
Current phase: Phase 3 (Search)
Total tasks: 12

Ready to implement:
  TASK-120: Implement search indexing [P1] [READY]
  TASK-121: Create search API endpoint [P1] [READY]

Next actions:
  - Run `/task-implement TASK-120` to start first task
  - Track progress with `/feature-status FEAT-003`
```

### `/feature-phase-complete FEAT-XXX [phase-number]`

Complete a phase (with quality gates).

**Parameters**:
- `FEAT-XXX`: Feature ID
- `phase-number`: Phase to complete

**Prerequisites**:
- All phase tasks must be COMPLETED
- Tests passing
- Documentation updated

**Quality Gates**:
1. **Task Completion**: All phase tasks in COMPLETED state
2. **Code Review**: Implementation matches design
3. **Testing**: Tests written and passing
4. **Documentation**: User-facing docs updated
5. **Alignment**: User stories still match implementation

**Process**:
1. Verify all phase tasks complete
2. Run code quality checks
3. Check test coverage
4. Review documentation
5. Check product requirements alignment (via `/feature-alignment`)
6. Mark phase as ✅ Complete
7. Ask: Continue to next phase or return to STABLE?

**Example**:
```
/feature-phase-complete FEAT-003 3
```

**Output**:
```
Completing Phase 3 for FEAT-003: Organizes User Ideas

Quality Gates:
  ✅ All tasks complete (12/12)
  ✅ Tests passing (94% coverage)
  ✅ Documentation updated
  ⚠️  Minor alignment drift detected

Alignment Issues:
  - User story "Filter by date range" added during implementation
  - Not in original Phase 3 plan

Action: Update feature user stories? [y/n]

[After user confirms...]

Phase 3 marked complete ✅
Completion date: 2025-10-06

Next phase options:
  - Phase 4: AI Assistance (planned Q1 2026)
  - Return to STABLE state

Continue to Phase 4 now? [y/n]
```

### `/feature-roadmap FEAT-XXX`

Manage phases and align user stories.

**Parameters**:
- `FEAT-XXX`: Feature ID

**Process**:
1. Show all phases (complete, active, planned)
2. Review user stories and their phase mapping
3. Identify gaps (stories without phases)
4. Suggest phase reorganization if needed
5. Update phase targets and estimates
6. Interactive refinement with user

**Example**:
```
/feature-roadmap FEAT-003
```

**Output**:
```
Roadmap for FEAT-003: Organizes User Ideas

User Stories → Phases:
  ✅ Capture ideas quickly → Phase 1 (complete)
  ✅ Organize into collections → Phase 2 (complete)
  🔄 Find through search → Phase 3 (active, 50%)
  ⏳ Get AI suggestions → Phase 4 (planned Q1 2026)
  ⏳ Access on mobile → Phase 5 (planned Q2 2026)
  ❌ Share with team → No phase assigned

Issues:
  - "Share with team" story has no phase
  - Phase 4 dependencies unclear

Suggestions:
  1. Add Phase 6 for collaboration features?
  2. Split Phase 4 into 4a (basic AI) and 4b (advanced)?

Modify roadmap? [y/n]
```

**Notes**:
- Run periodically as user stories evolve
- Helps maintain long-term vision
- Identifies planning gaps

### `/feature-alignment FEAT-XXX`

Check and update product requirements/story/implementation alignment.

**Parameters**:
- `FEAT-XXX`: Feature ID

**Process**:
1. Read product requirements section referenced by feature
2. Read current feature user stories
3. Analyze implemented code and completed tasks
4. Identify alignment issues:
   - product requirements changed but feature didn't
   - User stories added during implementation
   - Features no longer match product requirements section
   - Implementation drift from stories
5. Interactive refinement:
   - Update user stories to match implementation?
   - Update product requirements to reflect reality?
   - Mark implementation as drift to be fixed?
6. Update feature document with alignment status
7. Record alignment review in Review History

**Example**:
```
/feature-alignment FEAT-003
```

**Output**:
```
Alignment Check for FEAT-003: Organizes User Ideas

product requirements Section: § "Organization & Discovery"
Last product requirements Update: 2025-08-15
Last Feature Review: 2025-09-01

Alignment Analysis:

✅ Aligned:
  - "Capture ideas quickly" - matches product requirements and implementation
  - "Organize into collections" - matches product requirements and implementation

⚠️ Minor Drift:
  - User story: "Filter by date range" (added during Phase 3)
    product requirements mentions: "Find ideas easily"
    Implementation: Date filtering exists
    Issue: More specific than product requirements

  - User story: "Search by tag"
    product requirements mentions: "Categorize ideas"
    Implementation: Tag system exists
    Issue: product requirements uses different terminology

❌ Major Drift:
  - None detected

Recommendations:
  1. Update product requirements § "Organization & Discovery" to include:
     - Specific mention of date filtering
     - Clarify "categorize" includes tagging
  2. Or: Mark user stories as implementation details
  3. Or: Merge similar concepts in next product requirements review

Action: Update product requirements, feature, or mark as acceptable drift? [product requirements/feature/accept]
```

**When to run**:
- After completing each phase
- When user stories change during implementation
- Before major releases
- When product requirements is updated

### `/feature-review FEAT-XXX|all`

Comprehensive feature review with drift detection (safety net).

**Parameters**:
- `FEAT-XXX`: Specific feature ID
- `all`: Review all features

**Review Checks**:

1. **product requirements Alignment**:
   - Feature still matches referenced product requirements section
   - product requirements section hasn't been removed/changed
   - User stories align with product requirements requirements

2. **Phase Consistency**:
   - Active phases have in-progress tasks
   - Completed phases have all tasks done
   - Planned phases have effort estimates
   - No orphaned phases

3. **Implementation Verification**:
   - Completed tasks have actual code
   - Code matches user stories
   - Tests exist and pass
   - Documentation reflects implementation

4. **User Story Coverage**:
   - All user stories mapped to phases
   - No unimplemented stories without plan
   - No implemented features without stories
   - Stories still reflect user needs

5. **Drift Detection**:
   - Implementation beyond user stories
   - User stories beyond product requirements
   - Code without task/story linkage
   - Stale or abandoned phases

**Output**:
```
Comprehensive Review: FEAT-003: Organizes User Ideas
======================================================

Last Review: 2025-09-01 (35 days ago)

✅ product requirements Alignment: Strong
  - product requirements § "Organization & Discovery" matches feature vision
  - No product requirements changes since last review

⚠️ Phase Consistency: Minor Issues
  - Phase 3 active but 4 tasks stale (no updates in 20+ days)
  - Phase 4 planned but no effort estimate

✅ Implementation Verification: Excellent
  - All completed tasks have code
  - Test coverage: 94%
  - Documentation up to date

⚠️ User Story Coverage: Drift Detected
  - "Share with team" story added but no phase assigned
  - "Date filtering" implemented but not in original stories

❌ Drift Detection: Issues Found
  - src/ideas/sharing.py (120 lines) - no related task/story
  - TASK-155 references FEAT-003 but not in feature document
  - Phase 3 Target: 2025-09-30 (missed by 6 days)

Recommendations:
  1. Update user stories to include sharing and date filtering
  2. Create Phase 6 for collaboration (sharing feature)
  3. Add TASK-155 to feature document or remove FEAT-003 tag
  4. Revise Phase 3 target to 2025-10-15
  5. Update Phase 4 with effort estimate

Actions:
  - Run `/feature-roadmap FEAT-003` to organize phases
  - Run `/feature-alignment FEAT-003` for detailed alignment
  - Update stale tasks or mark blocked

Next Review: 2025-11-05 (30 days)
```

**When to run**:
- Every 2-4 weeks for active features
- Before major releases
- When feeling "lost" in implementation
- After significant product requirements changes
- As safety net to catch drift

**Notes**:
- Most comprehensive check
- Combines alignment + roadmap + implementation
- Safety net that catches what daily workflow misses
- Should remind but not block work

## Workflow Examples

### Example 1: Create New Feature

```bash
# Create persistent feature
/feature-create "Secures User Data"

# AI asks:
# - Which product requirements section? → § "User Authentication"
# - Ideal state? → "Users trust their data is protected"
# - Initial user stories? → "Login securely", "Manage sessions", "Reset password"
# - Phase 1 MVP? → "Basic email/password auth"

# Created: FEAT-001: Secures User Data

# Plan Phase 1
/feature-phase-plan FEAT-001 1

# AI analyzes product requirements, asks:
# - Use existing auth library? → Yes, use Authlib
# - OAuth in Phase 1? → No, Phase 2
# - Password requirements? → OWASP standards

# Created 8 tasks for Phase 1

# Start Phase 1
/feature-phase-start FEAT-001 1

# Feature state: STABLE → ACTIVE

# Implement tasks
/task-implement TASK-001  # User model
/task-implement TASK-002  # Auth endpoints
# ... implement all tasks

# Complete Phase 1
/feature-phase-complete FEAT-001 1

# Quality gates pass ✅
# Mark Phase 1 complete
# Feature state: ACTIVE → STABLE (user chooses not to continue)
```

### Example 2: Continue Existing Feature

```bash
# Check feature status
/feature-status FEAT-003

# Shows Phase 2 complete, Phase 3 planned

# Plan Phase 3
/feature-phase-plan FEAT-003 3

# Start Phase 3
/feature-phase-start FEAT-003 3

# Implement tasks...

# During implementation, user story evolves
# Add "date filtering" not in original plan

# Before completing phase, check alignment
/feature-alignment FEAT-003

# AI detects drift: "date filtering" not in product requirements or original stories
# Options: Update feature stories, update product requirements, or mark as acceptable detail

# User: Update feature stories (implementation detail, acceptable)

# Complete Phase 3
/feature-phase-complete FEAT-003 3

# Quality gates check alignment ✅
# Phase marked complete
# Return to STABLE
```

### Example 3: Periodic Review (Safety Net)

```bash
# Monthly comprehensive review
/feature-review all

# AI checks all features for drift

# FEAT-003: ⚠️ Drift detected
#   - src/ideas/sharing.py exists but no story/task
#   - "Share with team" story added but no phase
#   - Phase 3 target missed by 6 days

# Fix issues
/feature-roadmap FEAT-003
# Add Phase 6 for collaboration
# Assign "Share with team" to Phase 6

/feature-alignment FEAT-003
# Update product requirements § "Organization & Discovery" to mention sharing
# Or: Add user story to feature
# Record sharing.py as prototype for Phase 6

# Next time: Drift caught and corrected ✅
```

## Integration with Tasks

### Task → Feature Linkage (Optional)

Tasks MAY link to features via tags:
```markdown
**Tags**: #backend #feature #FEAT-003
```

### Orphan Tasks Are OK

Not everything needs feature alignment:
```markdown
TASK-999: Fix typo in README.md [P3]
Tags: #docs

(No #FEAT-XXX tag - and that's fine!)
```

### Feature → Task Linkage

Features list tasks in phase sections:
```markdown
### Phase 3: Search 🔄 Active (50%)

**Tasks**:
- Total: 12
- Completed: 8 (TASK-120, TASK-121, TASK-122, ...)
- In Progress: 2 (TASK-135, TASK-136)
- Pending: 2 (TASK-140, TASK-141)
```

## Integration with product requirements

### product requirements Reference Format

Features link to sections (no numbered requirements):
```markdown
**product requirements Reference**: § "User Authentication"
```

### product requirements Section Format

product requirements sections reference features:
```markdown
## User Authentication

**Priority**: P0-Critical
**Features**: FEAT-001 (Secures User Data)
```

### Traceability Flow

```
product requirements Section
  ↓ (informs vision)
Feature (persistent characteristic)
  ↓ (breaks into phases)
Phase N (manageable scope)
  ↓ (plans implementation)
Tasks (discrete work)
  ↓ (creates)
Implementation (code, tests, docs)
```

## Best Practices

1. **Name features as characteristics** - "Secures Data" not "Add Security"
2. **Keep features few** - 5-15 for most projects
3. **Accept user story evolution** - Stories refined during implementation
4. **Use alignment checks** - Run `/feature-alignment` after each phase
5. **Review periodically** - `/feature-review all` every 2-4 weeks as safety net
6. **Allow orphan tasks** - Quick fixes don't need feature alignment
7. **Document phases clearly** - Each phase should have clear goal and outcome
8. **Maintain roadmap** - Use `/feature-roadmap` to keep vision aligned
9. **Trust the safety net** - `/feature-review` catches drift even if you forget
10. **One phase at a time** - Complete before planning next

## Troubleshooting

**Feature feels too big?**
- Features should be big - they're persistent
- Break work into smaller phases, not smaller features
- Phase 1 should be achievable MVP

**User stories changed during implementation?**
- This is normal and expected
- Run `/feature-alignment` to update
- Update product requirements or feature document to reflect reality
- Record changes in Review History

**Not sure which tasks belong to feature?**
- Use #FEAT-XXX tags for clarity
- But orphan tasks are fine
- Quick fixes don't need feature alignment

**Feature and product requirements out of sync?**
- Run `/feature-alignment` to detect drift
- Update product requirements or feature (whichever is outdated)
- Record in Review History why they diverged

**Forgot to review for weeks?**
- Run `/feature-review all` as safety net
- Will catch accumulated drift
- Fix issues and resume work
- Set reminder to review every 2-4 weeks

**Too many phases planned?**
- Keep next 1-2 phases detailed
- Keep future phases high-level
- Use 💡 Future Exploration for distant ideas
- Refine phases as you get closer

**Phase taking too long?**
- Break into sub-phases (3a, 3b)
- Or: Reduce scope, move stories to next phase
- Update roadmap with `/feature-roadmap`
- Adjust target dates realistically
