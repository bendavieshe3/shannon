# TASK-027: `/shannon-goal` Promotion-Authority Resync and Candidate-Derived Footer

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #shannon-goal #promotion-authority #corrective
- **Created**: 2026-08-21
- **Updated**: 2026-08-21

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Initial intent captured at task creation, downstream of the `ux_guide.md` v1.3 Gate 1 approval (2026-08-21). Full elaboration pending `/task-elaborate TASK-027`.*

### Overview

`ux_guide.md` v1.3 corrected the `/shannon-goal` promotion-authority footer from three promotion targets to four — adding the Spike case that `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority* establishes — and added prose committing the footer to naming the authorities the run's actual candidates implicate rather than printing a fixed legend. The shipped supervisor skill still carries v1.2's three-target form. This Task re-syncs it.

The correction has two halves, and the second is the one that matters:

1. **The factual half.** `shannon/skills/shannon-supervisor/SKILL.md` carries the three-target phrasing in two places — the `/shannon-goal` contract prose at § /shannon-goal — Contract step 3 (*"a Task may be auto-promoted on supervisor authority, but promotion to an Epic or a Feature requires directing-party approval"*), and the fenced example under § Output shape (*"Promote which? (Tasks may be auto-promoted on supervisor authority; Epics and Features require your approval.)"*). Both omit Spike. The deployed copy at `.claude/skills/shannon-supervisor/SKILL.md` is currently identical to the source and must be re-synced after the source edit, per the shipping-source discipline TASK-019 established.

2. **The structural half.** The footer should be **derived from the candidates the run actually produced**, not emitted as a fixed legend. A run whose candidates are all Tasks should say so and mention nothing else; a run that surfaces an Epic candidate names the directing-party requirement because it is live, not because the legend always carries it. This is what `ux_guide.md` v1.3 now specifies, and it is the durable fix — a hardcoded legend drifts again the next time the authority model changes.

### Why this is corrective

The defect's origin is instructive and should be recorded rather than quietly patched. TASK-022 bound the shipped output to *"the ratified example at `ux_guide.md` v1.2"* — treating a **worked example in a UX guide as if it were a specification**. The example was illustrative and abbreviated; copying it verbatim imported its abbreviation as behaviour. The Guide has now been corrected, but the general lesson (an example is not a contract) is framework-general and may warrant a scratchpad item at elaboration, per the meta-gap routing channel.

### Acceptance Criteria

*Drafted at `/task-elaborate TASK-027`. Expected shape:*

- [ ] `shannon/skills/shannon-supervisor/SKILL.md` § /shannon-goal — Contract step 3 names all four promotion authorities, matching `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*, including Spike's configurable ceiling
- [ ] The § Output shape example and its surrounding prose specify a **candidate-derived** footer, not a fixed legend, matching `ux_guide.md` v1.3 § Command Surface → *Supervisor Commands*
- [ ] The `spike_gate_authority` configuration field (already documented in § Configuration) is named as the thing that determines whether Spike promotion is supervisor-autonomous for the project
- [ ] Source and deployed copy re-synced; a repo-wide grep for the three-target phrasing returns zero
- [ ] No behaviour outside `/shannon-goal` is altered — no report-pipeline, checker, hook, template, or command file modified

### Context

- **Parent Epic**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md) — Synthesis and Reports (IMPLEMENTING). This is the Epic's sixth Task, added corrective mid-implementation, as EPIC-009 took three correctives (TASK-019/020/021).
- **Upstream document**: `ux_guide.md` v1.3 (APPROVED 2026-08-21) § Command Surface → *Supervisor Commands* — the amendment this Task implements.
- **Governing rule**: `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* → *Scratchpad promotion authority*.
- **Sibling**: [TASK-022](./archive/TASK-022-shannon-goal-decomposition-skill.md) — shipped `/shannon-goal`; its § Implementation Notes records the configuration-phrasing nuance that rode the same `ux_guide` cluster.
- **Discipline**: `development_guide.md` § Code Style → *Source-of-truth body before derived artefacts* — edit `shannon/`, then deploy to `.claude/`.

---

## Plan

*Drafted at `/task-plan TASK-027` (Gate 2).*

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review.*

---

## Activity Log

- **2026-08-21** — DRAFT: Task created as a corrective, downstream of the `ux_guide.md` v1.3 Gate 1 approval the same day. The Guide's promotion-authority footer was corrected from three targets to four and committed to candidate-derived phrasing; the shipped skill still carries the v1.2 three-target form in two places. Created rather than recorded as an intention, per the directing party's instruction that the cluster's eighteen-day stall was caused by notes naming their own fix and nobody executing it. Full elaboration pending `/task-elaborate TASK-027`.
