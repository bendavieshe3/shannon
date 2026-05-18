# EPIC-005: V6 Vocabulary in Skills and CLAUDE.md Template

## Metadata

- **Status**: DRAFT
- **Type**: Epic
- **Parent**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Created**: 2026-05-18
- **Updated**: 2026-05-18

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Approved epics remain as historical records of how the parent feature evolved.

---

## Requirements

*To be filled during `/epic-elaborate EPIC-005` (Gate 1). The high-level intent below is captured at creation time as a placeholder.*

### Overview

Propagate the V6 supervisor / implementer vocabulary into the four files where semantic judgement is required: the three skill definitions (`shannon/skills/project-setup/skill.md`, `shannon/skills/project-documentation/skill.md`, `shannon/skills/work-items/skill.md`) and the project-level CLAUDE.md template (`shannon/skills/project-setup/templates/CLAUDE.md`).

These files describe the framework's own behaviour — gate enforcement, self-approval prevention, the directing-party / implementer distinction. Mechanical find-and-replace would be wrong; each occurrence of "user" needs per-occurrence judgement to decide whether it means "directing party", "implementer", or genuinely "human terminal reader". The Epic is paired with **Epic B** (V6 vocabulary in command files — mechanical, 22 files, captured for future creation in FEAT-006) which can follow once this Epic's semantic precedents are set.

### Goal

*Filled during elaboration.*

### Acceptance Criteria

*Filled during elaboration. Provisional starting point from FEAT-006 § Epics:*

- [ ] `rg "\buser\b" shannon/skills/ shannon/skills/project-setup/templates/CLAUDE.md` returns only intentional "human reader" occurrences
- [ ] Every gate-related sentence in the four files uses directing-party / implementer vocabulary correctly
- [ ] The four files are consistent with `technical_design.md § Gate Enforcement` and `conceptual_design.md § Supervisor Distinct From Implementer`

### Context

*Filled during elaboration. Initial pointers:*

- **Parent Feature**: [FEAT-006 — Multi-Party Supervision](../features/FEAT-006-multi-party-supervision.md), specifically the candidate-Epic-A description in its Plan section
- **Vision**: Core Principle 2 ("Strategic External Review")
- **Conceptual Design**: *Supervisor Distinct From Implementer* business rule; *Directing Party* and *Implementer* glossary entries; *Three Hard Gates* rule
- **Technical Design**: § Gate Enforcement (the by-convention semantics this Epic implements at the skill layer)
- **Files in scope**:
  - `shannon/skills/project-setup/skill.md`
  - `shannon/skills/project-documentation/skill.md`
  - `shannon/skills/work-items/skill.md`
  - `shannon/skills/project-setup/templates/CLAUDE.md`

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

- **2026-05-18** — DRAFT: Epic created from FEAT-006 § Plan candidate-Epic-A. High-level intent captured; full Requirements elaboration pending `/epic-elaborate EPIC-005`. This is the first Epic created via `/epic-create` since the framework refactor.
