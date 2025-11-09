# Task Management System

## Overview

The task management system provides structured tracking for all development work, ensuring visibility, traceability, and human review before implementation.

## Philosophy

- **Quick Capture, Deep Planning**: Create tasks quickly when ideas strike, elaborate them properly before implementation
- **AI-Assisted Planning**: Use AI to analyze context, build implementation plans, and clarify ambiguities
- **Two Quality Gates**: Human approval at planning (task-ready) and completion (task-review)
- **Requirements Traceability**: Tasks map to features and requirements documents
- **Clear Visibility**: Track progress through defined states and acceptance criteria
- **Enforced Workflow**: State transitions ensure proper planning and review

## File Structure

```
./docs/tasks/task_index.md      # Lightweight index/dashboard of all tasks
./docs/tasks/TASK-XXX-*.md      # Individual task files (one file per task)
./docs/tasks/archive/           # Archived completed task files
```

**Why one file per task?**
- Tasks contain extensive information (context, implementation notes, test results)
- Large centralized files become unwieldy (2000+ lines)
- Git-friendly: changes to one task don't conflict with changes to another
- Better navigation: index for overview, click through for details
- Scalable: works equally well with 10 or 1000 tasks
- Rich documentation: no limits on task detail

## Task Lifecycle

Tasks move through these states:

1. **TODO** - Idea captured, needs planning and elaboration
2. **READY** - Fully planned with implementation roadmap, ready to code
3. **IN PROGRESS** - Being actively worked on
4. **REVIEW** - Implementation complete, needs verification
5. **COMPLETED** - Verified and moved to ./docs/tasks/archive/

### Lifecycle Diagram

```
/task-create (quick capture)
    ↓
[TODO] ─────────────────────────────────────┐
    ↓ /task-ready                           │
    │ • Analyze context & code              │
    │ • Build implementation plan           │
    │ • Clarify ambiguities                 │
    │ • Human approval required             │
    ↓                                        │
[READY] ────────────────────────────────────┤
    ↓ /task-implement                       │
    │ • Follow implementation plan          │
    │ • Update task file with progress      │
    ↓                                        │ /task-delete
[IN PROGRESS] ←─────┐                       │ (anytime)
    ↓               │                       │
    │ /task-implement --complete            │
    ↓               │                       │
[REVIEW] ───────────┤                       │
    ↓               │ /task-review          │
    │               │ --request-changes     │
    │ /task-review --approve                │
    ↓                                        │
[COMPLETED] ─────────────────────────────────┘
    ↓ (automatic)
[ARCHIVED in ./docs/tasks/archive/]
```

### State Transition Rules

**Enforced Transitions** (commands will block if not in correct state):
- `TODO → READY`: Only via `/task-ready` (planning required)
- `READY → IN PROGRESS`: Only via `/task-implement` (enforces planning)
- `IN PROGRESS → REVIEW`: Only via `/task-implement --complete`
- `REVIEW → COMPLETED`: Only via `/task-review --approve`
- `REVIEW → IN PROGRESS`: Only via `/task-review --request-changes`

**Flexible Transitions**:
- Any state → `TODO`: Via `/task-reset` (restart planning)
- Any state (except COMPLETED) → deleted: Via `/task-delete`

## Task ID Format

Tasks use the format: `TASK-XXX` where XXX is a sequential number (e.g., TASK-001, TASK-042, TASK-220)

Files are named: `TASK-XXX-slug.md` (e.g., TASK-042-fix-auth-bug.md)

## Priority Levels

- **P0-Critical**: Blocking issues, must be done immediately
- **P1-High**: Important features/fixes, high priority
- **P2-Medium**: Normal priority work
- **P3-Low**: Nice-to-have, future work

## Quality Gates

**Two Human Approval Points** (enforced by state transitions):

### Gate 1: Planning Approval (`/task-ready`)
- AI analyzes project context, source code, and documentation
- Builds comprehensive implementation plan with phases
- Asks clarifying questions to resolve ambiguities
- **Human reviews and approves plan** before task becomes READY
- Prevents poorly-defined tasks from entering implementation

### Gate 2: Completion Approval (`/task-review`)
- AI reviews implementation against acceptance criteria
- Checks code quality, tests, documentation
- Generates review report with findings
- **Human verifies work and decides**: approve, request changes, or add notes
- Prevents incomplete work from being marked complete

## Task Index Format

Lightweight, scannable index in ./docs/tasks/task_index.md:

```markdown
# Task Index

**Last Updated**: 2025-10-05

## Need Planning (TODO)

- TASK-233: Review Storage Location [P3] [TODO] #infrastructure #tech-debt
- TASK-234: Knowledge Management System [P1] [TODO] #docs #feature #FEAT-023
- TASK-235: Implement caching layer [P2] [TODO] #backend #performance

## Ready to Implement (READY)

- TASK-238: Enhanced Gallery Widget [P1] [READY] #frontend #feature #FEAT-042
- TASK-239: Product Viewer Modal [P1] [READY] #frontend #ui #FEAT-042
- TASK-240: Product Lifecycle Operations [P1] [READY] #backend #feature

## In Progress

- TASK-237: Product Database Schema [P1] [IN PROGRESS] #database #migration

## In Review

- TASK-236: Disable Safety Checker [P2] [REVIEW] #ml #config

## Blocked

- TASK-241: Deploy new schema [P0] [BLOCKED: TASK-237] #deployment #database

## Recently Completed (Last 5)

- TASK-235B: Update Implementation Docs [P2] - 2025-10-04 #docs
- TASK-236: Disable Safety Checker [P2] - 2025-10-04 #ml #config
- TASK-237: Product Database Schema [P1] - 2025-10-04 #database #migration
```

### Task Line Format

Each task line follows this format:
```
TASK-XXX: Title [Priority] [Status] #tags [Blocker]
```

**Components**:
- **TASK-XXX**: Task ID
- **Title**: Short descriptive title
- **[Priority]**: P0-Critical, P1-High, P2-Medium, P3-Low
- **[Status]**: TODO, READY, IN PROGRESS, REVIEW, COMPLETED, BLOCKED
- **#tags**: Space-separated tags for filtering/scanning
- **[Blocker]**: Optional, only for blocked tasks (e.g., `[BLOCKED: TASK-123]`)

### Tag Categories

**Component Tags** (where the work happens):
- `#frontend` - UI/React/client-side code
- `#backend` - Server/API/business logic
- `#database` - Schema, migrations, queries
- `#api` - API endpoints, contracts
- `#ui` - User interface design
- `#ml` - Machine learning, AI components
- `#docs` - Documentation
- `#infrastructure` - DevOps, deployment, config
- `#testing` - Test infrastructure, test utilities

**Type Tags** (what kind of work):
- `#feature` - New functionality
- `#bugfix` - Bug fixes
- `#refactor` - Code restructuring
- `#tech-debt` - Addressing technical debt
- `#documentation` - Documentation work
- `#performance` - Performance optimization
- `#security` - Security improvements
- `#migration` - Data or code migration

**Feature Tags** (links to features):
- `#FEAT-XXX` - Links to specific feature

**Custom Tags** (project-specific):
- Add as needed for your domain

### Index Design Principles

1. **Status included inline**: Even though tasks are grouped by status section, include status in the line to catch sync issues
2. **No statistics section**: Generate statistics on demand with `/task-status` - avoids stale data
3. **Tags for scanning**: Use tags to quickly filter and find related tasks
4. **Blocker visibility**: Blocked tasks show blocking reason inline
5. **Last updated timestamp**: Shows freshness of index
6. **Recently completed limited**: Keep last 5-10 for context, rest go to archive

### Scanning and Filtering

**Find all frontend tasks**:
```bash
grep "#frontend" ./docs/tasks/task_index.md
```

**Find all tasks for a feature**:
```bash
grep "#FEAT-042" ./docs/tasks/task_index.md
```

**Find blocked tasks**:
```bash
grep "BLOCKED:" ./docs/tasks/task_index.md
```

**Find high-priority work**:
```bash
grep "\[P0\]\|\[P1\]" ./docs/tasks/task_index.md
```

## Individual Task File Format

Full task details in ./docs/tasks/TASK-XXX-slug.md:

```markdown
# TASK-XXX: [Title]

**Status**: TODO | READY | IN PROGRESS | REVIEW | COMPLETED
**Priority**: P0-Critical | P1-High | P2-Medium | P3-Low
**Tags**: #component #type #FEAT-XXX (space-separated)
**Related Feature**: FEAT-XXX (if applicable)
**Dependencies**: TASK-YYY, TASK-ZZZ (if any)
**Estimated Effort**: X hours/days
**Actual Effort**: X hours/days (when completed)
**Created**: YYYY-MM-DD
**Started**: YYYY-MM-DD (when moved to IN PROGRESS)
**Completed**: YYYY-MM-DD (when done)

## Context

[Detailed background explaining why this task exists, what problem it solves,
and how it fits into the larger project goals. Include links to related
discussions, issues, or documentation.]

## Description

[Clear, detailed description of what needs to be done. Include technical
approach, components to create/modify, and any important constraints.]

## Acceptance Criteria

- [ ] Specific, measurable criterion 1
- [ ] Specific, measurable criterion 2
- [ ] Tests written and passing (80%+ coverage)
- [ ] Documentation updated
- [ ] Code reviewed and approved
- [ ] No regressions in existing functionality

## Implementation Plan

[Generated by `/task-ready` - provides step-by-step roadmap]

### Phase 1: Preparation
- [ ] Read existing ServiceX implementation (path/to/service.py)
- [ ] Identify injection points and dependencies
- [ ] Review related tests

### Phase 2: Implementation
- [ ] Create ServiceXInterface abstract class
- [ ] Update ServiceX constructor with dependency parameters
- [ ] Modify call sites to inject dependencies
- [ ] Update existing tests to use dependency injection

### Phase 3: Verification
- [ ] Run existing test suite
- [ ] Add new DI-specific tests
- [ ] Verify no regressions
- [ ] Update documentation

**Estimated Phases**: 3
**Complexity**: Medium

## Implementation Notes

[Notes added during implementation:]
- Created FileX at path/to/file.py:123
- Modified FileY to add feature Z at path/to/file.py:456
- Decided to use approach A instead of B because [reason]
- Encountered issue X, resolved by [solution]
- Test results: X tests passing, Y% coverage

## Files Changed

- path/to/file1.py - [description of changes]
- path/to/file2.py - [description of changes]
- tests/test_feature.py - [new test file]

## Test Results

```
pytest output or coverage report
```

## Related Tasks

- Depends on: TASK-ABC, TASK-DEF
- Blocks: TASK-XYZ
- Related: TASK-LMN

## Notes

[Any additional context, decisions, learnings, or future considerations]
```

## Quick Start

**Typical workflow for a new task:**

```bash
# 1. Quick capture when idea strikes
/task-create refactor service for dependency injection

# 2. Plan it properly when ready to start
/task-ready TASK-123

# 3. Implement following the plan
/task-implement TASK-123

# 4. Review and complete
/task-review TASK-123
```

## Available Commands

### `/task-create [description]`

Quickly capture a task idea. Uses current context to build a basic task file.

**Usage**:
```bash
/task-create refactor service for dependency injection
/task-create fix auth bug in login flow
/task-create add caching to product queries
```

**Process**:
1. **Analyze context**: Examine recent conversation, open files, current focus
2. **Infer details**: Build better title, description, and suggested priority
3. **Ask for clarification** if needed (or use defaults for quick capture)
4. **Generate TASK-XXX ID** by scanning ./docs/tasks/ directory
5. **Create task file** at ./docs/tasks/TASK-XXX-slug.md with status TODO
6. **Update task_index.md** with new entry in "Need Planning (TODO)" section
7. **Show file path** and suggest next step: `/task-ready TASK-XXX`

**What gets created** (minimal, will be elaborated by `/task-ready`):
- Basic title and description from context
- Inferred priority (or ask user)
- Inferred tags based on context (component, type)
- Status: TODO
- Created date
- Placeholder acceptance criteria
- Empty Implementation Plan section

**Task Index Entry**:
```markdown
- TASK-XXX: Title [Priority] [TODO] #inferred-tags
```

**Philosophy**:
- Make it **fast** to capture ideas
- Don't force deep thinking at creation time
- Use AI to infer what you probably meant (including tags)
- Proper planning happens later with `/task-ready`

### `/task-ready TASK-XXX`

Plan a task comprehensively and move it to READY state. **This is where the AI adds the most value.**

**Prerequisites**:
- Task must be in TODO state
- Cannot run on READY, IN PROGRESS, REVIEW, or COMPLETED tasks

**Process**:

1. **Read task file** and current basic description

2. **Analyze project context**:
   - Read related source code files
   - Review relevant documentation (technical-architecture.md, etc.)
   - Scan related features (FEAT-XXX files)
   - Identify patterns from similar completed tasks

3. **Elaborate task details**:
   - Expand description with technical approach
   - Identify specific files/components to modify
   - Add detailed context explaining "why"
   - Refine acceptance criteria to be specific and measurable

4. **Ask clarifying questions** (interactive):
   - "Should this use the existing ServiceX pattern or create new?"
   - "Do you want to maintain backward compatibility?"
   - "What's the priority: performance or simplicity?"
   - Continue until ambiguities resolved

5. **Build implementation plan** using Claude's planning feature:
   - Break down into phases (Preparation, Implementation, Verification)
   - Create specific, actionable steps
   - Include file paths and line number estimates
   - Mark dependencies between steps
   - Estimate complexity (Low/Medium/High)

6. **Present plan to human** for approval:
   ```
   Here's the implementation plan for TASK-123:

   Phase 1: Preparation (30 min)
   - Read ServiceX at app/services/service_x.py:45-120
   - Identify 3 injection points
   - Review existing tests

   Phase 2: Implementation (2 hours)
   - Create ServiceXInterface (new file)
   - Refactor ServiceX constructor
   - Update 5 call sites

   Phase 3: Verification (30 min)
   - Run test suite
   - Add DI-specific tests
   - Update docs

   Estimated total: 3 hours
   Complexity: Medium

   Approve this plan? (y/n/modify)
   ```

7. **On approval**:
   - Update task file with complete plan
   - Refine tags if needed (component, type, feature links)
   - Move **Status** to READY
   - Update task_index.md:
     - Move to "Ready to Implement" section
     - Update status to [READY]
     - Add/refine tags
   - Confirm: "TASK-123 is ready. Run `/task-implement TASK-123` to start."

**Detection of simple tasks**:
- If task is trivial (e.g., "fix typo in README"):
  - Skip elaborate planning
  - Create minimal plan
  - Fast-track to approval

**Philosophy**:
- Do the hard thinking **before** coding starts
- Use AI to analyze codebase and suggest approach
- Resolve ambiguities through questions, not assumptions
- Human approval ensures plan makes sense
- Save hours of "figuring it out while coding"

### `/task-list`

Show current active tasks and suggest what to work on next.

**Process**:
1. Read ./docs/tasks/task_index.md for overview
2. Scan ./docs/tasks/TASK-*.md files for additional context if needed

**Display**:
1. **NEED PLANNING**: TODO tasks that need `/task-ready`
2. **CURRENT WORK**: Tasks IN PROGRESS with completion % and next steps
3. **READY TO START**: READY tasks prioritized by:
   - P0 (Critical) first
   - P1 (High) next
   - No dependencies
   - Quick wins (<2 hours per implementation plan)
4. **IN REVIEW**: Tasks awaiting verification
5. **BLOCKED TASKS**: List with blocking reasons
6. **RECOMMENDATION**: Specific suggestion on what to work on
7. **RECENT COMPLETIONS**: Last 3 completed tasks

### `/task-status`

Comprehensive status report for all tasks.

**Process**:
1. Read ./docs/tasks/task_index.md for statistics
2. Scan individual task files for detailed status
3. Update task_index.md with refreshed statistics and last updated date

**Provides**:
- Total tasks and completion status (X of Y completed)
- Tasks currently in progress
- Recently completed tasks
- High priority TODO items (P0/P1)
- Blocked tasks
- Suggested next tasks to start

**Flags**:
- Tasks in progress for extended periods
- High priority TODO tasks needing planning (suggest `/task-ready`)
- READY tasks not being worked on
- Tasks in REVIEW for extended periods

### `/task-implement TASK-XXX [--complete]`

Implement a task following its implementation plan.

**Prerequisites**:
- Task must be in READY state (blocks if TODO - run `/task-ready` first)
- No other task can be IN PROGRESS (enforces focus)
- All dependencies must be COMPLETED

**Starting Implementation** (`/task-implement TASK-XXX`):

1. **State checks**:
   - Verify task is READY
   - Check no other task IN PROGRESS
   - Verify dependencies COMPLETED

2. **Begin work**:
   - Update **Status** to IN PROGRESS in task file
   - Add **Started** date
   - Update task_index.md:
     - Move to "In Progress" section
     - Update status to [IN PROGRESS]
   - Create feature branch if needed: `git checkout -b feature/task-xxx-description`

3. **Show implementation plan**:
   ```
   Starting TASK-123: Refactor Service for Dependency Injection

   Implementation Plan:
   [ ] Phase 1: Preparation
       [ ] Read ServiceX at app/services/service_x.py:45-120
       [ ] Identify 3 injection points
   [ ] Phase 2: Implementation
       [ ] Create ServiceXInterface
       ...

   Let's begin with Phase 1...
   ```

4. **Work through plan**:
   - Follow phases in order
   - Check off plan items as completed
   - Add implementation notes to task file
   - Reference files with line numbers (file.py:123)
   - Commit regularly: "TASK-XXX: Specific change description"
   - Update if deviations from plan occur

**Completing Implementation** (`/task-implement TASK-XXX --complete`):

1. **Final checks**:
   - Verify all acceptance criteria met
   - Run validation (typecheck, lint, test)
   - Ensure tests passing
   - Documentation updated

2. **Finalize task file**:
   - Add **Actual Effort**
   - Complete **Implementation Notes** section
   - Fill in **Files Changed** with all modified files
   - Add **Test Results** output

3. **Move to review**:
   - Update **Status** to REVIEW
   - Update task_index.md:
     - Move to "In Review" section
     - Update status to [REVIEW]
   - Suggest: "Run `/task-review TASK-123` to review and complete"

**During implementation**:
- Can pause and resume (status stays IN PROGRESS)
- Can update plan if needed (document why in Implementation Notes)
- Can add clarifying notes or encountered issues
- Regular commits encouraged

### `/task-review TASK-XXX [--approve|--request-changes|--add-notes]`

Review a completed task implementation. **Second quality gate.**

**Prerequisites**:
- Task must be in REVIEW state
- Cannot review TODO, READY, or IN PROGRESS tasks

**Review Process**:

1. **Read task file** and implementation details

2. **Analyze implementation**:
   - Read all files in **Files Changed** section
   - Compare against acceptance criteria
   - Check against implementation plan
   - Review test results
   - Verify no regressions

3. **Generate review report**:
   ```
   REVIEW REPORT: TASK-123
   =======================

   Acceptance Criteria Status:
   ✓ Create ServiceXInterface - PASS (app/interfaces/service_x.py)
   ✓ Refactor constructor - PASS (app/services/service_x.py:45)
   ✓ Update call sites - PASS (5 files modified)
   ✓ Tests passing - PASS (8 new tests, 95% coverage)
   ✗ Documentation updated - FAIL (missing API docs)

   Code Quality Checks:
   ✓ Follows CLAUDE.md conventions
   ✓ No security issues
   ✓ Performance acceptable
   ✗ Error handling incomplete in edge case

   Findings:
   1. Missing API documentation for new interface
   2. Edge case not handled: null dependency injection
   3. Consider adding integration test for DI chain

   Recommendation: Request Changes
   Estimated fix time: 30 minutes
   ```

4. **Present options to human**:
   - **Approve**: Mark complete and archive
   - **Request Changes**: Send back to IN PROGRESS with notes
   - **Add Notes**: Keep in REVIEW, add testing checklist

**Option 1: Approve** (`--approve`):
```bash
/task-review TASK-123 --approve
```
- Update **Status** to COMPLETED
- Add **Completed** date
- Move file to ./docs/tasks/archive/TASK-XXX-slug.md
- Update task_index.md:
  - Remove from active sections
  - Add to "Recently Completed" with completion date and tags
  - Keep only last 5-10 in "Recently Completed"
- Optional: Create git commit
- Optional: Create follow-up tasks

**Option 2: Request Changes** (`--request-changes`):
```bash
/task-review TASK-123 --request-changes
```
- Add review findings to task file
- Update **Status** back to IN PROGRESS
- Update task_index.md:
  - Move back to "In Progress" section
  - Update status to [IN PROGRESS]
- Human can address issues and run `/task-implement TASK-123 --complete` again

**Option 3: Add Notes** (`--add-notes`):
```bash
/task-review TASK-123 --add-notes
```
- Add testing checklist or manual verification steps
- Keep **Status** as REVIEW
- Human performs additional testing
- Can then approve or request changes

**Interactive Mode** (no flag):
```bash
/task-review TASK-123
```
- Shows review report
- Asks: "Approve, request changes, or add notes?"
- Processes based on human response

**Philosophy**:
- AI does thorough code review
- Human makes final judgment call
- Clear communication of issues found
- Easy to iterate if changes needed

### `/task-prioritize`

Organize and prioritize tasks for maximum productivity.

**Process**:
1. Read task_index.md and scan individual task files
2. Analyze dependencies by reading task files
3. Identify critical path and blocking tasks

**Analysis**:
1. Review all tasks
2. Identify dependencies between tasks
3. List P0/P1 critical tasks
4. Group related tasks
5. Identify quick wins (<2 hours)

**Recommendations**:
- Optimal task order considering dependencies
- What should be worked on today
- Next 3-5 tasks to tackle
- Tasks to defer or remove

**Updates**:
- Adjust **Priority** in individual task files if needed
- Update **Dependencies** in task files
- Reorganize sections in task_index.md
- Update "Last Updated" date in task_index.md

### `/task-coverage-review`

Analyze task coverage against requirement documents.

**Process**:
1. **Scan Requirement Documents**:
   - ./docs/vision.md - Product vision and goals
   - ./docs/concepts.md - Domain model and business logic
   - ./docs/ux.md - UI/UX specifications
   - ./docs/technical-architecture.md - System design
   - ./docs/database-schema.md - Data model requirements

2. **Analyze Current Tasks**:
   - Read task_index.md for overview
   - Scan individual task files for details
   - Map tasks to requirement areas
   - Identify coverage gaps

3. **Check Implementation**:
   - Read **Implementation Notes** from completed task files
   - Verify code exists at referenced paths
   - Check implementation matches requirements

4. **Generate Coverage Report**:
   - Covered - Has tasks and/or implementation
   - Partial - Incomplete coverage
   - Missing - No tasks created
   - Inconsistent - Conflicts between docs/tasks/code

5. **Recommend Actions**:
   - Generate new task files for gaps
   - Propose requirement doc updates for inconsistencies
   - Identify tasks to remove/deprioritize

6. **Update Documentation**:
   - Create new task files for missing requirements (all in TODO state)
   - Update task_index.md with new tasks
   - Create cross-references in **Related Tasks** sections

### Utility Commands

**`/task-delete TASK-XXX`**
- Delete a task (any state except COMPLETED)
- Removes task file and updates index
- Confirms before deleting

**`/task-reset TASK-XXX`**
- Reset task back to TODO state
- Useful if planning needs to be redone
- Clears implementation plan

**`/task-usage`**
- Show common task operations and practical examples
- Quick reference for typical workflows

**`/task-help`**
- Minimal list of all task commands with brief descriptions
- Command syntax quick reference

**`/task-about`**
- Comprehensive overview of the task management system
- Philosophy and best practices

## Best Practices

### Task Creation
1. **Capture ideas quickly** - Use `/task-create` when inspiration strikes
2. **Don't overthink at creation** - Details come later with `/task-ready`
3. **One idea, one task** - Keep tasks focused and atomic
4. **Let AI infer tags** - AI suggests tags from context, refine in `/task-ready`

### Task Planning
5. **Plan before coding** - Always run `/task-ready` before `/task-implement`
6. **Answer clarifying questions honestly** - Better plans come from clarity
7. **Review the implementation plan** - Make sure it makes sense before approving
8. **Refine tags during planning** - Add feature links, adjust component/type tags
9. **Adjust plans as needed** - But document why in implementation notes

### Task Implementation
10. **Keep 1 task IN PROGRESS maximum** - Enforced by system, maintains focus
11. **Follow the implementation plan** - Phases are ordered for a reason
12. **Update progress regularly** - Check off plan items, add notes
13. **Reference specific files and line numbers** - Essential for review
14. **Commit regularly** - Small commits with task ID in message

### Task Review
15. **Review thoroughly** - AI helps, but human judgment matters
16. **Don't skip the review** - Catches issues before they spread
17. **Request changes without guilt** - Better to iterate than accept mediocre
18. **Document learnings** - What went well, what to improve next time

### General
19. **Keep index lean** - task_index.md should be scannable at a glance
20. **One task, one file** - All detail in its own file
21. **Archive completed tasks** - Keeps active list manageable
22. **Use specific, measurable acceptance criteria** - Defines "done" clearly
23. **Tag consistently** - Use standard tags (see tag categories) for filtering
24. **Use grep to filter** - `grep "#frontend" task_index.md` finds all frontend tasks

## Summary of Quality Enforcement

**Enforced by State Transitions**:
- Cannot implement without planning (READY state required)
- Cannot mark complete without review (REVIEW → COMPLETED transition)
- Cannot have multiple tasks in progress (enforced by commands)

**AI-Assisted Quality Checks**:
- `/task-ready`: Builds comprehensive plan, asks clarifying questions
- `/task-review`: Thorough code review against criteria and plan

**Human Decision Points**:
- Approve implementation plan before coding starts
- Approve or reject completed work before archiving
- Final judgment on code quality and completeness

## Integration with Documentation System

Tasks integrate with the documentation layer at every lifecycle stage, ensuring implementation follows documented architecture and style guides while keeping documentation aligned with actual implementation.

### Documentation Layer Overview

The system maintains 8 mandated documents that guide all development:

1. **product_requirements.md** - Product vision, personas, user stories
2. **technology_stack.md** - Languages, frameworks, tools (with rationale)
3. **conceptual_design.md** - Domain model, core concepts, business logic
4. **technical_design.md** - System architecture, implementation strategy
5. **code_style_guide.md** - Code style, linting, naming, docstrings
6. **ux_style_guide.md** - UI patterns, colors, typography, layout
7. **documentation_style_guide.md** - User docs writing standards
8. **development_design.md** - Testing, CI/CD, version control, deployment

Additionally, a **knowledge base** (./docs/knowledge/) stores:
- **research/** - Pattern comparisons, technology evaluations
- **implementation-details/** - Detailed technical approaches
- **{doc-type}-extra/** - Extensions of mandated documents

See: **./docs/documentation_how_to.md** for complete documentation system details.

### During Planning (`/task-ready`)

**AI pre-reads documentation to build implementation plan:**

1. **Feature document** (if task linked via #FEAT-XXX tag):
   - User stories and phase goals
   - Technical approach from feature planning

2. **conceptual_design.md**:
   - Domain entities and relationships
   - Business rules and constraints
   - Conceptual-level algorithms

3. **technical_design.md**:
   - System architecture (components, layers)
   - Implementation strategies per component
   - API design patterns
   - Integration points

4. **Knowledge notes** (if relevant):
   - Research notes (pattern comparisons, evaluations)
   - Implementation-detail notes (detailed approaches, error handling)

**AI may create new knowledge notes:**
- If research needed: Creates ./docs/knowledge/research/{topic}.md
- If implementation details needed: Creates ./docs/knowledge/implementation-details/{topic}.md
- Links knowledge notes in task implementation plan

**AI asks clarifying questions informed by docs:**
- "Use existing ServiceX pattern from technical_design.md?"
- "Follow OAuth approach documented in knowledge/implementation-details/oauth-implementation.md?"

**Result**: Task implementation plan references specific docs and includes knowledge note links.

**Example task plan section:**
```markdown
## Implementation Plan

**Reference Documentation:**
- conceptual_design.md § "User Entity" (lines 45-68)
- technical_design.md § "Authentication System" (lines 156-203)
- knowledge/implementation-details/oauth-implementation.md (PKCE flow details)

### Phase 1: Preparation
- [ ] Read existing auth implementation at src/auth/oauth.py
- [ ] Review PKCE flow in knowledge/implementation-details/oauth-implementation.md
...
```

### During Implementation (`/task-implement`)

**AI pre-reads style guides to ensure compliance:**

1. **code_style_guide.md** (for all tasks):
   - Naming conventions (snake_case, PascalCase, UPPER_SNAKE_CASE)
   - Docstring standards (Google-style, numpy-style, etc.)
   - Code organization patterns
   - Comment requirements (explain WHY, not WHAT)

2. **ux_style_guide.md** (for UI tasks):
   - Colors, typography, spacing standards
   - Layout patterns (header/footer, navigation, sidebars)
   - Component style rules (buttons, forms, modals)
   - Interaction patterns (hover states, animations)

3. **development_design.md** (for all tasks):
   - Testing requirements (coverage targets, test types)
   - CI/CD process (what runs when)
   - Version control practices (commit conventions, branching)

**AI follows documented architecture:**
- Implementation matches technical_design.md approach
- Uses patterns from conceptual_design.md
- References code examples from knowledge notes

**AI updates documentation if implementation differs:**
- If implementation deviates from technical_design.md:
  - Updates technical_design.md with actual approach
  - Marks document status: APPROVED → DRAFT
  - Adds version history entry explaining change
  - Prompts: "Run /document-review technical_design to approve"

- If new patterns discovered:
  - Updates knowledge notes with lessons learned
  - Captures error handling patterns, edge cases
  - Documents rationale for approach chosen

**Example implementation notes:**
```markdown
## Implementation Notes

- Following code_style_guide.md:
  - Used snake_case for function names: `authenticate_user()` ✅
  - Added Google-style docstrings to all functions ✅
  - Comments explain WHY we cache tokens (not HOW) ✅

- Following technical_design.md § "Authentication":
  - Implemented OAuth 2.0 with PKCE flow ✅
  - Used Redis for session management ✅

- Deviation from plan:
  - technical_design.md mentioned JWT tokens
  - Actually used OAuth access tokens (simpler, meets requirements)
  - Updated technical_design.md to reflect actual implementation
  - See version history 2025-10-06

- Updated knowledge/implementation-details/oauth-implementation.md:
  - Added token refresh error handling patterns
  - Documented retry logic for network failures
```

### During Review (`/task-review`)

**AI verifies documentation compliance:**

1. **Check code_style_guide.md followed:**
   - ✅ Naming conventions correct
   - ✅ Docstrings present and properly formatted
   - ✅ Code organization follows patterns
   - ✅ Comments explain WHY not WHAT

2. **Check ux_style_guide.md followed (if UI task):**
   - ✅ Colors match style guide
   - ✅ Typography follows scale
   - ✅ Layout patterns consistent
   - ✅ Spacing uses standard units

3. **Check development_design.md requirements met:**
   - ✅ Tests written (unit, integration as specified)
   - ✅ Coverage target met (e.g., 90%+ for new code)
   - ✅ CI passing (linting, type checking, tests)
   - ✅ Commit conventions followed

4. **Check technical_design.md alignment:**
   - ✅ Implementation matches documented architecture
   - ✅ If different, technical_design.md updated
   - ✅ New patterns documented

5. **Check knowledge notes updated:**
   - ✅ Lessons learned captured
   - ✅ Implementation details documented
   - ✅ Error patterns recorded for reuse

**Example review report:**
```
REVIEW REPORT: TASK-045
=======================

Documentation Compliance:

✅ code_style_guide.md:
  - Naming conventions: PASS (snake_case functions, PascalCase classes)
  - Docstrings: PASS (Google-style on all public functions)
  - Comments: PASS (explain WHY: "Cache tokens to avoid rate limiting")

✅ development_design.md:
  - Tests: PASS (pytest, 95% coverage)
  - CI: PASS (ruff, mypy, pytest all green)
  - Commits: PASS (conventional commits: "feat(auth): add OAuth flow")

⚠️ technical_design.md:
  - Implementation uses OAuth tokens instead of JWT
  - technical_design.md updated to match
  - Status changed: APPROVED → DRAFT
  - ACTION REQUIRED: Run /document-review technical_design

✅ Knowledge notes:
  - Updated oauth-implementation.md with token refresh patterns
  - Added error handling examples

Recommendation: Approve, but remind user to review technical_design updates.
```

### Documentation Touchpoint Summary

```
State          Pre-Read Docs                 May Update Docs
────────────── ───────────────────────────── ─────────────────────────────
TODO           -                             -
  ↓ /task-ready
READY          • conceptual_design.md        • knowledge/research/
               • technical_design.md         • knowledge/implementation-
               • knowledge notes               details/
  ↓ /task-implement
IN PROGRESS    • code_style_guide.md         • technical_design.md (if
               • ux_style_guide.md             implementation differs)
               • development_design.md       • knowledge notes (lessons
               • implementation plan docs      learned)
  ↓ /task-implement --complete
REVIEW         -                             -
  ↓ /task-review
COMPLETED      • All style guides            • knowledge notes (final
               • technical_design.md           learnings)
               • knowledge notes             • technical_design.md (if
                 (for verification)            needed)
```

### Cross-References

**In task files:**
```markdown
## Implementation Plan

**Reference Documentation:**
- conceptual_design.md § "Order Entity" (domain model)
- technical_design.md § "Payment Processing" (architecture)
- knowledge/implementation-details/stripe-integration.md (payment flow)

...
```

**From mandated docs to tasks:**
```markdown
# Technical Design

## Authentication System

[High-level OAuth 2.0 approach...]

**Implemented by:**
- TASK-045: OAuth flow
- TASK-046: Token refresh
- TASK-047: Session management

**Detailed Implementation:** See knowledge/implementation-details/oauth-implementation.md
```

### DRAFT Status Warnings

If a task reads a mandated document with **DRAFT** status during planning:

```
⚠️  WARNING: technical_design.md has DRAFT status (unreviewed changes)

The Authentication section was recently updated but not yet approved.
This may affect your implementation plan.

Options:
1. Review and approve now: /document-review technical_design
2. Continue with DRAFT doc (plan may need revision later)
3. Skip this task until doc approved

Recommendation: Review technical_design.md before planning this task.
```

### Benefits of Documentation Integration

1. **Consistent Implementation**: Code follows documented architecture and style
2. **Knowledge Preservation**: Lessons learned captured in knowledge base
3. **Alignment**: Docs stay in sync with actual implementation
4. **Informed Planning**: AI plans based on documented patterns
5. **Quality Enforcement**: Style guides enforced automatically
6. **Traceability**: Clear links from tasks to docs to code

## Integration with Features

- Tasks can reference features: **Related Feature**: FEAT-XXX
- Features generate tasks via `/feature-plan`
- Tasks link back to features for traceability
- Feature status reflects aggregate task progress

## Integration with Development

- Tasks guide development priorities
- Implementation references task IDs in commits
- Code quality tools run before task completion
- Testing requirements specified in acceptance criteria
- Documentation updated as part of completion

## Troubleshooting

**"Cannot implement TASK-XXX - task is in TODO state"**
- Task needs planning first
- Run `/task-ready TASK-XXX` to plan and move to READY
- Then `/task-implement TASK-XXX` will work

**"Another task (TASK-YYY) is already in progress"**
- System enforces single-task focus
- Complete current task with `/task-implement TASK-YYY --complete`
- Or reset it with `/task-reset TASK-YYY` if abandoning

**"Cannot review TASK-XXX - task is not in REVIEW state"**
- Task must be completed first
- Run `/task-implement TASK-XXX --complete` to move to REVIEW
- Then `/task-review TASK-XXX` will work

**Lost track of what to work on?**
- Check task_index.md for quick overview
- Use `/task-list` for smart recommendations
- Use `/task-status` for comprehensive report
- Look for READY tasks - they're planned and ready to code

**Task planning seems excessive for simple change?**
- `/task-ready` detects simple tasks and streamlines
- You can still manually create minimal plan
- Better to have simple plan than no plan

**Want to change approach mid-implementation?**
- Document why in Implementation Notes section
- Update Implementation Plan with new approach
- Continue with new plan

**Review found issues, what now?**
- Use `/task-review TASK-XXX --request-changes`
- Address the issues noted
- Run `/task-implement TASK-XXX --complete` again
- Another review cycle ensures quality

**Can't find a task?**
- Check task_index.md for complete list
- Search ./docs/tasks/ for task files
- Look in ./docs/tasks/archive/ for completed tasks
- Use grep: `grep -r "TASK-XXX" ./docs/tasks/`

**Task file getting too large?**
- This is expected and OK - rich detail is good
- Keep task_index.md lean and scannable
- Task files can be 200+ lines for complex work

**Index and task files out of sync?**
- Task files are source of truth
- Use `/task-status` to refresh index from files
- Commands should keep them in sync automatically
