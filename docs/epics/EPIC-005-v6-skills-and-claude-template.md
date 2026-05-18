# EPIC-005: V6 Vocabulary in Skills and CLAUDE.md Template

## Metadata

- **Status**: ELABORATED
- **Type**: Epic
- **Parent**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Created**: 2026-05-18
- **Updated**: 2026-05-18 (elaborated)

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

*To be filled during `/epic-plan EPIC-005` (Gate 2).*

### Approach

*Filled during planning.*

### Tasks

*Filled during planning — likely one task per file (4 tasks) or batched semantically.*

### Dependencies

**Depends on**: All six mandated documents APPROVED (met) — the canonical vocabulary lives upstream and is now stable

**Depended on by**: Epic B (V6 vocabulary in command files) — Epic B follows once this Epic establishes the precedents for phrasing

### Risks

*Filled during planning. Anticipated areas:*

- Over-correction (replacing "user" where it genuinely means human reader)
- Inconsistency between the four files if not reviewed together
- Reintroduction of "user" by future contributions — captured as a separate FEAT-006 risk

---

## Implementation Notes

*Filled during implementation.*

---

## Review

*Filled during review (Gate 3).*

---

## Activity Log

- **2026-05-18** — ELABORATED: Requirements filled in via `/epic-elaborate`. The elaboration subagent surveyed the four target files and surfaced a scope surprise — `work-items/skill.md` still has two `PLAN-PENDING` references that contradict technical_design v1.1 (commit `1943f3f`). Folded into this Epic's scope (Acceptance Criterion 4) since the references sit in the same paragraphs as the vocabulary work; alternative would have been a separate Epic with coordination overhead on the same file. Goal sharpened to include "no residual `*-PENDING` references". Per-file Acceptance Criteria added reflecting actual current state (15 / 12 / 16+drift / 4 occurrences). Gate 1 approved by directing party 2026-05-18 ("fold it in and apply").
- **2026-05-18** — DRAFT: Epic created from FEAT-006 § Plan candidate-Epic-A. High-level intent captured; full Requirements elaboration pending `/epic-elaborate EPIC-005`. This is the first Epic created via `/epic-create` since the framework refactor.
