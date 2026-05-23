# TASK-005: V6 Vocabulary and PLAN-PENDING Removal in work-items Skill

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-005](../epics/EPIC-005-v6-skills-and-claude-template.md)
- **Feature**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Tags**: #framework #v6 #skills #work-items
- **Created**: 2026-05-23
- **Updated**: 2026-05-23 (elaborated)

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

### Overview

This is **TASK-B** of EPIC-005's three-Task plan (sequenced A → B → C). TASK-A ([TASK-004](archive/TASK-004-v6-vocabulary-setup-documentation-template.md), APPROVED 2026-05-23) settled the V6 vocabulary house style on the lower-risk files; **TASK-B applies that style to `shannon/skills/work-items/skill.md` alone, AND completes the structural `PLAN-PENDING` rewrite that the file still contradicts technical_design v1.1 on.**

TASK-B carries the heaviest and structurally distinct load of the three sibling Tasks — vocabulary judgement **plus** a structural rewrite. Elaboration verified the actual occurrence map by `rg -n "\b[Uu]sers?\b"` and `rg -n "PENDING"` against `shannon/skills/work-items/skill.md`:

- **Vocabulary sweep — 17 `[Uu]sers?` matches** (EPIC-005's Plan estimated ~16; the +1 discrepancy is recorded here and proceeded with, not blocked on — matches TASK-A's project-setup precedent where EPIC-005's ~15 estimate was actually 17). **All 17 are directing-party-sense** — there is no preserve-sense occurrence in this file (no "Target Users" heading, no file-merge "user content", no quoted-from-test). Lines: 27, 28, 81, 104, 110, 120, 144, 194, 227 (paired with implementer-sense "AI" — EPIC-005 AC#5), 271, 272, 273 (the three Gate sentences), 279, 283, 284, 290, 292. Each is reworded to name the *directing party*, or rephrased to drop the role noun where the sentence reads naturally without it. Phrasing copied from the V6-aligned document layer (conceptual_design v1.5, technical_design v1.1), not invented — same per-occurrence judgement TASK-A used.
- **Implementer-sense rewordings** — three `AI` occurrences that name the work-doing role and must become *implementer*: line 275 (§ Quality Gates — "AI never self-approves across a gate"), line 282 (§ Cascading Operations — "AI marks children…"), line 283 (§ Cascading Operations — "AI presents a summary…"), and the `AI` half of line 227 (§ Process: Implement step 5 — "The user or AI may move…"). Lines 282 / 283 are subsumed by the structural rewrite below.
- **§ Quality Gates rewrite — work-items half of EPIC-005 AC#3.** The three "Explicit user approval" Gate sentences (lines 271–273) and the "AI never self-approves across a gate" sentence (line 275) are reworded so the **directing party** approves and the **implementer** cannot approve its own work — phrasing tracking conceptual_design *Supervisor Distinct From Implementer* / *Three Hard Gates* and technical_design § Gate Enforcement ("by convention, not technical control"). Lift, do not paraphrase.
- **Structural `PLAN-PENDING` rewrite — EPIC-005 AC#4.** `rg "PENDING"` returns **three** locations, all needing rewrite: line 190 (§ Process: Plan **step 3** — "Cascading Preparation"), line 200 (§ Process: Plan **step 5** — Gate 2 Approval note about children remaining `PLAN-PENDING`), and line 282 (§ Cascading Operations step 2). technical_design v1.1 explicitly retired these sub-statuses (commit `1943f3f`). All three rewrite to the *Batch Preparation, Individual Gates* model in technical_design § Cascading Operations: the implementer creates each child in DRAFT with a *prepared elaboration draft* and a *prepared plan draft* stored in the relevant sections of the child file (marked clearly as "prepared during EPIC-XXX planning, not yet reviewed"); the prepared content is surfaced when the directing party later runs the child's own gate command. No new sub-statuses, no `*-PENDING` tokens. **Match technical_design § Cascading Operations' wording verbatim where the mechanics are named** — a loose paraphrase that drops `*-PENDING` but invents different mechanics would itself be new drift (EPIC-005 § Risks).
- **§ Process: Implement step 5 — EPIC-005 AC#5.** Line 227 "The user or AI may move the work item back to IMPLEMENTING from IMPLEMENTED or REVIEW. The iterative zone is gateless." → names the **directing party** and the **implementer** as the two roles iterating, naming the iterative zone in V6 terms (conceptual_design *Iterative Implementation Zone* — "the implementer and the directing party iterate freely").
- **Leave-untouched anchors — confirmed V6-clean at survey time**: the **Re-elaboration Branch** sub-section under § Process: Elaborate (TASK-001, lines 157–170) already uses "directing party" (line 164) and is V6-clean; the **Feature `(Partial)` index-suffix** language under § Process: Create step 7 (TASK-002, line 116) and the *Index out of sync* cross-reference under § Failure Modes (TASK-002, line 293) carry no `[Uu]sers?` occurrence and use "the skill" / "the body is authoritative" — both already V6-clean. Confirm-only, not re-edited by this Task.

Delivers EPIC-005 **AC#4** and **AC#5**, and contributes the work-items half of **AC#2 / AC#3**. Cross-file consistency verification across all four EPIC-005 files (this skill, TASK-A's three files, and the document-layer reference) is TASK-C's job — out of scope here.

After editing the `shannon/` source, the deployed `.claude/skills/work-items/` is re-synced from source (the deployed tree is gitignored).

### Acceptance Criteria

Vocabulary sweep — directing-party-sense `[Uu]sers?` occurrences:

- [ ] In `shannon/skills/work-items/skill.md`, each of the 17 directing-party-sense `[Uu]sers?` occurrences — lines 27, 28, 81, 104, 110, 120, 144, 194, 227, 271, 272, 273, 279, 283, 284, 290, 292 — is reworded to name the *directing party*, or rephrased to drop the role noun where the sentence reads naturally without it (e.g. "report creation"). No directing-party-sense `[Uu]sers?` token remains in the file. Phrasing tracks conceptual_design v1.5 (*Directing Party* glossary; *Three Hard Gates*) and the precedent already set by TASK-004 on the sibling skills — not invented.
- [ ] No occurrence in `work-items/skill.md` has a preserve sense — survey confirmed at elaboration time. If any later occurrence is judged preserve-sense by the directing party during review, it is named in the Activity Log finding so TASK-C's audit knows it is intentional.

Implementer-sense rewordings — `AI` occurrences that name the work-doing role:

- [ ] § Quality Gates line 275 ("AI never self-approves across a gate") is reworded so the **implementer** (not "AI") is named as the agent that cannot approve its own work, lifting the phrasing from conceptual_design *Supervisor Distinct From Implementer* ("the implementer cannot approve its own work") rather than paraphrasing.
- [ ] The "AI" tokens at lines 282 and 283 are reworded to name the **implementer** as part of the § Cascading Operations structural rewrite below (subsumed there, not a separate edit).
- [ ] At line 227, the "AI" half of "The user or AI may move…" is reworded to name the **implementer** (handled with the AC#5 rewrite below).

§ Quality Gates rewrite — work-items half of EPIC-005 AC#3:

- [ ] § Quality Gates lines 271–273 (the three "Explicit user approval" Gate sentences) name the **directing party** as the explicit approver — phrasing tracking conceptual_design *Three Hard Gates* ("explicit approval by the directing party") and the project-documentation § Quality Gates rewrite TASK-004 already landed.
- [ ] § Quality Gates line 275 ("AI never self-approves across a gate") is consistent with conceptual_design *Supervisor Distinct From Implementer* and technical_design § Gate Enforcement ("by convention, not technical control"); names the **implementer**.
- [ ] After the rewrite, `work-items/skill.md § Quality Gates` and `project-documentation/skill.md § Quality Gates` use the same role nouns (directing party / implementer) for the same concepts. Strict four-way cross-file consistency is TASK-C's audit; this AC closes the work-items-side preconditions for it.

Structural `PLAN-PENDING` rewrite — EPIC-005 AC#4:

- [ ] After the rewrite, `rg "PENDING" shannon/skills/work-items/skill.md` returns **zero** matches. The three current locations (line 190 § Process: Plan step 3; line 200 § Process: Plan step 5; line 282 § Cascading Operations) no longer contain `PLAN-PENDING`, `*-PENDING`, or any other `-PENDING` token.
- [ ] § Process: Plan **step 3 ("Cascading Preparation")** is rewritten so that, when planning an Epic, the implementer **creates each child Task in DRAFT** with a *prepared elaboration draft* and a *prepared plan draft* stored in the relevant sections of the child file, marked clearly as "prepared during EPIC-XXX planning, not yet reviewed" — wording tracking technical_design § Cascading Operations: Batch Preparation, Individual Gates (steps 3 and 5: "creates each child task in DRAFT, with a *prepared elaboration draft* and a *prepared plan draft* stored in the relevant sections of the task file (marked clearly as 'prepared during EPIC-XXX planning, not yet reviewed')" and "the subagent surfaces the prepared elaboration instead of starting fresh; same for `/task-plan TASK-XXX`. Each child still requires its own Gate 1 and Gate 2 approval"). The wording is lifted, not loosely paraphrased — see EPIC-005 § Risks "PLAN-PENDING rewrite drifting from technical_design".
- [ ] § Process: Plan **step 5 (Gate 2 Approval)** is reworded so that, on approval, child items prepared during the parent's planning **remain in DRAFT until each child's own gate command surfaces and approves the prepared draft** — naming the unified status lifecycle (no `PLAN-PENDING` sub-status), not a new transitional state.
- [ ] § Cascading Operations is rewritten so steps 1–4 describe the **Batch Preparation, Individual Gates** model from technical_design § Cascading Operations: implementer plans the parent and writes the plan into its file → implementer identifies the child work items → implementer creates each child in DRAFT with prepared elaboration / plan drafts stashed inside the child file → implementer presents a summary of the parent plan and the prepared children to the directing party → when the directing party later runs each child's own gate command (e.g. `/task-elaborate TASK-XXX`, `/task-plan TASK-XXX`), the subagent surfaces the prepared content instead of starting fresh; each child still passes through Gate 1 and Gate 2 individually. No new sub-statuses introduced.
- [ ] The § Cascading Operations rewrite explicitly tracks technical_design v1.1 § Cascading Operations: Batch Preparation, Individual Gates — the mechanics named in the skill (DRAFT children + stashed prepared drafts + surfaced at child's own gate; no `*-PENDING`) match that section verbatim where mechanics are named, not a loose paraphrase. TASK-C's AC#3 audit cross-checks against that section as the canonical reference.

§ Process: Implement step 5 — EPIC-005 AC#5:

- [ ] § Process: Implement step 5 (line 227) is reworded from "The user or AI may move the work item back to IMPLEMENTING from IMPLEMENTED or REVIEW. The iterative zone is gateless." to name the **directing party or implementer** as the two roles, and the iterative zone in V6 terms — tracking conceptual_design *Iterative Implementation Zone* ("the implementer and the directing party iterate freely without gates. Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone").

Leave-untouched anchors — confirm V6-clean, do not re-edit:

- [ ] The **Re-elaboration Branch** sub-section under § Process: Elaborate (TASK-001, lines 157–170) is confirmed V6-clean at survey time — it uses "directing party" (line 164) and "the implementer" framing throughout — and is **not modified** by this Task. The `git diff` for this Task shows no edits between the *Re-elaboration Branch* heading and the end of § Process: Elaborate.
- [ ] The **Feature `(Partial)` index-suffix** language under § Process: Create step 7 (TASK-002, line 116) and the *Index out of sync* cross-reference under § Failure Modes (TASK-002, line 293) are confirmed V6-clean at survey time — neither carries a `[Uu]sers?` occurrence and both use role-neutral skill-as-actor phrasing — and are **not modified** by this Task.

Scope boundary and integrity:

- [ ] Only `shannon/skills/work-items/skill.md` is edited under `shannon/`. No other skill file (`project-setup/skill.md`, `project-documentation/skill.md`), no template (`templates/*.md`, `templates/CLAUDE.md`), no command file (`shannon/commands/*.md`), no mandated document (`docs/*.md`), and no other work item (`docs/features/*.md`, `docs/epics/*.md`, `docs/tasks/*.md`, `docs/spikes/*.md` apart from this TASK-005 file itself), is modified by this Task. Phrased as a cross-type guard rather than a literal file count — the TASK-002 / TASK-003 lesson (recorded in TASK-003's archive) was that bare file-count caps obscure intent; the actual rule is "vocabulary + structural rewrite are confined to the work-items skill". The directing party may approve a same-purpose ripple edit if one surfaces during implementation, but it must be named in the Activity Log.
- [ ] The skill self-identification line `"Activating work-items skill for [type] [verb]."` is retained unchanged at line 8 (the header instruction) and in § Self-Identification (currently line 297). Both instances appear in the file with their pre-edit wording.
- [ ] No structural changes outside the named rewrites: no headings added or removed, no Process steps reordered, no sections moved, no templates list changed, no Work Item ↔ Document Relationships table edited. The diff is confined to (a) word-level vocabulary edits and (b) the prose rewrites at § Process: Plan steps 3 and 5, § Cascading Operations, § Process: Implement step 5, and § Quality Gates.

Verification — mechanically checkable:

- [ ] After the edits, `rg "\b[Uu]sers?\b" shannon/skills/work-items/skill.md` returns **zero** matches (no preserve-sense occurrence exists in this file). If any match survives, it is named individually in the Activity Log as a directing-party-judged preserve-sense exception so TASK-C's audit treats it as intentional, not as missed.
- [ ] After the edits, `rg "PENDING" shannon/skills/work-items/skill.md` returns **zero** matches — no `PLAN-PENDING`, no `*-PENDING`, no `-PENDING` token of any kind.
- [ ] `rg -n "Activating work-items skill"` returns the two pre-existing lines unchanged (line 8 header instruction; § Self-Identification line ~297).

Distribution and Markdown alignment:

- [ ] After editing the `shannon/` source, the deployed `.claude/skills/work-items/` copy is re-synced from `shannon/skills/work-items/` so source and deployed copies match (verified by `diff -rq shannon/skills/work-items/ .claude/skills/work-items/` returning no differences) — per development_guide § Distribution and EPIC-005's per-Task re-sync obligation. `.claude/` is gitignored, so this leaves no tracked diff; the Activity Log records the re-sync explicitly so Gate 3 can confirm it happened.
- [ ] Edits follow development_guide § Code Style: British-English spelling preserved (e.g. "behaviour", "organisation"), Markdown heading hierarchy intact, no stale cross-references introduced (e.g. no reference to a `*-PENDING` status in any rewritten section). Per development_guide § Commit Cadence, **this Task produces no commit** — the commit lands only after Gate 3 review, batched with EPIC-005's APPROVED state at the end of the A → B → C sequence.

### Context

- **Parent Epic**: [EPIC-005 — V6 Vocabulary in Skills and CLAUDE.md Template](../epics/EPIC-005-v6-skills-and-claude-template.md) — this is TASK-B in its § Plan; delivers EPIC-005 AC#4 (`PLAN-PENDING` structural rewrite) and AC#5 (§ Process: Implement step 5), and contributes the work-items half of AC#2 (gate-approval names directing party; self-approval-prevention names implementer) and AC#3 (§ Quality Gates consistent with conceptual_design and technical_design)
- **Parent Feature**: [FEAT-006 — Multi-Party Supervision](../features/FEAT-006-multi-party-supervision.md)
- **Sibling Tasks**: [TASK-004](archive/TASK-004-v6-vocabulary-setup-documentation-template.md) (TASK-A, APPROVED 2026-05-23 — the V6 vocabulary precedent on `project-setup/skill.md`, `project-documentation/skill.md`, and the `CLAUDE.md` template; copy its house phrasing rather than invent new) and TASK-C (cross-file verification audit — the AC#1 `rg` survey, AC#2/AC#3 four-way consistency, AC#8 self-identification check; created only after TASK-A and TASK-B are APPROVED)
- **Canonical phrasing references** (lift, do not paraphrase):
  - `conceptual_design.md` v1.5 — *Directing Party* / *Implementer* glossary entries (lines 16–17); *Three Hard Gates* business rule ("explicit approval by the directing party"; "the implementer cannot approve its own work across a gate"); *Supervisor Distinct From Implementer* business rule; *Iterative Implementation Zone* glossary entry ("the implementer and the directing party iterate freely without gates. Approval to enter (Gate 2) and approval to exit (Gate 3) bracket the zone")
  - `technical_design.md` v1.1 — **§ Cascading Operations: Batch Preparation, Individual Gates** (the load-bearing reference for AC#4 — implementer creates each child in DRAFT with a *prepared elaboration draft* and a *prepared plan draft* stored in the relevant sections, marked "prepared during EPIC-XXX planning, not yet reviewed"; surfaced when each child's gate command runs; no new sub-statuses) and § Gate Enforcement ("by convention, not technical control")
- **TASK-A precedent (`project-documentation/skill.md` § Quality Gates rewrite)** — TASK-004's Gate 1 line read "Explicit approval by the directing party. The implementer cannot approve its own work." This is the house phrasing for the three Gate sentences and the self-approval-prevention sentence in `work-items/skill.md § Quality Gates`
- **Relevant guide**: `development_guide.md` § Distribution (the `.claude/skills/` re-sync obligation — deployed copies are gitignored), § Code Style (British-English Markdown conventions), § Git Workflow → Commit Cadence (commit only after Gate 3; pre-gate experimentation is fine, but no commit lands in this Task before Gate 3 approval)
- **Target file**: `shannon/skills/work-items/skill.md` (only) — 17 directing-party-sense `[Uu]sers?` occurrences (EPIC-005 estimated ~16; +1 discrepancy recorded in Overview), 3 `PENDING` locations (lines 190 / 200 / 282), three implementer-sense `AI` occurrences (lines 275, 282, 283) plus the dual line 227. EPIC-005 § Plan TASK-B named "step 3 and § Cascading Operations" for the PENDING work; the survey confirms step 5 (line 200) is the third location and is in scope under AC#4 ("step 3 / step 5 / § Cascading Operations")
- **Leave-untouched anchors** (confirmed V6-clean at survey time; confirm-only, not re-edited): § Process: Elaborate → *Re-elaboration Branch* sub-section (TASK-001, lines 157–170, uses "directing party" at line 164); § Process: Create step 7 → Feature `(Partial)` index-suffix language (TASK-002, line 116, no `[Uu]sers?` occurrence); § Failure Modes → *Index out of sync* cross-reference (TASK-002, line 293, no `[Uu]sers?` occurrence). These are the recent TASK-001 / TASK-002 edits; isolating TASK-B in its own Task keeps its diff small and avoids colliding with that recent work (EPIC-005 § Risks — "Editing `work-items/skill.md` again so soon")

---

## Plan

*Drafted at `/task-plan TASK-005` (Gate 2).*

### Approach

[Filled during planning.]

### Steps

1. [Step]
2. [Step]
3. [Step]

### Dependencies

- TASK-A ([TASK-004](archive/TASK-004-v6-vocabulary-setup-documentation-template.md)) — APPROVED 2026-05-23. The vocabulary precedent set by TASK-A (phrasing choices in the sibling skills) is the house style to copy.
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

- **2026-05-23** — ELABORATED via Gate 1. Elaboration subagent surveyed `work-items/skill.md` by `rg` and drafted 19 Acceptance Criteria in seven groups (vocabulary sweep, implementer-sense rewordings, § Quality Gates rewrite, structural `PLAN-PENDING` rewrite, § Process: Implement step 5, leave-untouched anchors, scope boundary + verification + re-sync). Survey found 17 directing-party-sense `[Uu]sers?` occurrences (EPIC-005 estimated ~16; +1 recorded, matches TASK-A precedent), 4 `AI` occurrences to become *implementer* (lines 227, 275, 282, 283), and **3** `PENDING` locations (lines 190, 200, 282 — EPIC-005 named only step 3 + § Cascading Operations; step 5 line 200 was the third). The TASK-001 Re-elaboration Branch (lines 157–170) and TASK-002 `(Partial)` index-suffix anchors confirmed V6-clean at survey — leave-untouched, not re-edited. AC#4 mandates lifting technical_design § Cascading Operations' wording verbatim where the mechanics are named, mitigating EPIC-005's "PLAN-PENDING rewrite drift" risk. Alignment: all Strength; no occurrence needs directing-party judgement, no drift, no internal contradiction. Directing party approved the requirements without modification.
- **2026-05-23** — DRAFT: Task created via `/task-create` under EPIC-005 — TASK-B of the three-Task plan. Created individually after TASK-A's approval, per EPIC-005's § Plan recommendation (children created individually rather than pre-stashed as DRAFT stubs). Initial intent captured in the Overview and Context; Acceptance Criteria and Plan to be drafted at `/task-elaborate` and `/task-plan`.
