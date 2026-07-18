# TASK-026: preCompact Findings-Snapshot Hook

## Metadata

- **Status**: DRAFT
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #hook #precompact #context-compaction
- **Created**: 2026-07-18
- **Updated**: 2026-07-18

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-elaborate TASK-026` (Gate 1).*

### Overview

Implement the preCompact hook — body + registration snippet authored in `./shannon/`, deployed/merged to `./.claude/` — that snapshots in-flight findings to a disk location named in `SKILL.md` when a long `/shannon-report` run approaches context compaction, so the findings survive and are automatically flushed into the report at write time. Inert outside a supervisor-scoped run (per the `SHANNON_SUPERVISOR_SCOPE` convention). Logic unit-tested before commit; live auto-firing deferred to EPIC-011. Out of scope: the SessionStart hook (TASK-025), the already-shipped PreToolUse/PostToolUse hooks.

### Acceptance Criteria

- [ ] **AC#1 — Hook body + registration snippet authored in `./shannon/`; live `settings.json` wired.** Body at `./shannon/skills/shannon-supervisor/scripts/precompact-snapshot.sh`; tracked snippet at `./shannon/skills/shannon-supervisor/hooks/precompact.settings.json`; `SKILL.md` § Hook Integration additively updated (preCompact row now implemented); deployed to `./.claude/` and merged into live `./.claude/settings.json`. *Derives from* `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Hook integration* (preCompact row); EPIC-009 TASK-016/017 hook precedent + shipping-source DECISION.
- [ ] **AC#2 — Snapshot location named in `SKILL.md`.** `SKILL.md` names the snapshot file path under `./.claude/skills/shannon-supervisor/` (a gitignored operational artefact, consistent with the audit-log location precedent from EPIC-009 AC#5). *Derives from* parent EPIC-010 AC#4; EPIC-009 audit-log-location precedent (`SKILL.md` § Hook Integration).
- [ ] **AC#3 — Snapshot incorporated at report write-time.** `SKILL.md` § Report Pipeline is additively extended so any preCompact snapshot is flushed into the report during the assemble-and-write step. *Derives from* parent EPIC-010 AC#4; EPIC-009 `SKILL.md` § Report Pipeline.
- [ ] **AC#4 — Inert outside supervisor scope; unit-tested before commit.** The hook fires only when `SHANNON_SUPERVISOR_SCOPE` is set (a long `/shannon-report` run); inert otherwise. Logic unit-tested before commit: (a) signal present → snapshot written; (b) signal absent → no-op. *Derives from* EPIC-009 § Implementation Notes *SHANNON_SUPERVISOR_SCOPE* convention; `development_guide.md` v1.4 § Testing Strategy + global test-before-commit rule.
- [ ] **AC#5 — Plain-prose discipline + scope-bounded edit.** Grep-verified phrases as plain prose (parent AC#7); creates the preCompact script + snippet + additive `SKILL.md` § Hook Integration / § Report Pipeline edits only — does **not** modify the other hooks, checkers, templates, the goal-skill/command, or any other skill (cross-type-guard, parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary…Cross-Type Guards*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Five Claude Code hook integration points* (preCompact half)
- **Relevant documents**: `technical_design.md` § System Architecture → *Supervisor* → *Hook integration*; Phase-0 Spike § 11 (Context Compaction & Memory)
- **Related work**: EPIC-009 hook precedent (TASK-016/017) + audit-log-location precedent (AC#5) + `SKILL.md` § Report Pipeline

---

## Plan

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-plan TASK-026` (Gate 2).*

### Approach

Author in `./shannon/`, deploy/wire to `./.claude/`. Body checks `SHANNON_SUPERVISOR_SCOPE` (inert if absent), else writes the in-flight findings buffer to the named snapshot path; additively extend § Report Pipeline to flush the snapshot at write time. Unit-test snapshot-on-signal / inert-without before commit.

### Steps

1. Author `precompact-snapshot.sh` (inert gate; snapshot write to the named path).
2. Name the snapshot location in `SKILL.md` § Hook Integration; additively extend § Report Pipeline for write-time flush.
3. Author `precompact.settings.json` snippet.
4. Deploy body + snippet to `./.claude/`; merge live `settings.json`; `diff`.
5. Unit-test the two cases (AC#4).
6. Plain-prose grep.
7. `git diff` scope check.

### Dependencies

- EPIC-009 APPROVED (§ Report Pipeline to extend + `SKILL.md` skeleton). Independent of SessionStart/goal-skill. Live auto-firing → EPIC-011.

### Risks

- Snapshot written but never flushed — mitigated by AC#3 making write-time incorporation explicit + unit test.
- Snapshot artefact accidentally tracked — mitigated by placing it under the blanket-gitignored `./.claude/` (audit-log precedent).
- Runtime auto-firing unverified — honestly deferred to EPIC-011.

---

## Implementation Notes

*Filled during implementation.*

### Deviations from Plan

- *None yet.*

### Gotchas

- *None yet.*

### Documents Updated

- *None yet.*

---

## Review

*Filled during review (Gate 3).*

### Verification

- [ ] All acceptance criteria met
- [ ] Code follows development_guide.md
- [ ] Tests added or updated, passing
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

*Filled at Gate 3.*

---

## Activity Log

- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation). Covers EPIC-010 AC#4. Snapshot location stays in `SKILL.md` per EPIC-009's audit-log precedent (no `technical_design.md` amendment). Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-026` (Gate 1) and `/task-plan TASK-026` (Gate 2).
