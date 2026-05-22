# TASK-004: V6 Vocabulary in project-setup Skill, project-documentation Skill, and CLAUDE.md Template

## Metadata

- **Status**: APPROVED
- **Type**: Task
- **Parent**: [EPIC-005](../epics/EPIC-005-v6-skills-and-claude-template.md)
- **Feature**: [FEAT-006](../features/FEAT-006-multi-party-supervision.md)
- **Tags**: #framework #v6 #skills
- **Created**: 2026-05-23
- **Updated**: 2026-05-23 (approved)

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

- [x] In `shannon/skills/project-setup/skill.md`, each of the 14 directing-party-sense "user" occurrences (lines 3, 24, 25, 26, 31, 42, 46, 62, 87, 95, 103, 107, 119, 121) is reworded to name the *directing party* (or rephrased to avoid the role noun where the sentence reads naturally without it, e.g. "Project name — asked if not supplied"). No directing-party-sense "user" remains.
- [x] The three preserved occurrences are left intact: the file-merge "user content" on line 69 (`do not overwrite user content`) and line 83 (`Preserve any existing user content`), and the Vision-template section name "Target Users" on line 93. These are correct as written — file-merge "user content" is a distinct sense from the interaction role (EPIC-005 AC#7), and "Target Users" is a literal Vision template heading. They are a preserve-list, not defects.

Vocabulary edits — `project-documentation/skill.md` (project-documentation half of EPIC-005 AC#2 / AC#3):

- [x] In `shannon/skills/project-documentation/skill.md`, § Process: Review **step 4 (Quality Gate, Gate 1)** names the **directing party** as the agent that explicitly approves (currently "Explicit user approval"), consistent with conceptual_design *Three Hard Gates* ("explicit approval by the directing party").
- [x] In `shannon/skills/project-documentation/skill.md` **§ Quality Gates**, the line `Gate 1 (DRAFT → APPROVED): Explicit user approval required. AI cannot self-approve.` is reworded so approval is by the **directing party** and self-approval prevention names the **implementer** (e.g. "the implementer cannot approve its own work"), phrasing taken from conceptual_design *Supervisor Distinct From Implementer* and technical_design § Gate Enforcement — not a loose paraphrase.
- [x] The remaining directing-party-sense "user" occurrences in `project-documentation/skill.md` (lines 16, 24, 25, 26, 66, 83, 89 ×2, 113, 124, 137, 138 ×2) are reworded to name the *directing party* or rephrased to avoid the role noun. No directing-party-sense "user" remains.

Vocabulary edits — `templates/CLAUDE.md` (EPIC-005 AC#6):

- [x] In `shannon/skills/project-setup/templates/CLAUDE.md`, line 65 (`Three quality gates require explicit user approval`) and line 133 (`every gate requires explicit user approval`) name the **directing party** as approver, and line 71 (`AI and user iterate freely`) names the **implementer and directing party** iterating in the zone — consistent with conceptual_design *Iterative Implementation Zone* and *Three Hard Gates*.
- [x] Line 25 of `templates/CLAUDE.md` (`vision.md ... # Problem, vision, principles, target users`) is left unchanged — "target users" is a legitimate description of the Vision document's content, not a gate role. Preserve, do not edit.

Scope boundary and integrity:

- [x] `shannon/skills/work-items/skill.md` is **not modified** by this Task — `git status` shows it unchanged. Its vocabulary sweep and `PLAN-PENDING` rewrite are TASK-B; cross-file verification is TASK-C.
- [x] Each edited skill retains its self-identification line unchanged: `project-setup/skill.md` keeps `"Activating project-setup skill."` (lines 8 and 125) and `project-documentation/skill.md` keeps `"Activating project-documentation skill."` (lines 8 and 142). `rg -n "Activating .* skill\."` over the two edited skills shows the same lines as before the change.
- [x] No structural changes: no headings added or removed, no steps reordered, no sections moved in any of the three files — vocabulary-only edits.

Verification and distribution:

- [x] After the edits, `rg "\b[Uu]sers?\b" shannon/skills/project-setup/skill.md shannon/skills/project-documentation/skill.md shannon/skills/project-setup/templates/CLAUDE.md` returns only the three deliberately-preserved occurrences (project-setup lines 69, 83, 93 — line numbers may shift slightly with edits) and `templates/CLAUDE.md` "target users"; `project-documentation/skill.md` returns **zero** matches. Every surviving match is on the preserve-list above.
- [x] After editing the `shannon/` source files, the deployed `.claude/skills/project-setup/` and `.claude/skills/project-documentation/` copies (including `templates/CLAUDE.md`) are re-synced from `shannon/` source so the deployed tree matches — per development_guide § Distribution and EPIC-005's per-Task re-sync obligation.

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

A single homogeneous editing pass across three files, executed file-by-file. The edits are word-level in-line replacements (`user` → `directing party` *within* a line) — they add and remove no lines, so each file's line count is invariant and the Requirements' line-pinned survey stays valid for the whole pass *regardless of editing order*. (The Edit tool also matches on unique surrounding text, not line numbers, so the editing operation never consumes a line number — the survey's line numbers are an orientation and verification aid only.) Occurrences within each file are worked **top-to-bottom purely as a reading-order discipline**, so none is missed — not as a line-number-safety measure. Were any edit ever to change a file's line count, the correct order would instead be **bottom-to-top**, so each edit lands below every pending one; that case does not arise here. The Requirements already carry the full survey — every `[Uu]sers?` occurrence is line-pinned and classified (directing-party sense vs. preserve-list) — so this Plan sequences execution; it does not re-derive the survey. A re-run of `rg -n "\b[Uu]sers?\b"` against the three files at the start of implementation (already done at planning — line numbers match the Requirements exactly) is the orientation baseline.

Editing is **per-occurrence semantic judgement, not find-and-replace**. Each directing-party-sense "user" is reworded to name the *directing party*, or — where the sentence reads naturally without the role noun — rephrased to drop it (e.g. "Project name — asked if not supplied"). Phrasing is copied from the V6-aligned document layer: conceptual_design v1.5 (*Directing Party* / *Implementer* glossary; *Three Hard Gates* — "explicit approval by the directing party"; *Supervisor Distinct From Implementer* — "the implementer cannot approve its own work"; *Iterative Implementation Zone* — "the implementer and the directing party iterate freely") and technical_design v1.1 § Gate Enforcement ("by convention, not technical control"). Nothing is invented.

Three occurrences in `project-setup/skill.md` (lines 69, 83, 93) and one in `templates/CLAUDE.md` (line 25) are a **preserve-list, not defects** — file-merge "user content" and the literal Vision section name "Target Users" are distinct senses from the interaction role and are left byte-for-byte intact. Edits are vocabulary-only: no headings, steps, or sections added, removed, or reordered; the two skill self-identification lines are untouched. After the `shannon/` source edits, the affected `shannon/skills/` subtrees are re-copied to the gitignored `.claude/skills/` deployed tree (with `templates/CLAUDE.md` riding along inside the `project-setup` skill's copy). A closing `rg` survey plus `git status` confirms the result. Per development_guide § Commit Cadence, **no commit is made in this Task** — the commit lands after Gate 3 review.

**File order — `project-setup/skill.md` → `project-documentation/skill.md` → `templates/CLAUDE.md`.** project-setup is edited first because it carries the largest and most varied occurrence set (14 directing-party edits plus the 3-entry preserve-list) — settling the house phrasing on the hardest file first means project-documentation and the small CLAUDE.md template simply follow the established style. project-documentation is edited second so the AC#4/AC#5 gate-rewrites (step 4 and § Quality Gates) are done with the conceptual_design / technical_design phrasing fresh in context. `templates/CLAUDE.md` is last and smallest (three edits, one preservation).

### Steps

1. **Orientation baseline.** Re-run `rg -n "\b[Uu]sers?\b"` over the three target files and confirm the occurrence lines match the Requirements' survey (project-setup 17 matches, project-documentation 12 lines / 14 matches, CLAUDE.md 4 matches). This pins the editing map before any text changes. *(Supports all vocabulary ACs; no AC closed.)*

2. **Edit `shannon/skills/project-setup/skill.md`, top-to-bottom.** Reword each of the 14 directing-party-sense occurrences — lines 3, 24, 25, 26, 31, 42, 46, 62, 87, 95, 103, 107, 119, 121 — to name the *directing party*, or drop the role noun where the sentence reads naturally without it (e.g. line 31 "Project name — Asked if not supplied"). **Leave lines 69 and 83 ("user content", file-merge sense) and line 93 ("Target Users", Vision section name) byte-for-byte intact.** Leave the self-identification lines 8 and 125 ("Activating project-setup skill.") unchanged. All edits here are word-level in-line replacements, so line counts — and therefore every other occurrence's line number — stay fixed throughout; occurrences are worked top-to-bottom only as a reading-order discipline so none is missed. *(Closes AC#1 — project-setup directing-party edits — and AC#2 — preserve-list intact; EPIC-005 AC#7.)*

3. **Edit `shannon/skills/project-documentation/skill.md`, top-to-bottom.** First the 10 plain directing-party-sense occurrences on lines 16, 24, 25, 26, 66, 83, 89 (×2), 113, 124, 137, 138 (×2) — reworded to name the *directing party* or rephrased to drop the role noun. Then the two gate-rewrites: **§ Process: Review step 4 (Gate 1), line 121** — change "Approve this document…" framing so the **directing party** is named as the explicit approver (per conceptual_design *Three Hard Gates* — "explicit approval by the directing party"); and **§ Quality Gates, line 132** — reword `Gate 1 (DRAFT → APPROVED): Explicit user approval required. AI cannot self-approve.` so approval is **by the directing party** and self-approval prevention names the **implementer** ("the implementer cannot approve its own work"), copying conceptual_design *Supervisor Distinct From Implementer* and technical_design § Gate Enforcement rather than paraphrasing loosely. The result must leave **zero** `[Uu]sers?` matches in this file. Leave self-identification lines 8 and 142 unchanged. *(Closes AC#3 — Gate 1 step 4 names directing party; AC#4 — § Quality Gates rewrite; AC#5 — remaining occurrences; the project-documentation half of EPIC-005 AC#2 / AC#3.)*

4. **Edit `shannon/skills/project-setup/templates/CLAUDE.md`, top-to-bottom.** Line 65 (`Three quality gates require explicit user approval`) and line 133 (`every gate requires explicit user approval`) — name the **directing party** as approver. Line 71 (`Between IMPLEMENTING, IMPLEMENTED, and REVIEW, AI and user iterate freely`) — name the **implementer and directing party** iterating in the zone (conceptual_design *Iterative Implementation Zone*). **Leave line 25 (`# Problem, vision, principles, target users`) unchanged** — "target users" describes the Vision document's content, not a gate role. *(Closes AC#6 — CLAUDE.md lines 65/71/133 — and AC#7 — line 25 preserved; EPIC-005 AC#6.)*

5. **Re-sync the deployed `.claude/` tree.** After the `shannon/` source edits, re-copy the two affected skill subtrees so the gitignored deployed copies match source: `shannon/skills/project-setup/` → `.claude/skills/project-setup/` (this carries `templates/CLAUDE.md` along inside the skill's deployed copy) and `shannon/skills/project-documentation/` → `.claude/skills/project-documentation/`. `shannon/skills/work-items/` is **not** re-synced — it is not edited by this Task. *(Closes AC#11 — deployed tree re-synced; development_guide § Distribution.)*

6. **Verify.** Run `rg "\b[Uu]sers?\b" shannon/skills/project-setup/skill.md shannon/skills/project-documentation/skill.md shannon/skills/project-setup/templates/CLAUDE.md` — expect exactly four surviving matches: project-setup lines 69 / 83 / 93 (line numbers unchanged — word-level edits do not shift line counts) and CLAUDE.md line 25; `project-documentation/skill.md` returns **zero**. Run `rg -n "Activating .* skill\."` over the two edited skills and confirm the self-identification lines are unchanged. Run `git status` and confirm `shannon/skills/work-items/skill.md` is **not** listed as modified, and that no headings/sections were structurally changed (diff review — vocabulary-only). *(Closes AC#8 — work-items untouched; AC#9 — self-identification lines unchanged; AC#10 — no structural changes; AC#11 — `rg` survey returns only the preserve-list.)*

### Dependencies

- EPIC-005 PLANNED (met). No blocking sibling dependency — TASK-A is the first in the A → B → C sequence.
- Canonical phrasing references — conceptual_design v1.5 and technical_design v1.1 — both APPROVED and stable (per EPIC-005 § Dependencies). The Plan copies their wording; no upstream change is pending that would shift it.
- `.claude/skills/` deployed tree present (confirmed: `project-setup`, `project-documentation`, `work-items` all deployed) and gitignored — re-sync in step 5 produces no tracked diff, which is expected.

### Risks

- **Over-correction — replacing a preserved occurrence.** Editing line 69/83 ("user content", file-merge sense), line 93 ("Target Users"), or CLAUDE.md line 25 ("target users") would corrupt a deliberate, correct usage. *Mitigation*: steps 2 and 4 name the preserve-list lines explicitly and instruct leaving them byte-for-byte intact; step 6's `rg` survey must return exactly those four matches — fewer means a preserved occurrence was wrongly edited, and the verdict fails.
- **Line-number drift during editing.** An edit that accidentally added or removed a line would invalidate the remaining pinned line numbers within that file. *Mitigation*: every planned edit is a word-level in-line replacement that adds and removes no lines, so line counts — and the pinned line numbers — are invariant for the whole pass and editing order does not affect them; were a line-count-changing edit ever required it would be applied bottom-to-top (highest line first). Step 6 confirms the preserve-list lines are still 69/83/93 and 25.
- **Re-sync omission.** Editing `shannon/` source but forgetting to re-copy to `.claude/skills/` leaves the running framework stale. *Mitigation*: step 5 is an explicit, named step covering both affected subtrees and the template-rides-along note; the Task is not IMPLEMENTED until step 5 is done.
- **Phrasing inconsistency across the three files.** The same gate concept worded three different ways if each file is edited in isolation. *Mitigation*: a single canonical reference (conceptual_design v1.5 / technical_design v1.1) is mandated for all three files; the file order (project-setup first) settles the house style before the gate-sensitive files are touched; TASK-C performs the formal four-way consistency audit as a backstop.
- **Accidentally touching a non-vocabulary line.** A stray edit to a heading, step, or unrelated sentence would violate the "vocabulary-only, no structural change" constraint. *Mitigation*: edits are scoped to the line-pinned occurrences only; step 6 includes a diff review confirming no headings/sections changed and `git status` shows only the three intended files modified.
- **Re-sync producing an apparently-empty `git status`.** Because `.claude/` is gitignored, the re-sync leaves no tracked diff — a reviewer could mistake this for "re-sync not done". *Mitigation*: step 6 verifies the deployed copies by content (the deployed tree should match source); the Activity Log will record the re-sync explicitly so Gate 3 review can confirm it happened. Note: per development_guide § Commit Cadence the commit lands only after Gate 3 — this Task produces no commit.

---

## Implementation Notes

Implemented 2026-05-23 via `/task-implement TASK-004`, following the Gate 2 six-step plan. 30 edits across the three files — 14 in `project-setup/skill.md`, 13 in `project-documentation/skill.md`, 3 in `templates/CLAUDE.md` — each a word-level per-occurrence rewrite naming the *directing party* (the gate-approving / directing role) or, in the gate sentences, the *implementer* that cannot approve its own work. Phrasing was copied from conceptual_design v1.5 (*Supervisor Distinct From Implementer*; *Three Hard Gates*; *Iterative Implementation Zone*) and technical_design v1.1, not invented.

The four preserved occurrences were left byte-for-byte intact: `project-setup/skill.md` lines 69 and 83 ("user content" — file-merge sense) and line 93 ("Target Users" — Vision template section name), and `templates/CLAUDE.md` line 25 ("target users" — Vision document content description).

**Gate rewrites** (`project-documentation/skill.md`): § Process: Review step 4 now reads "Ask the directing party explicitly:" — naming the directing party as the approver; § Quality Gates Gate 1 changed from "Explicit user approval required. AI cannot self-approve." to "Explicit approval by the directing party. The implementer cannot approve its own work."

**Verification** (step 6): `grep -nE "\b[Uu]sers?\b"` returns only the four preserved occurrences — `project-setup/skill.md` 69/83/93 and `templates/CLAUDE.md` 25; `project-documentation/skill.md` returns zero. Self-identification lines unchanged (`project-setup` lines 8/125, `project-documentation` 8/142). `git status` confirms `work-items/skill.md` is not modified — the cross-type scope boundary held.

**Deployed-copy re-sync** (step 5): `shannon/skills/project-setup/` and `shannon/skills/project-documentation/` re-copied to `.claude/skills/`; `diff -rq` confirms the deployed copies match source. `.claude/` is gitignored, so the re-sync produces no tracked diff — recorded here so Gate 3 can confirm it happened.

### Deviations from Plan

- None. The six steps were executed as planned.

### Gotchas

- `project-documentation/skill.md` § Process: Review step 4 (the `Ask explicitly:` line) carried no `user` token, but was still reworded to `Ask the directing party explicitly:` — EPIC-005 AC#2 and Plan step 3 require step 4 to *name* the directing party as the approver, so this is a naming addition, not a vocabulary removal. Counted among the 13 project-documentation edits.

### Documents Updated

- `shannon/skills/project-setup/skill.md` — 14 directing-party vocabulary edits (When to Invoke, Inputs, Process steps, Failure Modes); lines 69/83/93 preserved.
- `shannon/skills/project-documentation/skill.md` — 13 edits including the § Process: Review step 4 and § Quality Gates Gate 1 rewrites; zero `[Uu]sers?` matches remain.
- `shannon/skills/project-setup/templates/CLAUDE.md` — 3 edits (lines 65, 71, 133); line 25 preserved.
- `.claude/skills/project-setup/` and `.claude/skills/project-documentation/` — re-synced from `shannon/` source (gitignored; verified by `diff -rq`).

---

## Review

**Gate 3 — APPROVED 2026-05-23.** A verification subagent audited all 11 Acceptance Criteria against the three changed files and checked alignment with EPIC-005 and the V6 phrasing in conceptual_design v1.5 / technical_design v1.1. Verdict: *ready for Gate 3 approval* — all 11 ACs MET.

### Verification

- [x] All acceptance criteria met
- [x] Changes follow development_guide.md
- [x] Relevant documents updated
- [x] Knowledge captured where useful

### Review Notes

**All 11 ACs MET.** Every directing-party-sense `user` occurrence across the three files was reworded to V6 vocabulary; `grep "\b[Uu]sers?\b"` returns only the four preserved occurrences — `project-setup/skill.md` 69/83/93 ("user content" ×2, "Target Users") and `templates/CLAUDE.md` 25 ("target users"); `project-documentation/skill.md` returns zero. The two gate rewrites in `project-documentation/skill.md` (§ Process: Review step 4 and § Quality Gates Gate 1) are verbatim lifts of conceptual_design *Three Hard Gates* and *Supervisor Distinct From Implementer*, not loose paraphrase.

**Scope boundary held.** `work-items/skill.md` is not modified — its vocabulary sweep and `PLAN-PENDING` rewrite are TASK-B. The diff is provably word-level (every hunk a 1:1 line replacement), so the "no structural change" criterion is verifiable by inspection; self-identification lines unchanged on both edited skills.

**`.claude/` re-sync.** The gitignored deployed copies of `project-setup` and `project-documentation` were re-synced from `shannon/` source; `diff -rq` confirmed they match — re-verified independently at Gate 3, since a gitignored target leaves no tracked diff for a git-based audit to inspect.

**Findings — all Strength; no Drift, Gap, or internal contradiction.** Preserve-list discipline exemplary — the four distinct-sense occurrences left byte-for-byte intact while every role-sense occurrence was corrected, neither over- nor under-corrected. Per-occurrence judgement visibly applied: the role noun is dropped where the sentence reads naturally, and the iterative-zone sentence names both roles. One immaterial bookkeeping note: Implementation Notes tally "30 edits" against a 28-changed-line diff — the count treats multi-occurrence lines separately.

**Alignment.** Delivers EPIC-005 AC#6, AC#7, and the project-documentation half of AC#2 / AC#3. No drift against EPIC-005 or the V6 document layer.

---

## Activity Log

- **2026-05-23** — APPROVED via Gate 3. Directing party approved after verification — all 11 Acceptance Criteria MET. Every directing-party-sense `user` occurrence across the three files reworded to V6 vocabulary; the four distinct-sense occurrences (project-setup 69/83/93, CLAUDE.md 25) preserved; `project-documentation/skill.md` returns zero `[Uu]sers?` matches. Both gate rewrites verbatim from conceptual_design. `work-items/skill.md` untouched; `.claude/` re-sync independently re-confirmed at Gate 3. All 11 ACs checked. Status REVIEW → APPROVED; file archived to `docs/tasks/archive/`. Delivers EPIC-005 AC#6, AC#7 and the project-documentation half of AC#2/AC#3 — TASK-A complete; TASK-B (`work-items` skill) is next.
- **2026-05-23** — REVIEW. Status IMPLEMENTED → REVIEW; Gate 3 verification subagent spawned to audit all 11 Acceptance Criteria against the three changed files and check alignment with EPIC-005 and the V6 phrasing in conceptual_design v1.5 / technical_design v1.1.
- **2026-05-23** — IMPLEMENTED. All 6 plan steps executed. 30 word-level vocabulary edits across `project-setup/skill.md` (14), `project-documentation/skill.md` (13), and `templates/CLAUDE.md` (3); the four preserved occurrences (project-setup 69/83/93, CLAUDE.md 25) left intact. Gate rewrites applied to `project-documentation` § Process: Review step 4 and § Quality Gates. Verification: `grep "\b[Uu]sers?\b"` returns only the four preserved occurrences, `project-documentation` returns zero; self-identification lines unchanged; `work-items/skill.md` not modified (scope boundary held). `.claude/` deployed copies re-synced and confirmed matching source. Ready for Gate 3.
- **2026-05-23** — IMPLEMENTING via `/task-implement TASK-004`. Status PLANNED → IMPLEMENTING; executing the 6-step plan across `project-setup/skill.md`, `project-documentation/skill.md`, and the CLAUDE.md template.
- **2026-05-23** — PLANNED via Gate 2. Planning subagent drafted a 6-step plan (orientation → edit project-setup → edit project-documentation → edit CLAUDE.md → re-sync `.claude/` → verify), file order project-setup → project-documentation → CLAUDE.md, all 11 Acceptance Criteria mapped, 6 risks with mitigations. During Gate 2 review the directing party caught a flaw in the edit-mechanic rationale: the draft claimed top-to-bottom editing "protects pending line numbers" — backwards (bottom-to-top protects them), and moot here anyway since the edits are word-level in-line replacements that do not change line counts. The Approach, Step 2, and the line-number-drift Risk were corrected to state this accurately. Plan approved with that correction.
- **2026-05-23** — ELABORATED via Gate 1. Elaboration subagent surveyed the actual `[Uu]sers?` occurrences in the three target files and drafted 11 Acceptance Criteria in five groups (project-setup vocabulary + preserve-list, project-documentation Gate-1 / § Quality Gates rewrites, CLAUDE.md template, scope boundary, verification & distribution), each grep-checkable or line-pinned. Survey found minor drift in EPIC-005's Plan estimate: project-setup carries 17 occurrences (EPIC-005 said ~15) and a three-line preserve-list — lines 69, 83, and 93 ("Target Users") — where EPIC-005 named only 69/83. TASK-004's Requirements carry the corrected numbers; EPIC-005 left as-is (an estimate, not a defect). Alignment check: all Strength, no ambiguous occurrence needing a directing-party ruling. Directing party approved the requirements without modification.
- **2026-05-23** — DRAFT: Task created via `/task-create` under EPIC-005 — TASK-A of the three-Task plan. Created individually (not pre-stashed as a DRAFT stub) per EPIC-005's § Plan recommendation. Initial intent captured in the Overview and Context; Acceptance Criteria and Plan to be drafted at `/task-elaborate` and `/task-plan`.
