# TASK-006: Cross-File V6 Consistency Verification

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-005](../epics/EPIC-005-v6-skills-and-claude-template.md)
- **Feature**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Tags**: #framework #v6 #verification #skills
- **Created**: 2026-05-23
- **Updated**: 2026-05-23 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

### Overview

TASK-006 is the final Task of EPIC-005's three-Task plan and the last work item before EPIC-005's own Gate 3. It is **pure verification work, not editing** — a cross-file audit confirming that the post-TASK-004 / post-TASK-005 state of the four EPIC-005 files (the three skills + the CLAUDE.md template) is mutually consistent at the phrase level and tracks the canonical sources (conceptual_design v1.5 — *Directing Party* / *Implementer* glossary, *Three Hard Gates*, *Supervisor Distinct From Implementer*, *Iterative Implementation Zone*; technical_design v1.1 — § Gate Enforcement, § Cascading Operations).

The Task was deliberately deferred until [TASK-004](archive/TASK-004-v6-vocabulary-setup-documentation-template.md) and [TASK-005](archive/TASK-005-v6-vocabulary-and-plan-pending-work-items-skill.md) were both APPROVED — its `rg` survey and consistency audit must run against final text, not work-in-progress. Both editing Tasks are APPROVED and archived (both 2026-05-23); this audit runs against final text and closes the four cross-file EPIC-005 ACs (AC#1, AC#2, AC#3, AC#8) by writing a single conclusion entry into EPIC-005's Activity Log.

A preliminary `rg "\b[Uu]sers?\b"` and `rg "PENDING"` survey of the four target files was run at elaboration. Findings:

- **`[Uu]sers?` survey — 4 matches**, all on the preserve-list named by TASK-004 / EPIC-005:
  - `shannon/skills/project-setup/skill.md:69` — `do not overwrite user content` (file-merge sense; EPIC-005 AC#7)
  - `shannon/skills/project-setup/skill.md:83` — `Preserve any existing user content` (file-merge sense; EPIC-005 AC#7)
  - `shannon/skills/project-setup/skill.md:93` — `Target Users` (Vision-template section heading; per TASK-004's three-occurrence preserve-list at lines 69/83/93)
  - `shannon/skills/project-setup/templates/CLAUDE.md:25` — `target users` (Vision document content description; EPIC-005 AC#6, line 25 explicitly preserved)
  - `project-documentation/skill.md` — **zero** matches; `work-items/skill.md` — **zero** matches.
- **`PENDING` survey** — zero matches across all four files (TASK-005 cleared all three `PLAN-PENDING` locations: lines 190 / 200 / 282 pre-edit).
- **Self-identification lines** — all six instances verbatim: `project-setup/skill.md` lines 8 + 125 (`"Activating project-setup skill."`); `project-documentation/skill.md` lines 8 + 142 (`"Activating project-documentation skill."`); `work-items/skill.md` lines 8 + 298 (`"Activating work-items skill for [type] [verb]."`).
- **Quality Gates phrase-level comparison** — `project-documentation/skill.md` line 132 has one combined Gate-1 bullet: `Gate 1 (DRAFT → APPROVED): Explicit approval by the directing party. The implementer cannot approve its own work.` `work-items/skill.md` lines 271–275 has three Gate bullets (`Explicit approval by the directing party` each) and a standalone sentence below them: `The implementer cannot approve its own work across a gate.` The two house phrases ("Explicit approval by the directing party"; "The implementer cannot approve its own work") are present verbatim in both files; the bullet-structure variance is the one TASK-005 disclosed in Implementation Notes § Gotchas as acceptable per the no-structural-changes AC.
- **`work-items/skill.md` line 227** — post-TASK-005 text reads: `The directing party or implementer may move the work item back to IMPLEMENTING from IMPLEMENTED or REVIEW. The iterative zone is gateless.` The V6 roles are named; conceptual_design's full *Iterative Implementation Zone* "bracket the zone" framing ("Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone") is not lifted. TASK-005 disclosed this at Gate 3 as a minor Gap, non-blocking; the retained "The iterative zone is gateless" wording is V6-compatible and met under TASK-005's "in V6 terms" wording (TASK-005 AC#11 / EPIC-005 AC#5).

The audit's task is to confirm the survey above against the final-text state, classify every surviving `[Uu]sers?` occurrence as preserve-sense, audit the four-way phrase-level equivalence (both skills' § Quality Gates ↔ conceptual_design *Supervisor Distinct From Implementer* / *Three Hard Gates* ↔ technical_design § Gate Enforcement "by convention, not technical control"), and write a single audit-conclusion entry into EPIC-005's Activity Log so EPIC-005's own Gate 3 can verify AC#1 / AC#2 / AC#3 / AC#8 via that one entry.

If the audit surfaces a defect — a missed occurrence, a phrase that drifted from the canonical sources, an accidental structural change — the preferred resolution is **inline correction by this Task** with the appropriate `.claude/skills/` re-sync. Re-opening an archived Task is heavier and is the fallback for structurally significant defects; the Plan will record the chosen route explicitly. Where the line 227 *Iterative Implementation Zone* phrasing nit is concerned, this Task's verdict is **(a) the current wording is sufficient and survives the audit** — TASK-005's Gate 3 already approved it as met under loose-AC wording and the directing party may surface the nit as a future-Epic candidate rather than re-opening here; if the directing party disagrees at Gate 1 of this Task, the alternative **(b) recommends an inline correction with re-sync** and the Plan will sequence it.

**Out of scope**: any vocabulary editing beyond fixing an audit-surfaced defect; any change to a template other than `CLAUDE.md`; any command file (`shannon/commands/*.md`); any other skill index, mandated document, or work-item file other than this TASK-006 file itself and EPIC-005's Activity Log. The literal-file-count, editing-order, commit-hash-timing, bundled-re-elaboration, and naming-convention items captured in `scratchpad.md` are out of scope for this Task.

### Acceptance Criteria

`rg [Uu]sers?` survey and justifications (EPIC-005 **AC#1**):

- [ ] Running `rg -n "\b[Uu]sers?\b" shannon/skills/project-setup/skill.md shannon/skills/project-documentation/skill.md shannon/skills/work-items/skill.md shannon/skills/project-setup/templates/CLAUDE.md` returns exactly the four preserve-sense matches identified at elaboration — `project-setup/skill.md:69` (`do not overwrite user content`, file-merge sense), `project-setup/skill.md:83` (`Preserve any existing user content`, file-merge sense), `project-setup/skill.md:93` (`Target Users`, Vision-template section name), and `templates/CLAUDE.md:25` (`target users`, Vision document content description). `project-documentation/skill.md` and `work-items/skill.md` return **zero** matches.
- [ ] Each of the four surviving occurrences is classified in the audit's report (entered into EPIC-005's Activity Log per the audit-summary AC below) as preserve-sense, with the per-occurrence justification: lines 69 / 83 = file-merge "user content" (EPIC-005 AC#7); line 93 = Vision template section heading "Target Users" (TASK-004 preserve-list, EPIC-005 AC#6 / AC#7 by parallel); template line 25 = Vision document content description "target users" (EPIC-005 AC#6, line 25 explicitly preserved). No surviving occurrence is an unintended survivor. If the audit finds an unintended survivor, the defect-resolution policy AC below governs the response.

Gate-approval and self-approval-prevention sentences (EPIC-005 **AC#2**):

- [ ] Every gate-approval sentence across the four files names the **directing party** as the explicit approver. Audit anchors: `project-documentation/skill.md:121` (§ Process: Review step 4 — `Ask the directing party explicitly: "Approve this document to mark APPROVED?"`); `project-documentation/skill.md:132` (§ Quality Gates Gate 1 — `Explicit approval by the directing party`); `work-items/skill.md:148` (§ Process: Elaborate step 4 / Gate 1 — `Ask explicitly: "Approve these requirements to mark this ELABORATED?"`, with the directing party named as the asker in surrounding context); `work-items/skill.md:198` (§ Process: Plan step 5 / Gate 2 — `Ask explicitly: "Approve this plan to mark this PLANNED?"`); `work-items/skill.md:254` (§ Process: Review step 5 / Gate 3 — `Ask explicitly: "Approve this work to mark this APPROVED?"`); `work-items/skill.md:271–273` (§ Quality Gates Gate 1 / Gate 2 / Gate 3 — three `Explicit approval by the directing party` bullets); `templates/CLAUDE.md:65` (`Three quality gates require explicit directing-party approval`); `templates/CLAUDE.md:133` (`every gate requires explicit directing-party approval`).
- [ ] Every self-approval-prevention sentence across the four files names the **implementer** as the agent that cannot approve its own work. Audit anchors: `project-documentation/skill.md:132` (combined Gate-1 bullet — `The implementer cannot approve its own work.`); `work-items/skill.md:275` (standalone sentence below the three Gate bullets — `The implementer cannot approve its own work across a gate.`); `project-setup/skill.md` carries no self-approval-prevention sentence by design (the skill operates before Gate 1; see § Quality Gates note at line 107 — `This skill operates **before** the work item lifecycle, so no Gates 1–3 apply directly.`) and `templates/CLAUDE.md` likewise carries no self-approval-prevention sentence (the template lists "Three quality gates require explicit directing-party approval" without restating the implementer-cannot-self-approve invariant — the canonical statement lives in the skills and conceptual_design).

Four-way § Quality Gates phrase-level consistency (EPIC-005 **AC#3**):

- [ ] `project-documentation/skill.md § Quality Gates` and `work-items/skill.md § Quality Gates` use the verbatim TASK-004 house phrases for the same concepts: `Explicit approval by the directing party` (gate-approval) and `The implementer cannot approve its own work` (self-approval prevention). Phrase-level equivalence holds.
- [ ] Both files' § Quality Gates wording is consistent with `conceptual_design.md` *Supervisor Distinct From Implementer* (`the implementer cannot approve its own work across a gate; see Supervisor Distinct From Implementer`) and *Three Hard Gates* (`explicit approval by the directing party`), and with `technical_design.md § Gate Enforcement` (enforcement is "by convention, not technical control"). The four-way consistency check is content-anchored, not bullet-count-anchored.
- [ ] The bullet-structure variance between the two § Quality Gates sections — `project-documentation/skill.md:132` has one combined Gate-1 bullet (the skill manages only Gate 1 for documents); `work-items/skill.md:271–275` has three Gate bullets (Gate 1, 2, 3 — one per work-item gate) plus a standalone implementer-self-approval-prevention sentence — is **acceptable** per TASK-005's Implementation Notes § Gotchas. Rationale: each skill enumerates only the gates it owns, so the structural difference is *required* by the no-structural-changes scope of TASK-004 / TASK-005, not a residual defect. The audit confirms phrase-level equivalence holds despite the structural difference; no inline correction is required on this finding.

Self-identification lines (EPIC-005 **AC#8**):

- [ ] `rg -n "Activating .* skill\."` across the four target files returns the six expected lines verbatim, all six unchanged from before EPIC-005: `project-setup/skill.md:8` and `project-setup/skill.md:125` — `"Activating project-setup skill."`; `project-documentation/skill.md:8` and `project-documentation/skill.md:142` — `"Activating project-documentation skill."`; `work-items/skill.md:8` and `work-items/skill.md:298` — `"Activating work-items skill for [type] [verb]."` Both the When-Invoked instance and the § Self-Identification instance are intact in each skill file. (`templates/CLAUDE.md` has no self-identification line — it is a project template, not a skill.)

Cross-check of the two TASK-005 Gate 3 findings:

- [ ] **Line 227 *Iterative Implementation Zone* phrasing nit.** `work-items/skill.md:227` post-TASK-005 reads `The directing party or implementer may move the work item back to IMPLEMENTING from IMPLEMENTED or REVIEW. The iterative zone is gateless.` The two V6 roles are named; conceptual_design's "Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone" framing is not lifted. The audit's verdict is that the current wording is **sufficient and survives the audit** — TASK-005's Gate 3 approved this wording under EPIC-005 AC#5 / TASK-005 AC#11 ("in V6 terms"), and the retained "The iterative zone is gateless" wording is V6-compatible. The directing party may surface this as a future-Epic candidate (e.g. a documentation-tightening sweep) but the audit recommends **no inline correction by this Task**.
- [ ] **Bullet-structure variance** between `work-items/skill.md § Quality Gates` (three Gate bullets + standalone) and `project-documentation/skill.md § Quality Gates` (one combined bullet) — confirmed phrase-level equivalence holds (same `Explicit approval by the directing party` and `The implementer cannot approve its own work` phrases in both), consistent with the EPIC-005 AC#3 audit above. Structural difference is required by the skills' differing gate scopes and is acceptable per TASK-005's recorded Gotcha; no inline correction is required.

Defect-resolution policy:

- [ ] If any audit-surfaced defect is found (an unintended `[Uu]sers?` survivor, a phrase that drifted from the canonical sources, a missed gate-approval or self-approval-prevention sentence, or an accidentally-changed self-identification line), the **preferred resolution is inline correction by this Task** with the corresponding `shannon/skills/` source edit and `.claude/skills/` re-sync. Re-opening an archived sibling Task (TASK-004 / TASK-005) is the fallback for structurally significant defects only. Either choice is named explicitly in this Task's Activity Log and Implementation Notes. The two pre-elaboration findings above (line 227, bullet-structure variance) have been pre-judged in this Task's Acceptance Criteria as "no inline correction required"; this AC governs any *additional* defect the audit surfaces.

Audit summary write-back to EPIC-005's Activity Log:

- [ ] At Gate 3 of this Task, an entry is appended to `EPIC-005`'s Activity Log recording the audit's conclusion: (i) every surviving `[Uu]sers?` occurrence justified (`project-setup/skill.md:69` / `:83` file-merge sense; `:93` Vision section name; `templates/CLAUDE.md:25` Vision document content description; `project-documentation/skill.md` and `work-items/skill.md` both zero); (ii) four-way § Quality Gates phrase-level equivalence confirmed; (iii) the two TASK-005 Gate 3 findings (line 227, bullet-structure variance) resolved per the cross-check ACs above; (iv) all six self-identification lines verbatim. EPIC-005's own Gate 3 then verifies AC#1 / AC#2 / AC#3 / AC#8 via that single entry — the Task is the canonical record, EPIC-005's entry is the index.

Scope boundary (cross-type guard, not a literal file count):

- [ ] No vocabulary editing is performed by this Task **beyond the inline-correction route** if a defect is found. No template (other than `templates/CLAUDE.md`, which is one of the four audit-target files) is edited. No command file (`shannon/commands/*.md`) is edited. No skill index, mandated document, or work-item file other than this `TASK-006` file itself, EPIC-005's Activity Log, and — only if an audit-surfaced defect mandates inline correction — the directly-defective skill source plus its `.claude/skills/` deployed copy is changed. Phrased as a cross-type guard rather than a literal file count per the TASK-002 / TASK-003 lesson (recorded in TASK-003's archive): bare file-count caps obscure intent; the actual rule is "no editing beyond the audit's verdict and its associated re-sync".

Markdown / development_guide alignment:

- [ ] Markdown heading hierarchy in this Task file is intact (one `#` title; `##` for Requirements / Plan / Implementation Notes / Review / Activity Log; `###` for sub-sections); British-English spelling preserved (e.g. "behaviour", "organisation") per development_guide § Code Style. Per development_guide § Commit Cadence, **no commit is made until after Gate 3** — pre-gate experimentation is fine, but the commit lands only when EPIC-005's APPROVED state is batched with TASK-006's APPROVED state at the end of the EPIC-005 A → B → C sequence.

### Context

- **Parent Epic**: [EPIC-005 — V6 Vocabulary in Skills and CLAUDE.md Template](../epics/EPIC-005-v6-skills-and-claude-template.md) — this is the verification Task in its § Plan; closes EPIC-005 AC#1 (`rg` survey + Activity Log justifications), AC#2 (gate-approval consistency), AC#3 (four-way § Quality Gates consistency), AC#8 (self-identification lines unchanged)
- **Parent Feature**: [FEAT-006 — Multi-Party Supervision](../features/FEAT-006-multi-party-supervision.md) — § Ideal State "Skills and commands refuse self-approval flows" bullet (partly met, this Epic closes the skills half)
- **Sibling Tasks (both APPROVED 2026-05-23, archived — their outputs are what this Task audits)**: [TASK-004](archive/TASK-004-v6-vocabulary-setup-documentation-template.md) (`project-setup/skill.md`, `project-documentation/skill.md`, `templates/CLAUDE.md` — homogeneous vocabulary judgement; the project-documentation § Quality Gates rewrite established the house phrases) and [TASK-005](archive/TASK-005-v6-vocabulary-and-plan-pending-work-items-skill.md) (`work-items/skill.md` — vocabulary sweep + the AC#4 `PLAN-PENDING` structural rewrite + AC#5 line-227 reword; Implementation Notes § Gotchas disclosed the bullet-structure variance; Review noted the line-227 phrasing nit as non-blocking)
- **Audit targets** (read-only, unless an audit-surfaced defect mandates inline correction): `shannon/skills/project-setup/skill.md`, `shannon/skills/project-documentation/skill.md`, `shannon/skills/work-items/skill.md`, `shannon/skills/project-setup/templates/CLAUDE.md`
- **Canonical sources** (the references the audit compares against): `conceptual_design.md` v1.5 — *Directing Party* / *Implementer* glossary; *Three Hard Gates* business rule ("explicit approval by the directing party"; "The implementer cannot approve its own work across a gate"); *Supervisor Distinct From Implementer* business rule; *Iterative Implementation Zone* business rule ("the implementer and the directing party iterate freely without gates. Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone"). `technical_design.md` v1.1 — § Gate Enforcement (the `Supervisor Distinct From Implementer` rule is "enforced by convention, not by technical control"); § Cascading Operations: Batch Preparation, Individual Gates (the load-bearing reference TASK-005's structural rewrite copied verbatim)
- **Relevant Guide**: `development_guide.md` § Code Style (British-English Markdown conventions; heading hierarchy), § Distribution (the `.claude/skills/` re-sync obligation triggered only if a defect requires inline correction), § Git Workflow → Commit Cadence (no commit until Gate 3 — batched with EPIC-005's APPROVED state at the end of the A → B → C sequence)
- **Pre-elaboration survey** (the data this Task audits against final-text state): `[Uu]sers?` → 4 matches, all preserve-sense (project-setup 69 / 83 / 93; templates/CLAUDE.md 25); `PENDING` → 0; self-identification → six lines verbatim; § Quality Gates → both skills carry the TASK-004 house phrases at the phrase level; bullet-structure variance acceptable; line 227 phrasing sufficient under AC#5's loose-wording precedent

---

## Plan

*Drafted at `/task-plan TASK-006` (Gate 2).*

### Approach

[Filled during planning.]

### Steps

1. [Step]
2. [Step]
3. [Step]

### Dependencies

- [TASK-004](archive/TASK-004-v6-vocabulary-setup-documentation-template.md) APPROVED 2026-05-23 (met); [TASK-005](archive/TASK-005-v6-vocabulary-and-plan-pending-work-items-skill.md) APPROVED 2026-05-23 (met). Both editing Tasks must be APPROVED before this verification audit runs against final text.
- EPIC-005 PLANNED (met); conceptual_design v1.5 and technical_design v1.1 APPROVED.

### Risks

- [Risk — mitigation]

---

## Implementation Notes

[Filled during implementation.]

### Deviations from Plan

- [What changed and why]

### Gotchas

- [Problem encountered — resolution]

### Documents Updated

- [Documents updated during implementation, with sections]

---

## Review

[Filled during review (Gate 3).]

### Verification

- [ ] All acceptance criteria met
- [ ] Changes follow development_guide.md
- [ ] Relevant documents updated
- [ ] Knowledge captured where useful

### Review Notes

[Findings from review. Issues found and how they were resolved.]

---

## Activity Log

- **2026-05-23** — ELABORATED via Gate 1. Elaboration subagent ran the preliminary `rg` survey across the four EPIC-005 target files and drafted 11 testable Acceptance Criteria in 9 groups. Survey findings: 4 surviving `[Uu]sers?` matches (all preserve-sense — `project-setup/skill.md:69/83/93`, `templates/CLAUDE.md:25`); zero `PENDING`; all six self-identification lines verbatim; § Quality Gates phrase-level equivalence between `project-documentation/skill.md` and `work-items/skill.md` (verbatim TASK-004 house phrases). Sharp observation: the bullet-structure variance between the two skills' § Quality Gates is **required** (each skill enumerates only the gates it owns — `project-documentation` owns Gate 1 only; `work-items` owns Gates 1/2/3) — a structural necessity, not a defect. Two TASK-005 Gate 3 cross-check flags pre-judged: (a) the line 227 *Iterative Implementation Zone* phrasing nit is sufficient and survives the audit (V6-compatible, met under TASK-005's loose AC wording); (b) the bullet-structure variance is required and phrase-level equivalence holds. Directing party approved the requirements without modification, confirming route (a) on the line-227 pre-judgment. The audit's formal pass at Implement is now mostly bookkeeping unless surprises emerge.
- **2026-05-23** — DRAFT: Task created via `/task-create` under EPIC-005 — the final verification Task in EPIC-005's three-Task plan. Created after both TASK-004 and TASK-005 were APPROVED, per the Plan's recommendation (children created individually rather than pre-stashed; the verification Task in particular deferred so its `rg` survey runs against final text). Initial intent captured in the Overview and Context, including two cross-check findings flagged at TASK-005's Gate 3 (line 227 *Iterative Implementation Zone* phrasing nit; `work-items` vs `project-documentation` § Quality Gates bullet-structure variance). Acceptance Criteria and Plan to be drafted at `/task-elaborate` and `/task-plan`.
