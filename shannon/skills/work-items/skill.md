---
name: work-items
description: Manage Shannon work items (Feature, Epic, Task, Spike) through the unified lifecycle (DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED). Owns create, elaborate, plan, implement, and review operations for all four types, enforces the three quality gates, and maintains the work item indexes. Invoked by /[type]-[verb] commands.
---

# Skill: work-items

When invoked, **start your response with**: "Activating work-items skill for [type] [verb]."

## Purpose

This skill owns every work item Shannon tracks: Features, Epics, Tasks, and Spikes. It handles:

- Creating work items in DRAFT
- Elaborating requirements through Gate 1 to ELABORATED
- Planning implementation through Gate 2 to PLANNED
- Executing implementation in the IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW iterative zone
- Reviewing and approving through Gate 3 to APPROVED
- Maintaining the four work item indexes
- Enforcing the relationship rules between work items and mandated documents

This skill does **not** own mandated documents — those belong to the `project-documentation` skill.

## When to Invoke

- Any `/feature-*`, `/epic-*`, `/task-*`, or `/spike-*` command
- The user asks to create, elaborate, plan, implement, or review any work item
- The user asks to "move TASK-042 to ELABORATED" or similar status transitions

## Inputs

- **Type** — `feature`, `epic`, `task`, or `spike`
- **Verb** — `create`, `elaborate`, `plan`, `implement`, or `review`
- **Target** — Work item ID (e.g. `TASK-042`) or hint
- **Working directory** — Inferred

## Templates

This skill owns:

- `templates/feature.md`
- `templates/epic.md`
- `templates/task.md`
- `templates/spike.md`
- `templates/feature_index.md`
- `templates/epic_index.md`
- `templates/task_index.md`
- `templates/spike_index.md`

## Unified Status Model

```
DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED
     │           │          │                                       │
   Gate 1     Gate 2    (iterative zone)                         Gate 3
```

Every work item type uses this lifecycle. There are no type-specific status values.

## Work Item ↔ Document Relationships

Different work items consult different documents at different stages.

| Work Item | Stage | Must Align To | Informed By / May Update |
|---|---|---|---|
| Feature | Elaborate | Vision | — |
| Feature | Plan | Vision, Conceptual Design | Technology Stack |
| Epic | Elaborate | Vision, parent Feature, Conceptual Design | — |
| Epic | Plan | Technology Stack, parent Feature | Technical Design |
| Task | Elaborate | Parent Epic/Feature, relevant Guides | — |
| Task | Plan/Implement | Development Guide, Technical Design | — |
| Spike | Elaborate | — | — |
| Spike | Implement | — | Knowledge Base (output) |

**Key rule**: Guides (Development Guide, UX Guide) are reference material. Work items consume them; they are not updated by work items. Updates to guides happen via `/document-review`.

## Process: Create

### 1. Identify Type and Hint

Type comes from the command. Hint is the optional title or context the user supplied.

### 2. Allocate ID

Find the highest existing ID for this type in its index, increment by 1. Format as `FEAT-001`, `EPIC-001`, `TASK-001`, `SPIKE-001`.

### 3. Generate Slug

Derive a kebab-case slug from the work item name (or hint). Sanitise.

### 4. Instantiate Template

Copy `templates/<type>.md` to the right location:

- Feature: `./docs/features/FEAT-XXX-<slug>.md`
- Epic: `./docs/epics/EPIC-XXX-<slug>.md`
- Task: `./docs/tasks/TASK-XXX-<slug>.md`
- Spike: `./spikes/SPIKE-XXX-<slug>.md`

### 5. Pre-Fill Metadata

- Status: DRAFT
- Type: matches the work item type
- Parent: from the user's invocation context (for Tasks and Epics)
- Created: today
- Updated: today

### 6. Capture Initial Context

Add high-level intent from the user's hint and recent conversation. Do not block waiting for full elaboration — `create` is fast capture.

### 7. Update Index

Append a one-line entry to the appropriate index file.

**Feature `(Partial)` index suffix**: a Feature's `feature_index.md` entry carries a trailing `(Partial)` token after the Feature Name iff its body's `Initial Implementation` field reads `Partial`. Whenever the skill sets or changes a Feature's `Initial Implementation` field — at create, during re-elaboration, or when an Epic closes out part of the capability — it updates `docs/features/feature_index.md` in the same operation to add or remove the suffix. The suffix is a derived skill responsibility, never a manual convention; index and body must not diverge (see § Failure Modes — *Index out of sync*).

### 8. Confirm and Resume

Report creation to the user. Resume the original conversation topic.

## Process: Elaborate (Gate 1)

### 1. Identify Target

Use the ID supplied. If ambiguous, list candidates and ask.

### 2. Spawn Elaboration Subagent

The subagent:

- Reads the work item file
- Reads the parent work item (if any) and its parent
- Reads the documents listed under "Must Align To" for this type and stage
- Reads other documents listed under "Informed By"
- Drafts the Requirements section
- Checks alignment against required documents
- Returns a structured summary

Subagent writes drafted Requirements directly into the work item file.

### 3. Present and Iterate

Show the user the drafted Requirements and the alignment check results. Iterate based on feedback.

### 4. Gate 1 Approval

Ask explicitly: "Approve these requirements to mark this ELABORATED?"

- On approval: Set Status to ELABORATED, update Updated date, append Activity Log entry, update index
- On rejection: Iterate

### 5. Resume

Report the transition and resume the original conversation topic.

### Re-elaboration Branch (non-DRAFT input)

When `/feature-elaborate`, `/epic-elaborate`, `/task-elaborate`, or `/spike-elaborate` is invoked on a work item already in ELABORATED, PLANNED, IMPLEMENTING, IMPLEMENTED, REVIEW, or APPROVED status, the skill enters the re-elaboration branch defined by `conceptual_design.md § Re-elaborating a Work Item`. The skill:

1. Recognises the input status — does **not** error (contrast § Failure Modes "Wrong status for verb")
2. Spawns an alignment subagent per the canonical workflow's Flow step 2 (target work item + parent + Work Item ↔ Document Relationships)
3. Subagent returns findings using the canonical four-category schema (Drift / Gap / Internal contradiction / Strength)
4. Directing party reviews findings; refinements applied per Gate 1
5. **Status semantics** are defined canonically in conceptual_design — the skill does not duplicate the per-status table. In brief:
   - **Additive** refinements: work item stays at current status; Activity Log records the refinement
   - **Substantive** refinements: work item transitions back to DRAFT; subsequent gates re-pass per the per-status table
6. Activity Log entry records the trigger category, upstream commit hash where applicable, and a summary of what changed (three required fields per the canonical workflow)

Cross-type adjustments (Features have no upstream work-item parent; Spikes are standalone; orphan Tasks behave as Features for trigger purposes) are defined canonically in conceptual_design — the skill defers semantics to the doc rather than duplicating them.

## Process: Plan (Gate 2)

### 1. Identify Target

Must be ELABORATED. If not, surface error.

### 2. Spawn Planning Subagent

The subagent:

- Reads the work item's Requirements
- Reads documents listed under "Informed By" for this type and stage
- Drafts the Plan section: approach, steps/tasks/epics (depending on type), dependencies, risks
- For higher-level items (Feature, Epic), may identify the child work items needed
- Returns a structured summary

### 3. Cascading Preparation (for Epics)

If the work item is an Epic, the planning subagent may draft tasks for the epic, marking them `PLAN-PENDING` (awaiting their own Gate 2 approval).

### 4. Present and Iterate

Show the plan to the user. For cascading operations, summarise the child items prepared.

### 5. Gate 2 Approval

Ask explicitly: "Approve this plan to mark this PLANNED?"

- On approval: Set Status to PLANNED, update index. Child items (if any) remain `PLAN-PENDING` until individually approved
- On rejection: Iterate

### 6. Resume

Report and resume.

## Process: Implement

### 1. Identify Target

Must be PLANNED. If not, surface error.

### 2. Mark IMPLEMENTING

Update status, append Activity Log entry.

### 3. Execute Plan

Follow the plan steps. Update Activity Log as significant decisions are made. Capture deviations in the Implementation Notes section.

### 4. Mark IMPLEMENTED

When the work is complete (per the plan), update status to IMPLEMENTED.

### 5. May Iterate

The user or AI may move the work item back to IMPLEMENTING from IMPLEMENTED or REVIEW. The iterative zone is gateless.

## Process: Review (Gate 3)

### 1. Identify Target

Must be IMPLEMENTED or REVIEW.

### 2. Mark REVIEW

Update status if currently IMPLEMENTED.

### 3. Verify Against Acceptance Criteria

Spawn a subagent to:

- Read the work item file
- Verify each acceptance criterion (checkbox) is met
- Read related work items and documents for cross-cutting checks
- Return a verification summary

### 4. Present Verification

Show findings. If issues are found, surface them as candidate iterations back to IMPLEMENTING.

### 5. Gate 3 Approval

Ask explicitly: "Approve this work to mark this APPROVED?"

- On approval:
  - Set Status to APPROVED
  - Update Updated date and Activity Log
  - Update index
  - **For Tasks**: move file to `./docs/tasks/archive/` and update link in index
  - **For Spikes**: confirm the knowledge note has been created and indexed
  - **For Features**: update Activity to STABLE
- On rejection: iterate

### 6. Resume

Report and resume.

## Quality Gates

- **Gate 1** (DRAFT → ELABORATED): Explicit user approval
- **Gate 2** (ELABORATED → PLANNED): Explicit user approval
- **Gate 3** (REVIEW → APPROVED): Explicit user approval

AI never self-approves across a gate.

## Cascading Operations

When the user invokes a verb on a parent work item that has children (or could have children), prefer **Batch Preparation, Individual Gates**:

1. AI does the heavy work (planning, drafting) for parent and all children
2. AI marks children as `*-PENDING` (e.g. `PLAN-PENDING`)
3. AI presents a summary to the user
4. User runs the relevant command per child to promote each individually

This preserves granular human approval without overwhelming surface.

## Failure Modes

- **Wrong status for verb** — e.g. user runs `/task-plan` on a DRAFT task. Surface error: "Cannot plan TASK-042 — it is DRAFT. Elaborate it first with `/task-elaborate TASK-042`." Conversely, `*-elaborate` on a non-DRAFT work item is *not* an error — it enters the re-elaboration branch (see § Process: Elaborate → Re-elaboration Branch and `conceptual_design.md § Re-elaborating a Work Item`).
- **Missing parent** — A Task whose parent Epic doesn't exist. Surface and ask whether to create the parent or proceed as an orphan task.
- **DRAFT mandated doc as context** — Warn the user that the document being relied on is not yet authoritative.
- **Index out of sync** — If the index disagrees with the work item file's status, trust the file and fix the index. This includes the Feature `(Partial)` suffix: if a Feature's body reads `Initial Implementation: Partial` but its `feature_index.md` entry lacks `(Partial)` — or carries it without the body field — the body is authoritative; correct the index (see § Process: Create step 7).

## Self-Identification

Always begin a response with: "Activating work-items skill for [type] [verb]." If you cannot perform this skill's work for any reason, say so explicitly rather than silently doing something else.
