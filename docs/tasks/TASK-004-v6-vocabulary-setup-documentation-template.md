# TASK-004: V6 Vocabulary in project-setup Skill, project-documentation Skill, and CLAUDE.md Template

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-005](../epics/EPIC-005-v6-skills-and-claude-template.md)
- **Feature**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Tags**: #framework #v6 #skills
- **Created**: 2026-05-23
- **Updated**: 2026-05-23 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

### Overview

This is **TASK-A** of EPIC-005's three-Task plan (sequenced A → B → C): the homogeneous V6-vocabulary pass over the three files that need only per-occurrence semantic judgement — no structural rewrites.

The V6 supervisor / implementer model distinguishes the **directing party** (approves at gates) from the **implementer** (does the work and cannot approve its own work). The mandated-document layer is already V6-aligned; this Task propagates that vocabulary into three implementation-layer files. Each "user" occurrence needs per-occurrence judgement — *directing party*, *implementer*, or genuinely "human terminal reader" / file-merge "user content" — so mechanical find-and-replace would be wrong.

Files in scope (occurrence counts verified by `rg "\b[Uu]sers?\b"` at elaboration — see § Acceptance Criteria for the per-file preserve-list):

- **`shannon/skills/project-setup/skill.md`** — **17** `[Uu]sers?` word-matches (EPIC-005's § Plan estimated ~15; the discrepancy is recorded in the Activity Log). 14 are directing-party-sense and become *directing party*; **3 are preserved** — the file-merge-sense "user content" on lines 69 and 83, and the Vision-template section name "Target Users" on line 93. Closes EPIC-005 **AC#7**.
- **`shannon/skills/project-documentation/skill.md`** — **12 lines / 14 word-matches** (lines 89 and 138 each carry two), all directing-party-sense. § Process: Review step 4 (Gate 1) and § Quality Gates are rewritten so the approver is named the *directing party* and "AI cannot self-approve" becomes "the implementer cannot approve its own work". The project-documentation half of EPIC-005 **AC#2 / AC#3**.
- **`shannon/skills/project-setup/templates/CLAUDE.md`** — **4** word-matches. Lines 65 / 71 / 133 move to directing-party / implementer vocabulary; **line 25 "target users" is preserved** as legitimate. Closes EPIC-005 **AC#6**.

Out of scope: `work-items/skill.md` — its vocabulary sweep and the `PLAN-PENDING` structural rewrite are TASK-B; cross-file consistency verification (the AC#1 `rg` survey and the four-way AC#3 audit) is TASK-C. Each edited skill keeps its self-identification line unchanged. After editing the `shannon/` source, the deployed `.claude/skills/` copies are re-synced (the deployed tree is gitignored).

The canonical phrasing reference is the V6-aligned document layer — conceptual_design v1.5 (*Supervisor Distinct From Implementer* business rule; the *Directing Party* / *Implementer* glossary) and technical_design v1.1 (§ Gate Enforcement — "by convention, not technical control"). This Task copies that phrasing rather than inventing it.

### Acceptance Criteria

Vocabulary edits — `project-setup/skill.md`:

- [ ] In `shannon/skills/project-setup/skill.md`, each of the 14 directing-party-sense "user" occurrences (lines 3, 24, 25, 26, 31, 42, 46, 62, 87, 95, 103, 107, 119, 121) is reworded to name the *directing party* (or rephrased to avoid the role noun where the sentence reads naturally without it, e.g. "Project name — asked if not supplied"). No directing-party-sense "user" remains.
- [ ] The three preserved occurrences are left intact: the file-merge "user content" on line 69 (`do not overwrite user content`) and line 83 (`Preserve any existing user content`), and the Vision-template section name "Target Users" on line 93. These are correct as written — file-merge "user content" is a distinct sense from the interaction role (EPIC-005 AC#7), and "Target Users" is a literal Vision template heading. They are a preserve-list, not defects.

Vocabulary edits — `project-documentation/skill.md` (project-documentation half of EPIC-005 AC#2 / AC#3):

- [ ] In `shannon/skills/project-documentation/skill.md`, § Process: Review **step 4 (Quality Gate, Gate 1)** names the **directing party** as the agent that explicitly approves (currently "Explicit user approval"), consistent with conceptual_design *Three Hard Gates* ("explicit approval by the directing party").
- [ ] In `shannon/skills/project-documentation/skill.md` **§ Quality Gates**, the line `Gate 1 (DRAFT → APPROVED): Explicit user approval required. AI cannot self-approve.` is reworded so approval is by the **directing party** and self-approval prevention names the **implementer** (e.g. "the implementer cannot approve its own work"), phrasing taken from conceptual_design *Supervisor Distinct From Implementer* and technical_design § Gate Enforcement — not a loose paraphrase.
- [ ] The remaining directing-party-sense "user" occurrences in `project-documentation/skill.md` (lines 16, 24, 25, 26, 66, 83, 89 ×2, 113, 124, 137, 138 ×2) are reworded to name the *directing party* or rephrased to avoid the role noun. No directing-party-sense "user" remains.

Vocabulary edits — `templates/CLAUDE.md` (EPIC-005 AC#6):

- [ ] In `shannon/skills/project-setup/templates/CLAUDE.md`, line 65 (`Three quality gates require explicit user approval`) and line 133 (`every gate requires explicit user approval`) name the **directing party** as approver, and line 71 (`AI and user iterate freely`) names the **implementer and directing party** iterating in the zone — consistent with conceptual_design *Iterative Implementation Zone* and *Three Hard Gates*.
- [ ] Line 25 of `templates/CLAUDE.md` (`vision.md ... # Problem, vision, principles, target users`) is left unchanged — "target users" is a legitimate description of the Vision document's content, not a gate role. Preserve, do not edit.

Scope boundary and integrity:

- [ ] `shannon/skills/work-items/skill.md` is **not modified** by this Task — `git status` shows it unchanged. Its vocabulary sweep and `PLAN-PENDING` rewrite are TASK-B; cross-file verification is TASK-C.
- [ ] Each edited skill retains its self-identification line unchanged: `project-setup/skill.md` keeps `"Activating project-setup skill."` (lines 8 and 125) and `project-documentation/skill.md` keeps `"Activating project-documentation skill."` (lines 8 and 142). `rg -n "Activating .* skill\."` over the two edited skills shows the same lines as before the change.
- [ ] No structural changes: no headings added or removed, no steps reordered, no sections moved in any of the three files — vocabulary-only edits.

Verification and distribution:

- [ ] After the edits, `rg "\b[Uu]sers?\b" shannon/skills/project-setup/skill.md shannon/skills/project-documentation/skill.md shannon/skills/project-setup/templates/CLAUDE.md` returns only the three deliberately-preserved occurrences (project-setup lines 69, 83, 93 — line numbers may shift slightly with edits) and `templates/CLAUDE.md` "target users"; `project-documentation/skill.md` returns **zero** matches. Every surviving match is on the preserve-list above.
- [ ] After editing the `shannon/` source files, the deployed `.claude/skills/project-setup/` and `.claude/skills/project-documentation/` copies (including `templates/CLAUDE.md`) are re-synced from `shannon/` source so the deployed tree matches — per development_guide § Distribution and EPIC-005's per-Task re-sync obligation.

### Context

- **Parent Epic**: [EPIC-005 — V6 Vocabulary in Skills and CLAUDE.md Template](../epics/EPIC-005-v6-skills-and-claude-template.md) — this is TASK-A in its § Plan; delivers AC#6 (CLAUDE.md template lines 65/71/133, line 25 preserved) and AC#7 (project-setup "user content" vs directing-party distinction), and contributes the project-documentation half of AC#2 (gate-approval sentences name the directing party; self-approval-prevention names the implementer) and AC#3 (§ Quality Gates consistent with conceptual_design and technical_design). TASK-C verifies all four cross-file.
- **Parent Feature**: [FEAT-006 — Multi-Party Supervision](../features/FEAT-006-multi-party-supervision.md)
- **Sibling Tasks**: TASK-B (`work-items/skill.md` — vocabulary sweep + the `PLAN-PENDING` structural rewrite; follows this Task) and TASK-C (cross-file verification audit — the AC#1 `rg` survey, AC#2/AC#3 four-way consistency, AC#8 self-identification check; created only after TASK-A and TASK-B are APPROVED)
- **Relevant documents**: `conceptual_design.md` v1.5 (*Supervisor Distinct From Implementer* business rule; *Three Hard Gates*; *Iterative Implementation Zone*; *Directing Party* / *Implementer* glossary — the canonical vocabulary); `technical_design.md` v1.1 § Gate Enforcement (convention-based enforcement, "by convention, not technical control"); `development_guide.md` § Distribution / § CI/CD (the `.claude/` re-sync obligation), § Code Style (British-English Markdown conventions)
- **Target files**: `shannon/skills/project-setup/skill.md`, `shannon/skills/project-documentation/skill.md`, `shannon/skills/project-setup/templates/CLAUDE.md`

---

## Plan

*Drafted at `/task-plan TASK-004` (Gate 2).*

### Approach

[Filled during planning.]

### Steps

1. [Step]
2. [Step]
3. [Step]

### Dependencies

- EPIC-005 PLANNED (met). No blocking sibling dependency — TASK-A is the first in the A → B → C sequence.

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

- **2026-05-23** — ELABORATED via Gate 1. Elaboration subagent surveyed the actual `[Uu]sers?` occurrences in the three target files and drafted 11 Acceptance Criteria in five groups (project-setup vocabulary + preserve-list, project-documentation Gate-1 / § Quality Gates rewrites, CLAUDE.md template, scope boundary, verification & distribution), each grep-checkable or line-pinned. Survey found minor drift in EPIC-005's Plan estimate: project-setup carries 17 occurrences (EPIC-005 said ~15) and a three-line preserve-list — lines 69, 83, and 93 ("Target Users") — where EPIC-005 named only 69/83. TASK-004's Requirements carry the corrected numbers; EPIC-005 left as-is (an estimate, not a defect). Alignment check: all Strength, no ambiguous occurrence needing a directing-party ruling. Directing party approved the requirements without modification.
- **2026-05-23** — DRAFT: Task created via `/task-create` under EPIC-005 — TASK-A of the three-Task plan. Created individually (not pre-stashed as a DRAFT stub) per EPIC-005's § Plan recommendation. Initial intent captured in the Overview and Context; Acceptance Criteria and Plan to be drafted at `/task-elaborate` and `/task-plan`.
