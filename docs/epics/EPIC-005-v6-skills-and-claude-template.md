# EPIC-005: V6 Vocabulary in Skills and CLAUDE.md Template

## Metadata

- **Status**: PLANNED
- **Type**: Epic
- **Parent**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Created**: 2026-05-18
- **Updated**: 2026-05-23 (planned)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

### Overview

Propagate the V6 supervisor / implementer vocabulary into the four files where semantic judgement is required: the three skill definitions (`shannon/skills/project-setup/skill.md`, `shannon/skills/project-documentation/skill.md`, `shannon/skills/work-items/skill.md`) and the project-level CLAUDE.md template (`shannon/skills/project-setup/templates/CLAUDE.md`).

These files describe the framework's own behaviour — gate enforcement, self-approval prevention, the directing-party / implementer distinction. Mechanical find-and-replace would be wrong; each occurrence of "user" needs per-occurrence judgement to decide whether it means "directing party", "implementer", or genuinely "human terminal reader". The Epic is paired with **Epic B** (V6 vocabulary in command files — mechanical, 22 files, captured for future creation in FEAT-006) which can follow once this Epic's semantic precedents are set.

Elaboration surfaced an in-scope correction beyond pure vocabulary: `work-items/skill.md` still references `PLAN-PENDING` sub-statuses that technical_design v1.1 explicitly retired. Folded into this Epic since the references sit in the same paragraphs as the vocabulary work.

### Goal

The three skill definitions and the CLAUDE.md template describe gate enforcement, self-approval prevention, and the directing-party / implementer distinction using V6 vocabulary consistent with conceptual_design v1.3 and technical_design v1.1, with no residual `*-PENDING` references.

### Acceptance Criteria

- [ ] `rg "\b[Uu]sers?\b" shannon/skills/ shannon/skills/project-setup/templates/CLAUDE.md` returns only intentional "human reader" or "Target Users" occurrences; each surviving occurrence is justified in the Activity Log
- [ ] Every gate-approval sentence across the four files names the **directing party** as approver, and every self-approval-prevention sentence names the **implementer** as the agent that cannot approve its own work
- [ ] `project-documentation/skill.md § Quality Gates` and `work-items/skill.md § Quality Gates` are consistent with `conceptual_design.md` *Supervisor Distinct From Implementer* and `technical_design.md § Gate Enforcement` (convention-based, not technical-control)
- [ ] `work-items/skill.md § Process: Plan` step 3 and `§ Cascading Operations` are rewritten to match `technical_design.md § Cascading Operations: Batch Preparation, Individual Gates` — prepared-draft content stashed inside child work items, **no `*-PENDING` sub-status**
- [ ] `work-items/skill.md § Process: Implement` step 5 names the iterative zone in V6 terms ("directing party or implementer may move…")
- [ ] `templates/CLAUDE.md` lines 65, 71, 133 use directing-party / implementer vocabulary; line 25 ("target users") preserved as legitimate
- [ ] `project-setup/skill.md` distinguishes "user content" (file-merge sense, lines 69 / 83) from "directing party" (interaction sense) — both vocabularies coexist deliberately
- [ ] All four files retain their skill self-identification lines unchanged

### Context

- **Parent Feature**: [FEAT-006 § Plan, candidate-Epic-A](../features/FEAT-006-multi-party-supervision.md) — semantic, per-occurrence judgement required; paired with the future mechanical Epic B for command files
- **Vision**: Core Principle 2 ("Strategic External Review") and § Target Users — "The directing role is separable" — directing party may be human or supervising agent
- **Conceptual Design v1.3**: glossary entries *Directing Party*, *Implementer*; business rules *Three Hard Gates* and *Supervisor Distinct From Implementer*; the Key Workflows already use the V6 vocabulary as the template for skill prose
- **Technical Design v1.1**: § Gate Enforcement names the by-convention enforcement these skills implement; § Cooperative Access; § Cascading Operations specifies the `*-PENDING`-free model that `work-items/skill.md` currently contradicts
- **Files in scope** (vocabulary survey from elaboration):
  - `shannon/skills/project-setup/skill.md` — 15 "user" occurrences; mix of directing-party and legitimate "user content" senses; smallest semantic risk
  - `shannon/skills/project-documentation/skill.md` — 12 occurrences; Gate 1 line + "AI cannot self-approve" need rewording
  - `shannon/skills/work-items/skill.md` — 16 occurrences plus two `PLAN-PENDING` references that contradict technical_design v1.1 (in-scope correction beyond pure vocabulary)
  - `shannon/skills/project-setup/templates/CLAUDE.md` — 4 occurrences; mostly V6-aligned already; smallest file
- **Precedent pattern**: The document layer (vision v2.2, conceptual_design v1.3, technical_design v1.1, development_guide v1.2, ux_guide v1.1) is already V6-aligned — those files are the canonical phrasing reference for this Epic

---

## Plan

### Approach

Three Tasks, not four. The naive "one Task per file" split was rejected: it scatters AC#3 — a *cross-file consistency* criterion explicitly spanning `project-documentation/skill.md`, `work-items/skill.md`, `conceptual_design.md`, and `technical_design.md` — across two unrelated Tasks where neither owns it. The chosen breakdown groups by *kind of change* rather than by file:

1. **The two skill-definition files plus the CLAUDE.md template** (`project-setup/skill.md`, `project-documentation/skill.md`, `templates/CLAUDE.md`). All three carry the same kind of work: per-occurrence semantic vocabulary judgement, no structural rewriting. Three files, but one homogeneous editing pass — and `project-documentation/skill.md`'s § Quality Gates is one half of the AC#3 consistency pair, so it must be edited with the conceptual_design / technical_design phrasing as the explicit reference.
2. **`work-items/skill.md`** alone. This file carries the heaviest and *structurally distinct* load: V6 vocabulary **plus** the AC#4 `PLAN-PENDING` removal (a structural rewrite of § Process: Plan step 3 and § Cascading Operations to match technical_design § Cascading Operations) **plus** AC#5 (§ Process: Implement step 5 in V6 terms). Mixing structural rewrites into TASK-004's homogeneous vocabulary pass would muddy review; isolating it also confines the risk of editing this file again so soon after TASK-001 and TASK-002.
3. **Verification Task — cross-file consistency verification.** A final, deliberately separate Task that runs the AC#1 `rg` survey, audits the AC#3 four-way consistency (both skills' § Quality Gates ↔ conceptual_design *Supervisor Distinct From Implementer* ↔ technical_design § Gate Enforcement), confirms AC#8 (skill self-identification lines unchanged), and writes the Activity Log justification for every surviving "user" occurrence. This is *verification work*, not editing work; it can only run once A and B are both done, and giving it its own Task keeps the consistency check from being a rushed afterthought inside whichever editing Task happens to finish last.

Every edit to a `shannon/skills/*/skill.md` source file carries a mandatory `.claude/skills/` re-sync step (the deployed copies are gitignored and must be re-copied from `shannon/` source after each change) — see development_guide § Distribution. The CLAUDE.md *template* (`shannon/skills/project-setup/templates/CLAUDE.md`) is also re-synced as part of the `project-setup` skill's deployed copy.

Canonical phrasing reference for all Tasks: the document layer is already V6-aligned (vision v2.3, conceptual_design v1.5, technology_stack v1.2, technical_design v1.1, development_guide v1.2, ux_guide v1.1). Tasks copy phrasing from those files rather than inventing it — *directing party* approves at gates; *implementer* cannot approve its own work; enforcement is "by convention, not technical control" (technical_design § Gate Enforcement).

### Tasks

Recommended sequence: **TASK-004 → TASK-005 → the verification Task** (C depends on both A and B; A and B are independent of each other but A should land first so its vocabulary phrasing sets the precedent TASK-005's larger file follows — A is the lower-risk file set and a cheap place to settle the house style).

#### [TASK-004](../tasks/archive/TASK-004-v6-vocabulary-setup-documentation-template.md) (APPROVED) — V6 vocabulary in project-setup skill, project-documentation skill, and CLAUDE.md template

- **Files**: `shannon/skills/project-setup/skill.md`, `shannon/skills/project-documentation/skill.md`, `shannon/skills/project-setup/templates/CLAUDE.md`
- **Kind of change**: per-occurrence semantic vocabulary judgement; no structural rewrites
- **Scope**:
  - `project-setup/skill.md` (15 "user" occurrences) — replace directing-party-sense occurrences (When to Invoke, Confirm Intent, Capture Initial Vision Content, Verify, Failure Modes) with *directing party*; **preserve** the file-merge-sense "user content" at lines 69 and 83 (AC#7 — both vocabularies coexist deliberately; the audit note for this lives in the Activity Log via the verification Task)
  - `project-documentation/skill.md` (12 occurrences) — rewrite § Quality Gate (Gate 1) step 4 and § Quality Gates so the approver is named as the **directing party** and "AI cannot self-approve" becomes "the implementer cannot approve its own work"; phrasing taken directly from conceptual_design *Supervisor Distinct From Implementer* and technical_design § Gate Enforcement (this is the project-documentation half of AC#3)
  - `templates/CLAUDE.md` (4 occurrences) — lines 65, 71, 133 to directing-party / implementer vocabulary ("explicit directing-party approval"; "implementer and directing party iterate freely"); **preserve** line 25 "target users" as legitimate (AC#6)
- **ACs delivered**: AC#6 (CLAUDE.md template lines 65/71/133, line 25 preserved), AC#7 (project-setup user-content vs directing-party distinction); contributes the project-documentation half of AC#2 and AC#3
- **Re-sync obligation**: after editing the two `shannon/skills/*/skill.md` files and the template, re-copy `shannon/skills/` → `.claude/skills/` so the deployed copies match source

#### [TASK-005](../tasks/archive/TASK-005-v6-vocabulary-and-plan-pending-work-items-skill.md) (APPROVED) — V6 vocabulary and PLAN-PENDING removal in work-items skill

- **File**: `shannon/skills/work-items/skill.md` (only)
- **Kind of change**: per-occurrence vocabulary judgement **plus** structural rewrite (the `PLAN-PENDING` removal)
- **Scope**:
  - Vocabulary sweep across the 16 "user" occurrences — directing-party sense in Process steps, Gate approvals, Failure Modes
  - § Quality Gates — "Explicit user approval" → directing-party; "AI never self-approves across a gate" → "the implementer never approves its own work across a gate" (the work-items half of AC#3, consistent with conceptual_design *Supervisor Distinct From Implementer* and technical_design § Gate Enforcement)
  - **AC#4 structural rewrite**: § Process: Plan step 3 ("Cascading Preparation") and step 5, and § Cascading Operations — remove all `PLAN-PENDING` / `*-PENDING` references; rewrite to the *Batch Preparation, Individual Gates* model from technical_design § Cascading Operations: children are created in DRAFT with *prepared elaboration / plan drafts stashed inside the child files* (marked "prepared during EPIC-XXX planning, not yet reviewed"), surfaced when each child's own gate command runs. No new sub-statuses. Must match technical_design's wording, not paraphrase loosely
  - **AC#5**: § Process: Implement step 5 — "The user or AI may move the work item back to IMPLEMENTING…" → "The directing party or implementer may move…" naming the iterative zone in V6 terms
  - Leave the existing **Re-elaboration Branch** (TASK-001) and **Feature `(Partial)` index-suffix** language (TASK-002) untouched — both are already V6-clean ("directing party"); confirm, do not re-edit
- **ACs delivered**: AC#4 (PLAN-PENDING removal), AC#5 (Implement step 5); contributes the work-items half of AC#2 and AC#3
- **Re-sync obligation**: after editing, re-copy `shannon/skills/work-items/` → `.claude/skills/work-items/`

#### [TASK-006](../tasks/archive/TASK-006-cross-file-v6-consistency-verification.md) (APPROVED) — Cross-file V6 consistency verification

- **Files**: read-only audit across all four in-scope files plus `conceptual_design.md` and `technical_design.md`; writes only to EPIC-005's Activity Log (and may surface inline corrections back to TASK-004 or TASK-005 if a defect is found)
- **Kind of change**: verification, not editing
- **Scope**:
  - Run `rg "\b[Uu]sers?\b" shannon/skills/ shannon/skills/project-setup/templates/CLAUDE.md` — every surviving occurrence must be intentional "human reader" or "Target Users"; **record the justification for each in EPIC-005's Activity Log** (AC#1)
  - Audit AC#2 — every gate-approval sentence across all four files names the *directing party* as approver; every self-approval-prevention sentence names the *implementer* as the agent that cannot approve its own work
  - Audit AC#3 — `project-documentation/skill.md § Quality Gates` and `work-items/skill.md § Quality Gates` are mutually consistent **and** consistent with conceptual_design *Supervisor Distinct From Implementer* and technical_design § Gate Enforcement (convention-based, not technical-control)
  - Confirm AC#8 — all four files retain their skill self-identification lines unchanged ("Activating … skill." / "Activating work-items skill for [type] [verb].")
- **ACs delivered**: AC#1 (rg survey + Activity Log justifications), AC#2 (cross-file gate-sentence consistency), AC#3 (four-way consistency), AC#8 (self-identification lines unchanged)
- **Re-sync obligation**: none (no source edits) unless the audit surfaces a defect requiring a fix — in which case re-sync the corrected skill

**AC coverage check** — all 8 Acceptance Criteria are assigned:

| AC | Delivered by |
|---|---|
| AC#1 — `rg` survey, only intentional occurrences, each justified in Activity Log | the verification Task |
| AC#2 — gate-approval names directing party; self-approval-prevention names implementer | TASK-004 + TASK-005 (per-file edits), verified by the verification Task |
| AC#3 — both § Quality Gates consistent with conceptual_design + technical_design | TASK-004 (project-documentation half) + TASK-005 (work-items half), four-way consistency verified by the verification Task |
| AC#4 — `work-items` § Process: Plan step 3 + § Cascading Operations, no `*-PENDING` | TASK-005 |
| AC#5 — `work-items` § Process: Implement step 5 in V6 terms | TASK-005 |
| AC#6 — `templates/CLAUDE.md` lines 65/71/133; line 25 preserved | TASK-004 |
| AC#7 — `project-setup` "user content" vs "directing party" distinction | TASK-004 |
| AC#8 — all four files retain skill self-identification lines unchanged | the verification Task (verification) |

### Child Task Creation

**Recommendation: do NOT pre-create the three child Tasks as stubbed DRAFTs.** Option-b cascading (DRAFT children with stashed prepared drafts) earns its keep when a parent fans out into many children whose elaboration is non-trivial and benefits from being drafted while the parent's context is hot. Here there are only three Tasks, each already fully scoped *in this Plan section* — pre-creating stubs would duplicate that content into three files with no added clarity, and the stale-draft risk (technical_design § Cascading Operations trade-off) is real given `work-items/skill.md` is a fast-moving file. Create each Task individually via `/task-create` when it is ready to be scheduled, carrying its scope verbatim from the table above. the verification Task in particular should not be created until TASK-004 and TASK-005 are APPROVED, so its `rg` survey runs against final text.

### Dependencies

**Depends on**: All six mandated documents APPROVED (met) — the canonical vocabulary lives upstream and is now stable. Note specifically: conceptual_design v1.5 (*Directing Party* / *Implementer* glossary, *Supervisor Distinct From Implementer* rule) and technical_design v1.1 (§ Gate Enforcement, § Cascading Operations: Batch Preparation, Individual Gates — the `*-PENDING`-free model AC#4 must match) are the load-bearing references and are both APPROVED.

**Internal sequencing**: the verification Task depends on TASK-004 **and** TASK-005 (it audits their output). TASK-004 and TASK-005 are independent but TASK-004 is recommended first to set the vocabulary precedent for the larger file.

**Depended on by**: Epic B (V6 vocabulary in command files) — Epic B follows once this Epic establishes the precedents for phrasing.

### Risks

- **Over-correction** — replacing "user" where it genuinely means a human terminal reader, or where it means file-merge "user content" rather than the interaction role. *Mitigation*: AC#7 explicitly carves out the `project-setup` "user content" sense; TASK-004's scope names lines 69/83 as preserve-list; the verification Task's `rg` survey is the backstop, with every surviving occurrence justified in writing in the Activity Log so over-correction *and* under-correction both surface.
- **Four-file inconsistency** — the same gate concept worded differently across the four files if they are edited in isolation. *Mitigation*: a single canonical phrasing reference (the document layer) is mandated for all Tasks; the verification Task exists specifically to verify the four-way consistency (AC#2, AC#3) as a dedicated step rather than trusting each editing Task to self-check.
- **Vocabulary creep-back** — future contributions reintroducing "user" where "directing party" is correct. *Mitigation*: out of scope for fixing here (it is a standing FEAT-006 risk), but the `rg` command in AC#1 is reusable as a lint check and should be noted as such in the verification Task's Activity Log entry so future reviewers have a one-line verification.
- **`PLAN-PENDING` rewrite drifting from technical_design** — AC#4 requires `work-items/skill.md` to *match* technical_design § Cascading Operations, not merely remove the token. A loose paraphrase that drops `*-PENDING` but invents different mechanics would be new drift. *Mitigation*: TASK-005's scope mandates copying the *Batch Preparation, Individual Gates* mechanics (DRAFT children + stashed prepared drafts surfaced at each child's gate) directly from technical_design; the verification Task's AC#3 audit cross-checks the result against that section.
- **Editing `work-items/skill.md` again so soon after TASK-001 and TASK-002** — this file has been changed twice recently (Re-elaboration Branch, `(Partial)` index suffix); a third edit risks colliding with or accidentally reverting that recent work. *Mitigation*: TASK-005's scope explicitly instructs leaving the Re-elaboration Branch and index-suffix language untouched (confirm-only); isolating `work-items/skill.md` in its own Task (not batched into TASK-004) keeps its diff small and reviewable.
- **Re-sync omission** — editing `shannon/` source but forgetting to refresh the gitignored `.claude/skills/` deployed copies leaves the running framework stale. *Mitigation*: every editing Task (TASK-004 and TASK-005) carries an explicit re-sync step in its scope; the verification Task can spot a divergence if it runs its audit against the deployed copies.

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-23** — **EPIC-005 cross-file V6 consistency verification — audit complete (TASK-006, Step 9).** Single canonical entry recording the four audit conclusions that close EPIC-005's AC#1 / AC#2 / AC#3 / AC#8 at this Epic's own Gate 3.

  **(i) `[Uu]sers?` survey across the four target files.** `rg "\b[Uu]sers?\b"` returns exactly 4 preserve-sense matches: `project-setup/skill.md:69` (`do not overwrite user content`, file-merge sense — AC#7); `project-setup/skill.md:83` (`Preserve any existing user content`, file-merge sense — AC#7); `project-setup/skill.md:93` (`Target Users`, Vision-template section heading — TASK-004 preserve-list); `templates/CLAUDE.md:25` (`target users`, Vision document content description — AC#6, line 25 explicitly preserved). `project-documentation/skill.md` and `work-items/skill.md` return zero. Every surviving occurrence is intentional. **Closes AC#1.**

  **(ii) Gate-approval / self-approval-prevention sentences.** Every gate-approval sentence across the four files names the *directing party* as approver; every self-approval-prevention sentence names the *implementer* as the agent that cannot approve its own work. `project-setup/skill.md` and `templates/CLAUDE.md` carry no self-approval-prevention sentence by design — gate enforcement lives in the skills that own gate transitions (`project-documentation` and `work-items`). **Closes AC#2.**

  **(iii) Four-way § Quality Gates phrase-level equivalence.** `project-documentation/skill.md` line 132 (combined Gate-1 bullet) and `work-items/skill.md` lines 271–275 (three Gate bullets + standalone implementer sentence) carry the verbatim TASK-004 house phrases: "Explicit approval by the directing party"; "The implementer cannot approve its own work". Both are consistent with conceptual_design v1.5 *Supervisor Distinct From Implementer* / *Three Hard Gates* and technical_design v1.1 § Gate Enforcement ("by convention, not technical control"). The bullet-structure variance is **structurally required** — each skill enumerates only the gates it owns (`project-documentation` owns Gate 1 only; `work-items` owns Gates 1/2/3) — not a cross-file inconsistency. **Closes AC#3.**

  **(iv) Self-identification lines unchanged.** All six instances verbatim: `project-setup/skill.md:8` and `:125` (`"Activating project-setup skill."`); `project-documentation/skill.md:8` and `:142` (`"Activating project-documentation skill."`); `work-items/skill.md:8` and `:298` (`"Activating work-items skill for [type] [verb]."`). **Closes AC#8.**

  **Two TASK-005 Gate 3 cross-check flags resolved at audit**: the `work-items/skill.md` line 227 *Iterative Implementation Zone* phrasing nit survives under route (a) (V6-compatible wording, loose-AC precedent at TASK-005's Gate 3); the bullet-structure variance is structurally required, not a defect. **No defect surfaced** — Step 8 (conditional inline correction + `.claude/skills/` re-sync) did not trigger; no `shannon/` source file was modified by TASK-006. EPIC-005's own Gate 3 can verify AC#1 / AC#2 / AC#3 / AC#8 from this single entry. Full audit details preserved in TASK-006 (archived on approval).

- **2026-05-23** — PLANNED via Gate 2. Planning subagent drafted the Plan — three Tasks grouped by kind of change rather than one per file: TASK-004 (project-setup + project-documentation skills + CLAUDE.md template — homogeneous vocabulary judgement; AC#6, AC#7), TASK-005 (`work-items/skill.md` — vocabulary sweep + the AC#4 `PLAN-PENDING` structural rewrite + AC#5; leaving TASK-001's Re-elaboration Branch and TASK-002's index-suffix language untouched), the verification Task (cross-file verification audit; AC#1, AC#2, AC#3, AC#8). Sequenced TASK-004 → TASK-005 → the verification Task — TASK-004 sets the vocabulary precedent on the lower-risk files, the verification Task audits the final text of both. All 8 Acceptance Criteria mapped to Tasks; 6 risks with mitigations. Child Tasks to be created individually (not pre-stashed as DRAFT stubs) — only three children, each fully scoped in the Plan, and `work-items/skill.md` moves fast enough that stashed drafts would risk staleness. Plan approved by directing party without modification.
- **2026-05-18** — ELABORATED: Requirements filled in via `/epic-elaborate`. The elaboration subagent surveyed the four target files and surfaced a scope surprise — `work-items/skill.md` still has two `PLAN-PENDING` references that contradict technical_design v1.1 (commit `1943f3f`). Folded into this Epic's scope (Acceptance Criterion 4) since the references sit in the same paragraphs as the vocabulary work; alternative would have been a separate Epic with coordination overhead on the same file. Goal sharpened to include "no residual `*-PENDING` references". Per-file Acceptance Criteria added reflecting actual current state (15 / 12 / 16+drift / 4 occurrences). Gate 1 approved by directing party 2026-05-18 ("fold it in and apply").
- **2026-05-18** — DRAFT: Epic created from FEAT-006 § Plan candidate-Epic-A. High-level intent captured; full Requirements elaboration pending `/epic-elaborate EPIC-005`. This is the first Epic created via `/epic-create` since the framework refactor.
