# TASK-001: Re-elaborating a Work Item — Workflow and Skill Extension

## Metadata

- **Status**: PLANNED
- **Type**: Task
- **Parent**: [EPIC-006](../epics/EPIC-006-work-item-lifecycle-maturation.md)
- **Feature**: [FEAT-003](../features/FEAT-003-unified-work-item-model.md)
- **Tags**: #framework #conceptual-design #work-items #v6
- **Created**: 2026-05-19
- **Updated**: 2026-05-20 (planned)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-006 § Plan (Gate 2). Not yet reviewed at Gate 1. Surfaces when `/task-elaborate TASK-001` is invoked.*

### Overview

Ratify the canonical re-elaboration workflow for work items. Add a *Re-elaborating a Work Item* section to `docs/conceptual_design.md` § Key Workflows, modelled on the existing *Re-reviewing an APPROVED Mandated Document* workflow (lines 227-256). Extend `shannon/skills/work-items/skill.md` § Process: Elaborate to recognise re-elaboration as a first-class branch, so that `/feature-elaborate` (or `/epic-elaborate`, `/task-elaborate`, `/spike-elaborate`) on an already-ELABORATED work item enters the re-elaboration flow rather than failing or silently re-running.

Closes the gap conceptual_design v1.4 § Responsible Promotion step 5 explicitly flagged: *"canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap."*

**Scope boundary**: This Task delivers the canonical workflow text and the skill extension. Live application of the new workflow to FEAT-003 and FEAT-006 (recursive dogfood) belongs to EPIC-006's forward-declared follow-up Task, not this one.

### Acceptance Criteria

- [ ] `docs/conceptual_design.md` § Key Workflows contains a *Re-elaborating a Work Item* workflow with parallel sub-section ordering matching *Re-reviewing an APPROVED Mandated Document*: **Goal / Triggers / Flow (numbered) / Status semantics / Rules applied** (sharpened — reviewers can mechanically check parity)
- [ ] Triggers explicitly enumerate upstream cascade, downstream gap, framework evolution (paralleling but adapted from the document re-review triggers)
- [ ] Status semantics distinguish additive re-elaboration (work item stays at current status) from substantive re-elaboration (work item transitions back to DRAFT); substantive re-elaboration's gate re-pass rules are explicit — at minimum naming which gates re-pass and which prior approvals are preserved (sharpened)
- [ ] Status semantics enumerate behaviour for **each non-DRAFT status** (ELABORATED, PLANNED, IMPLEMENTING, IMPLEMENTED, REVIEW, APPROVED) under both additive and substantive re-elaboration — naming which gates re-pass and which prior approvals are preserved at each status (new — closes the asymmetry with documents which have only one post-DRAFT status)
- [ ] Workflow text explicitly confirms applicability across all four work-item types (Feature, Epic, Task, Spike), noting any type-specific deviations (e.g. Spikes standalone vs hierarchical parents; Features have no upstream work-item parent; orphan Tasks) (new — prevents implicit cross-type semantics)
- [ ] The workflow's Flow step that produces structured findings names the canonical four-category schema (Drift / Gap / Internal contradiction / Strength), matching *Re-reviewing an APPROVED Mandated Document* step 3 (new — parity with canonical document re-review pattern)
- [ ] `shannon/skills/work-items/skill.md` § Process: Elaborate gains an explicit re-elaboration branch (sibling to the DRAFT → ELABORATED path); the existing § Failure Modes "Wrong status for verb" entry (line 273) updated so `*-elaborate` on a non-DRAFT work item enters re-elaboration rather than erroring
- [ ] The Activity Log entry pattern for re-elaboration is documented in the workflow, naming three required fields: **(a) trigger category, (b) upstream commit hash where applicable, (c) summary of what changed** — matching the precedent set by FEAT-003's 2026-05-19 entry (sharpened)

### Context

- **Parent Epic**: [EPIC-006 — Work Item Lifecycle Maturation](../epics/EPIC-006-work-item-lifecycle-maturation.md), specifically the F1 Acceptance Criteria group
- **Parent Feature**: [FEAT-003 — Unified Work Item Model](../features/FEAT-003-unified-work-item-model.md), aspirational Ideal State bullet 1 (added 2026-05-19)
- **Precedent pattern**: `conceptual_design.md` § *Re-reviewing an APPROVED Mandated Document* (lines 227-256) — same shape, adapted from documents to work items
- **Related workflow**: `conceptual_design.md` § *Responsible Promotion* (lines 258-285) — this Task closes the gap step 5 of that workflow flags
- **Files in scope**:
  - `docs/conceptual_design.md` (add new workflow + version bump; also remove the "canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap" parenthetical from § Responsible Promotion step 5 at line 279, since this Task ratifies it)
  - `shannon/skills/work-items/skill.md` (§ Process: Elaborate ~lines 120-153 and § Failure Modes ~lines 271-276 — re-elaboration as first-class branch)
- **Prior dogfood**: FEAT-006's re-elaboration (commit `211ebea`) and FEAT-003's re-elaboration (commit `e2198bc`) were ad-hoc applications of this not-yet-canonical workflow. The shape that worked there is the candidate canonical shape

---

## Plan

### Approach

Single-session, conceptual_design-first. The canonical workflow text lands in `docs/conceptual_design.md` § Key Workflows before any skill edits, because the skill change is a thin mechanical pointer: once the canonical Goal / Triggers / Flow / Status semantics / Rules applied block exists, the skill only needs to recognise the re-elaboration branch and defer semantics to the doc. Reversing the order would force the skill to encode workflow prose that should live in conceptual_design, violating *Single source of truth per concept* (development_guide § Code Style).

The work breaks into three blocks: (1) conceptual_design new workflow section + gap-flag removal + v1.5 version-history entry; (2) skill.md § Process: Elaborate re-elaboration branch and § Failure Modes update; (3) cross-file dry-run plus pre-commit checklist. No code, no build — Markdown-only edits exercised via mental dry-run (development_guide § Testing Strategy → Template review + Dogfood pass).

### Steps

1. **Draft *Re-elaborating a Work Item* section** in `docs/conceptual_design.md` immediately after § *Re-reviewing an APPROVED Mandated Document* (after line 256, before § *Responsible Promotion*). Use the exact five-heading order **Goal / Triggers / Flow (numbered) / Status semantics / Rules applied** for mechanical parity. **AC#1.**
2. **Populate Triggers** with three named entries adapted from the document precedent: *upstream cascade* (parent work item or mandated doc just changed), *downstream gap* (child work item or review surfaced a missing anchor), *framework evolution* (Shannon version introduces an attribute existing items must accommodate). **AC#2.**
3. **Populate Flow** as a numbered list whose findings step names the canonical four-category schema *Drift / Gap / Internal contradiction / Strength*, matching the document precedent's step 3 verbatim. Include an explicit step for the Activity Log entry. **AC#6.**
4. **Populate Status semantics** with two paragraphs (additive vs substantive) followed by a small table or bullet list enumerating behaviour at each of the six non-DRAFT statuses (ELABORATED, PLANNED, IMPLEMENTING, IMPLEMENTED, REVIEW, APPROVED) — naming which gates re-pass and which prior approvals are preserved in both the additive and substantive cases. **AC#3, AC#4.**
5. **Add a cross-type applicability paragraph** at the end of Status semantics (or as a trailing bullet under Rules applied) calling out: Features have no upstream work-item parent (only documents); Spikes are standalone so upstream cascade is the only relevant trigger; orphan Tasks behave as Features for trigger purposes. **AC#5.**
6. **Document the Activity Log entry pattern** as part of the Flow step (sub-bullets under the relevant step), naming the three required fields verbatim: *(a) trigger category, (b) upstream commit hash where applicable, (c) summary of what changed*. **AC#8.**
7. **Remove the gap-flag parenthetical** from `docs/conceptual_design.md` § *Responsible Promotion* step 5 (line 279): delete `"(canonical work-item re-elaboration workflow not yet ratified — captured as a framework gap)"` and rewrite step 5 to point at the new workflow by section name. Cross-file consistency: the new workflow's Triggers must include the *downstream gap* case that step 5 will route into.
8. **Append v1.5 Version History entry** to `docs/conceptual_design.md` describing the additive amendment (per its own new Status semantics — non-contradictory addition, doc stays APPROVED). Bump Last Reviewed date.
9. **Add re-elaboration branch to `shannon/skills/work-items/skill.md` § Process: Elaborate** (after current step 5 *Resume*, around line 153). New sub-section: "### Re-elaboration Branch (non-DRAFT input)" — short prose pointing the implementer at conceptual_design § *Re-elaborating a Work Item* for semantics, naming the three triggers, and stating that the elaboration subagent's draft replaces *Requirements* additively or transitions the item back to DRAFT per the canonical Status semantics. Do not duplicate the per-status table — reference it. **AC#7.**
10. **Update § Failure Modes "Wrong status for verb" entry** (line 273): change the example from a `/task-plan`-on-DRAFT error to one that still errors (e.g. `/task-plan` on DRAFT remains an error) and add a sentence: "Conversely, `*-elaborate` on a non-DRAFT work item is *not* an error — it enters the re-elaboration branch (see § Process: Elaborate)." **AC#7.**
11. **Cross-file consistency dry-run**: re-read the new conceptual_design section and the skill changes side-by-side. Verify (a) the skill does not contradict the per-status table; (b) every Trigger named in conceptual_design appears in the skill's branch prose; (c) British spelling throughout (development_guide § Code Style → Markdown); (d) heading hierarchy correct, no skipped levels; (e) no stale references to "PENDING" sub-statuses or `code_style_guide.md` introduced.
12. **Pre-Commit Checklist** (development_guide § Testing Strategy): templates render; no stale references; cross-references resolve (line numbers updated if needed); mental dry-run of `/feature-elaborate FEAT-003` against the new branch confirms FEAT-003's 2026-05-19 ad-hoc re-elaboration matches the canonical shape.

### Dependencies

- **None blocking.** No upstream Shannon work outside this Task is required; proceeds in parallel with TASK-002 per EPIC-006's plan.
- **Soft coupling**: EPIC-006's forward-declared follow-up Task (live application to FEAT-003 / FEAT-006) consumes this Task's output. Out of scope here.
- **Reference integrity**: line numbers cited in Steps 1, 7, 9, 10 are accurate at 2026-05-19; the implementer must re-resolve them at edit time since this commit's own edits will shift line numbers in conceptual_design.

### Risks

- **Protocol overload** — re-elaboration must be an explicit sibling branch in § Process: Elaborate, not an overload of the DRAFT → ELABORATED path. Mitigation: Step 9 adds a separately-headed sub-section rather than amending the existing numbered flow.
- **Workflow asymmetry with documents** — work items span six non-DRAFT statuses vs documents' one (APPROVED). The additive-vs-substantive mapping is not 1:1. Mitigation: Step 4 produces an explicit per-status table.
- **Parity drift between the new workflow and its precedent** — if the new section diverges in shape from § *Re-reviewing an APPROVED Mandated Document*, reviewers cannot mechanically check parity (AC#1). Mitigation: Step 1 fixes the heading order; Step 3 uses the same four-category schema vocabulary.
- **Skill prose vs conceptual_design prose tension** — duplicating semantics in skill.md risks divergence over time. Mitigation: Step 9 keeps the skill prose thin and refers to the doc for semantics (Single source of truth per concept).
- **Stale line numbers across the two-file edit** — Step 7 removes content from conceptual_design while Steps 1-6 add content; line numbers in the Task file's Context block will not match the post-edit file. Mitigation: do not rely on line numbers during implementation; navigate by section headers.

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-20** — PLANNED via Gate 2. Plan section populated: single-session, conceptual_design-first ordering (canonical workflow text lands in the doc before the skill extension, preserving *Single source of truth per concept* from development_guide § Code Style). 12 ordered steps split into three blocks — doc work (Steps 1-8: draft workflow section with parallel sub-section ordering, three Triggers, Flow with four-category schema, per-status table, cross-type paragraph, Activity Log field naming, gap-flag removal at line 279, v1.5 version-history entry); skill work (Steps 9-10: re-elaboration branch in § Process: Elaborate, § Failure Modes update); verification (Steps 11-12: cross-file consistency dry-run, Pre-Commit Checklist). Each step explicitly annotated with the AC(s) it covers. Five risks captured with mitigations tied to numbered steps. Subagent verdict: ready for Gate 2 approval; no drift against Development Guide or Technical Design; all 8 ACs have step-coverage. Approved by directing party 2026-05-20.
- **2026-05-19** — ELABORATED via Gate 1. Elaboration verified the pre-stashed Requirements against current upstream state (precedent workflow at conceptual_design.md lines 227-256; work-items skill § Process: Elaborate at lines 120-153; § Failure Modes at line 273). Refinements applied:
  - 3 new Acceptance Criteria — four-category schema parity in the Flow step (matching the document re-review precedent); per-status enumeration across the six non-DRAFT statuses (closes the asymmetry with documents which have only one post-DRAFT status); cross-type applicability statement (prevents implicit Feature / Epic / Task / Spike semantics)
  - 3 sharpenings — parallel sub-section ordering specified for parity-checking (AC#1); explicit gate re-pass rules in the substantive case (AC#3); three named Activity-Log fields for the workflow's documented pattern (AC#8)
  - Scope boundary added to Overview: this Task delivers canonical text only; live application to FEAT-003 / FEAT-006 belongs to EPIC-006's forward-declared follow-up Task
  - Context Files-in-scope: added note that the "(not yet ratified)" parenthetical at conceptual_design line 279 will be removed by this Task
  No drift against upstream; all cited line ranges and commit hashes still resolve. Verdict from elaboration verification: ready with minor refinements; refinements applied.
- **2026-05-19** — DRAFT: Task created via EPIC-006's planning (option-b cascading pattern). Requirements section pre-stashed; will surface when `/task-elaborate TASK-001` is invoked. Plan section deferred to `/task-plan`.
