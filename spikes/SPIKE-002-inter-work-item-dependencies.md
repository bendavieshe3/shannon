# SPIKE-002: Inter-Work-Item Dependencies

## Metadata

- **Status**: DRAFT
- **Type**: Spike
- **Feature**: [FEAT-003](../docs/features/FEAT-003-unified-work-item-model.md)
- **Time-box**: One day
- **Created**: 2026-10-18
- **Updated**: 2026-10-18

> **Status** moves through the unified lifecycle, but the meaningful transitions for a spike are `ELABORATED → IMPLEMENTED` (investigation done) and `APPROVED` (output captured as knowledge note). Spikes are disposable — the knowledge note is the durable artefact.

---

## Requirements

*Initial intent captured at spike creation, promoted from `docs/scratchpad.md` by the 2026-10-17 scratchpad triage. Full elaboration pending `/spike-elaborate SPIKE-002`.*

### Question

How should Shannon express "this work item cannot start implementing until those are APPROVED" without bringing back the `*-PENDING` sub-statuses that `technical_design.md` v1.1 retired?

### Why This Spike

Tasks carry a free-text `Dependencies` section, but the lifecycle has no blocked-by concept. EPIC-006 sidestepped the question with a forward declaration in its Plan. It has now recurred in practice: TASK-026 sits at "DRAFT (DEFERRED to EPIC-011)" in `task_index.md`, an ad-hoc label that works like the retired pending sub-status. Answering it changes the unified lifecycle, which every work item shares, so an investigation should come before an Epic commits to a design.

### Expected Output

- A knowledge note comparing options: a structured dependency field checked at `*-implement`, an index annotation, a supervisor Lifecycle-checker rule, or leaving it as convention
- A recommendation, and, if it warrants one, an Epic under FEAT-003 for the directing party to approve

### Time-box

One day.

### Context

- **Feature**: FEAT-003 — Unified Work Item Model (Ideal State bullet 3, status model evolution absorbed by existing work items)
- **Relevant documents**: `conceptual_design.md` § Business Rules → *Unified Status Lifecycle*; `technical_design.md` § Key Algorithms → *Cascading Operations* and its v1.1 PENDING reconciliation; `shannon/skills/shannon-supervisor/checkers/lifecycle.md`

---

## Plan

[Filled during planning. The investigation approach.]

### Approach

[How the investigation will proceed. What experiments, comparisons, prototypes, or research steps are involved.]

### Steps

1. [Step]
2. [Step]
3. [Step]

### Risks

- [Risk — mitigation]

---

## Investigation Notes

[Filled during implementation. Raw findings, dead-ends, surprises. This is the working scratchpad. The polished output goes into the knowledge note.]

---

## Output

### Knowledge Note

[Link to the knowledge note this spike produced. The note is the durable artefact; this spike file is just the activity record.]

- [Knowledge note path]

### Recommendation

[The recommendation that emerges from the investigation, in one or two sentences. The full reasoning lives in the knowledge note.]

---

## Review

[Filled during review (Gate 3).]

### Verification

- [ ] Question answered (or confirmed unanswerable within time-box)
- [ ] Knowledge note created and indexed
- [ ] Recommendation captured
- [ ] Follow-up work items created where needed

### Review Notes

[Findings from review. Follow-up work items created as a result.]

---

## Activity Log

[Timestamped entries recording the history. Newest at the top.]

- **2026-10-18** — DRAFT: Spike created from the scratchpad item "Inter-work-item dependency as a first-class concept" by the 2026-10-17 triage. The triage recommended a Spike before an Epic, because the answer changes the lifecycle model. Created on directing-party approval
