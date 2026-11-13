# FEAT-003: Unified Work Item Model

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Feature-led Delivery"
- **Initial Implementation**: Partial — the unified model itself is retrospective (templates, skill, commands predate this Feature). Of four aspirational criteria (three added 2026-05-19, one added 2026-05-24): three now met (re-elaboration workflow via EPIC-006 / TASK-001; queryable completeness via EPIC-006 / TASK-002; upstream lessons-into-framework-rules via EPIC-007 / TASK-008 doc amendments + TASK-009 skill prompts, APPROVED 2026-05-27), one remaining (framework-version absorption). See Met / Remaining below.
  - **Met:** The retrospective unified model — four work-item types on one status lifecycle, with shared templates, skill, and commands — plus three aspirational criteria: the *Re-elaborating a Work Item* workflow (EPIC-006 / TASK-001) and queryable implementation completeness (EPIC-006 / TASK-002), and upstream lessons-into-framework-rules (EPIC-007 / TASK-008 doc amendments at `conceptual_design.md` v1.6 + TASK-009 skill prompts at `work-items/skill.md`, APPROVED 2026-05-27).
  - **Remaining:** One aspirational criterion — framework-version absorption: framework changes (new attributes, workflows, status-model evolution) absorbed by existing work-item files via canonical re-elaboration, so adopters never recreate work items to accommodate framework evolution.
- **Created**: 2026-05-18
- **Updated**: 2026-11-01

---

## Requirements

### Overview

Features are persistent, human-governed product capabilities. Epics, Tasks and Spikes remain available as optional agent-managed execution records. Keep familiar names, command verbs, identifiers and history without requiring a hierarchy or a shared gated lifecycle below Features.

### Ideal State

- Everything traces from Vision through relevant governing documents and Features to implementation, verification and independent review.
- Feature requirements, approach and delivered capability retain human gates. Direct Feature implementation requires no Epic or Task.
- Optional aids have no mandatory prior progress label or human approval stage. Existing indexes agree with bodies; missing optional indexes are not defects.
- Re-elaboration and factual upkeep preserve decisions/history rather than forcing record recreation. Framework changes do not bulk migrate or archive existing records.
- Partial implementation remains queryable through metadata and the matching Feature-index suffix. Reusable lessons flow into governing documents and knowledge notes.

### User Stories

As the human directing party, I can approve a Feature and let agents deliver it directly, while retaining traceability, familiar records where useful and enough evidence for a fresh session to resume.

### Context

See `vision.md` § Feature-led Delivery and Complete Traceability; `conceptual_design.md` § Unified Status Lifecycle and Re-elaborating a Work Item; `technical_design.md` § API Design → Lifecycle Verbs; source `shannon/skills/work-items/` and its command entry points. Prior delivery claims remain in metadata, Plan and Activity Log as dated evidence, not new acceptance of this revision.

## Plan

**2026-11-01 governance revision:** the following retained Epics/Tasks record earlier work and backlog. Any old per-child gate or hierarchy requirement is superseded; explicit project holds and unaccepted deliverables remain. This revision is implemented directly under the approved Feature-level approach; independent review and human delivery acceptance remain outstanding.

### Epics

- [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md) — APPROVED — Work Item Lifecycle Maturation: Re-elaboration + Queryable Completeness (closed scratchpad items F1 and F2; fulfilled aspirational Ideal State bullets 1 and 2 added 2026-05-19; bullet 3, framework-version absorption, remains open)
- [EPIC-007](../epics/EPIC-007-work-item-conventions-from-dogfooding.md) — APPROVED — Work-Item Conventions Surfaced Through Dogfooding (promoted four work-item-workflow clarifications — commit-hash timing in re-elaboration, bundled re-elaboration, no opaque plan-letter labels, AC scope-guard convention — into ratified rules in `conceptual_design` v1.6 + `work-items` skill; fulfilled aspirational Ideal State bullet 4; sibling to EPIC-008 under FEAT-008 covering the dev-discipline half)
- [EPIC-014](../epics/EPIC-014-work-item-conventions-round-2.md) — DRAFT, superseded 2026-11-13 (its sibling-change trigger is already in § Re-elaborating a Work Item) — Work-Item Conventions Surfaced Through Dogfooding, Round 2 (sibling re-elaboration trigger, *Cascading Preparation* workflow, *Future Epics* paragraph; serves Ideal State bullet 4)
- [EPIC-015](../epics/EPIC-015-document-consultation-at-elaborate-and-plan.md) — DRAFT — Document Consultation at Elaborate and Plan (needs an additive Ideal State bullet first, per *Responsible Promotion* step 5)

Spike under this Feature: [SPIKE-002](../../spikes/SPIKE-002-inter-work-item-dependencies.md) — DRAFT, superseded 2026-11-13 — Inter-Work-Item Dependencies (the gated lower lifecycle it assumed no longer exists).

Orphan Tasks under this Feature (no parent Epic; EPIC-007 is APPROVED and closed, and each item is too small to warrant a new Epic; optional Task execution remains bounded by its governing Feature or engineering rule), promoted from the 2026-10-17 scratchpad triage:

- [TASK-030](../tasks/TASK-030-skill-creating-epics-scope-command-entry-point.md) — DRAFT, folded 2026-11-13 into the FEAT-008 conventions — Skill-Creating Epics Scope the Command Entry Point
- [TASK-031](../tasks/TASK-031-parent-epic-advances-with-children.md) — DRAFT, superseded 2026-11-13 — Parent Epic Advances Through the Iterative Zone With Its Children
- [TASK-032](../tasks/TASK-032-archived-task-link-depth.md) — DRAFT — Archived Tasks Keep Working Parent Links

### Dependencies

**Depends on**: FEAT-002 (Mandated Project Documentation) — work items consume mandated documents as context

**Depended on by**: FEAT-004 (Three Quality Gates) — the gates are tied to lifecycle transitions; FEAT-005 (Knowledge Base) — spike output produces knowledge notes; FEAT-006 (Multi-Party Supervision) — independent technical review supports human Feature acceptance

### Risks

- **Model rigidity** — Forcing all four types into one lifecycle may pinch when a future work item type (e.g. "retrospective", "incident") doesn't fit. Mitigation: the model is documented in conceptual_design, not load-bearing in code, so it can be revised with a doc review pass

---

## Success Metrics

- **Vocabulary uniformity** — All four work item types use the same status names consistently across files, indexes, and AI prose (no `*-PENDING` style drift)
- **Verb pattern adoption** — Every type has the five verbs implemented as commands
- **Index accuracy** — Indexes reflect current status without manual sync drift

---

## Activity Log

- **2026-11-13** — Plan bookkeeping (no status change): backlog reconciled to Vision v3.0. EPIC-014, TASK-031 and SPIKE-002 are superseded and TASK-030 folds into the FEAT-008 conventions; each record's Activity Log gives the reason. The remaining FEAT-003 work (framework-version absorption, document consultation at elaborate and plan) is delivered directly under this Feature in the finish-to-vision push.
- **2026-11-12** — Clarification of the approved governance revision: approval of its requirements and implementation approach is not acceptance of this Feature's whole delivered capability. Overall Status remains ELABORATED; this repair records no Feature Gate 3 acceptance. Independent review and any remaining delivery or live-validation work remain outstanding.


- **2026-11-01** — Human approved the Feature-level governance design and implementation approach. Requirements refreshed to preserve documents, alignment, traceability and history while removing mandatory child gates. Source implementation pending independent review; no delivery acceptance or historical status change inferred. See [governance rationale](../knowledge/feature-level-governance.md).

- **2026-10-17** — Plan bookkeeping (no status change). The scratchpad triage promoted three orphan Tasks here on supervisor promotion authority: TASK-030, TASK-031 and TASK-032. It also removed the stale "candidate future Epic: orphan-task business rule" line, because `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* → *Orphan Tasks* already carries that rule. On 2026-10-18 the directing party approved the Epic-scale items from the same triage: EPIC-014 (conventions round 2) and EPIC-015 (document consultation) are DRAFT here, and SPIKE-002 (first-class dependencies) investigates before any Epic. EPIC-015 needs an additive Ideal State bullet before its Gate 1.
- **2026-05-24** — Re-elaborated (additive). **Trigger**: downstream gap — EPIC-007 elaboration (in flight 2026-05-24; not yet committed) surfaced that no Feature's Ideal State explicitly anchored "work-item conventions accumulated through framework use are promoted into the mandated documents." Vision § Adaptive Coherence covered it at principle level but no Feature instantiated it; per *Responsible Promotion*, EPIC-007 could not claim FEAT-003 as parent without an explicit anchor. **Change**: added fourth aspirational Ideal State bullet (upstream lessons-into-framework-rules — addressed by EPIC-007); intro updated from "two delivered, one outstanding" to four-bullet structure; `Initial Implementation` line and sub-block `Remaining` updated to reflect 4-bullet structure (2 met, 2 remaining). The directing party also identified an architectural split: dev-discipline learnings move to new FEAT-008 (created 2026-05-24); FEAT-003's bullet 4 specifically anchors the work-item-conventions half. **Additive** — no previously-approved claim contradicted; FEAT-003 stays ELABORATED. **Commit hash**: trigger is in-flight EPIC-007 (no upstream commit yet); referenced by Epic ID — exactly the case EPIC-007's AC#1 will codify (an honest dogfood: this entry is itself an instance of the commit-hash-timing case the upcoming convention names).
- **2026-05-22** — Re-elaborated (additive). **Trigger**: framework evolution — EPIC-006 (via TASK-001 and TASK-002, commit `09844df`) delivered the *Re-elaborating a Work Item* workflow and the queryable Partial-completeness affordance — the aspirations this Feature named on 2026-05-19. **Change**: added the `**Met:** / **Remaining:**` sub-block beneath the `Initial Implementation` line; updated the `Initial Implementation` line and Ideal State aspirational bullets 1 (re-elaboration workflow) and 2 (queryable completeness) to `*(met)*`; bullet 3 (framework-version absorption) remains the sole open aspiration, so FEAT-003 stays `Partial`. Applied via TASK-003 — this Task re-elaborates its own parent Feature, the deliberate recursion EPIC-006 was created to close. Additive — no previously-approved claim contradicted; status stays ELABORATED.
- **2026-05-19** — Re-elaborated following Vision v2.3 § Adaptive Coherence (commit `7c117d4`) and conceptual_design v1.4 § Responsible Promotion (commit `0411ea8`). Three aspirational Ideal State criteria added — work-item re-elaboration workflow (F1), queryable implementation completeness (F2), and framework-version absorption — that the existing capability does not yet fulfil. Initial Implementation field changed from "Retrospective" to "Partial" to reflect that aspiration now exceeds current implementation. This re-elaboration was the upstream prerequisite for creating an Epic to address F1 + F2, per the Responsible Promotion workflow.
- **2026-05-18** — ELABORATED: Feature created retrospectively. Work item types, lifecycle, templates, skill, and 20 commands were built during the Shannon v4 refactor (commit `6852b29`). This Feature codifies the capability for future evolution.
