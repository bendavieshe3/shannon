# TASK-022: Goal-Decomposition `/shannon-goal` Skill and Command

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-010](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #command #goal-decomposition
- **Created**: 2026-07-18
- **Updated**: 2026-07-19

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Elaborated and approved at Gate 1 on 2026-07-19 (DRAFT → ELABORATED).*

### Overview

Implement the `/shannon-goal [intent]` entry-point as a new contract section in `./shannon/skills/shannon-supervisor/SKILL.md`, plus the thin command file `./shannon/commands/shannon-goal.md` (deployed to `./.claude/`), and register the new verb across the skill's verb-facing prose. Given a free-text intent (e.g. *"make onboarding feel less abrupt"*), the skill produces a categorised list of candidate work items — those aligned with existing artefacts (cited by ID) and those surfacing gaps (flagged for the approval authority they require) — reusing EPIC-009's shipped checker fan-out for artefact discovery in the aligned category rather than rebuilding it, but **read-only**: `/shannon-goal` writes no report file and no knowledge-index entry. Out of scope: the SessionStart / preCompact hooks (TASK-025 / TASK-026), the zero-findings pattern (TASK-024), and any checker or template change.

### Acceptance Criteria

- [ ] **AC#1 — `/shannon-goal` contract + thin command authored in `./shannon/`.** A new `## /shannon-goal — Contract` section in `SKILL.md` defines the verb; the thin command file `./shannon/commands/shannon-goal.md` follows the `/shannon-report` command pattern (invoke skill, pass verb `goal`, fallback wording), deployed to `./.claude/commands/`. *Derives from* `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Slash-command surface* + § API Design → *Supervisor Verbs*, and the EPIC-009 TASK-020 command-entry-point lesson.
- [ ] **AC#1b — `/shannon-goal` registered across the skill's verb-facing prose.** `SKILL.md` § When to Invoke gains a `/shannon-goal [intent]` entry; the § Self-Identification section and the header note at the top of the file are updated so neither states or implies that `/shannon-report` is the only direct slash-command invocation. *Derives from* `technical_design.md` v1.2 § API Design → *Skill Invocation Pattern* (self-identification contract); the § /shannon-goal contract created by AC#1.
- [ ] **AC#2 — Output shape matches the ux_guide example.** A `/shannon-goal` invocation renders the four elements of the ratified example at `ux_guide.md` v1.2 § Command Surface → *Supervisor Commands*: an `Intent:` echo line; a Candidates aligned with existing artefacts heading carrying a parenthesised count; a Candidates surfacing gaps heading carrying a parenthesised count; and the promotion-authority footer naming that Tasks may be auto-promoted on supervisor authority while Epics and Features require directing-party approval. The two category labels land as plain prose in `SKILL.md` (no backticks, italics, or bold interposing) so each passes a literal grep. *Derives from* parent EPIC-010 AC#1.
- [ ] **AC#3 — Aligned candidates cite the artefact they align with.** Candidates in the aligned category name the specific Feature, Epic, or document section they align with. Verifiable: a test invocation against an intent that maps to an existing Feature produces output naming that Feature by ID. *Derives from* parent EPIC-010 AC#6.
- [ ] **AC#4 — Gap candidates flag directing-party approval per the Gate Authority Split.** Candidates *surfacing gaps* explicitly indicate which require directing-party approval before promotion to Feature/Epic (Tasks auto-promotable on supervisor authority). *Derives from* `conceptual_design.md` § Business Rules → *Gate Authority Split*; parent EPIC-010 AC#1.
- [ ] **AC#5 — Live dogfood invocation.** A test invocation against a real Shannon-self intent, executed against the deployed `./.claude/` copy, produces conforming output with both categories present (or an explicit "no candidates in category X" line). Consistent with EPIC-009 § Implementation Notes → *Runtime integration is unverified and honestly deferred*, this AC verifies the contract's behaviour when exercised; literal slash-command auto-triggering remains EPIC-011's to close and is not claimed here. *Derives from* parent EPIC-010 AC#1 verifiable clause.
- [ ] **AC#6 — Plain-prose discipline + scope-bounded edit.** Any grep-verified verbatim phrase lands as plain prose (parent AC#7). This Task creates the `/shannon-goal` `SKILL.md` section (plus the AC#1b verb-registration edits) and the command file only; it does **not** modify any checker definition, report template, hook script/snippet, mandated document, the `/shannon-report` contract section, or any other skill (cross-type-guard phrasing per parent AC#8). *Derives from* `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*.
- [ ] **AC#7 — Reuse of the shipped pipeline is read-only.** The `/shannon-goal` contract reuses the § Report Pipeline checker fan-out and four-category fragment schema for artefact discovery in the aligned category, but writes no file: it produces no dated report under the configured report directory and appends no `knowledge_index.md` entry. *Derives from* `SKILL.md` § Report Pipeline steps 5–6 (which are report-write-specific); parent EPIC-010 § Approach.
- [ ] **AC#8 — Failure modes surface specifically.** The `/shannon-goal` contract names a missing or malformed supervisor configuration explicitly and points the directing party at `./.claude/shannon-supervisor.json`, per `ux_guide.md` v1.2 § Command Surface → *Supervisor Commands* (which binds both supervisor commands to this behaviour) and `SKILL.md` § Failure Modes. *Derives from* `ux_guide.md` v1.2 § Command Surface → *Supervisor Commands*; `technical_design.md` v1.2 § Data Model → *Supervisor Configuration*.

### Context

- **Parent Epic**: [EPIC-010 — Synthesis and Reports](../epics/EPIC-010-synthesis-and-reports.md)
- **Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Goal decomposition via `/shannon-goal`*
- **Relevant documents**: `technical_design.md` v1.2 § System Architecture → *Supervisor* + § API Design → *Supervisor Verbs*; `ux_guide.md` v1.2 § Command Surface → *Supervisor Commands*; `conceptual_design.md` v1.7 § Business Rules → *Gate Authority Split* + *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*; `development_guide.md` v1.4 § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts* (source-before-deploy editing order)
- **Related work**: EPIC-009 (shipped aggregation pipeline; TASK-020 command-entry-point lesson)

---

## Plan

*Prepared during EPIC-010 planning, not yet reviewed. Surfaces at `/task-plan TASK-022` (Gate 2).*

### Approach

Author the `/shannon-goal` contract in `SKILL.md` (source-of-truth) then the thin command file; deploy both to `./.claude/`. The contract reuses the shipped § Report Pipeline aggregation for the aligned category and adds the intent-decomposition + categorisation logic. Verify with a live Shannon-self invocation before commit.

### Steps

1. Author `## /shannon-goal — Contract` in `SKILL.md` (intent arg, two-category decomposition, aligned-cites, gap-approval flagging, output shape).
2. Author `./shannon/commands/shannon-goal.md` on the `/shannon-report` pattern.
3. Deploy both to `./.claude/`; `diff` confirms identical.
4. Live dogfood invocation against a real intent; confirm shape + both categories (AC#5).
5. Plain-prose grep of the landed verbatim phrases (AC#6).
6. `git diff` scope-bounded verification; absence checks (no checker/template/hook/other-skill change).

### Dependencies

- EPIC-009 APPROVED (aggregation pipeline + `SKILL.md` skeleton). Independent of sibling EPIC-010 Tasks. First (or parallel) in the order.

### Risks

- Decomposition heuristic quality is directional, not shape-verifiable — mitigated by AC#1/AC#2 verifying shape; quality measured after dogfood.
- `SKILL.md` edit collides with sibling Tasks — mitigated by editing-order sequencing (TASK-022 first).

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

- **2026-07-19** — ELABORATED (Gate 1 approved). Verification pass on the prepared elaboration draft against the authoritative documents: all three cited doc sections confirmed to exist, all version numbers (`ux_guide` v1.2, `technical_design` v1.2) confirmed correct, and the Gate Authority Split direction confirmed *not* reversed (Tasks auto-promotable; Epic/Feature require directing-party approval). Requirements grew from 6 ACs to 9. **AC#1b added** — the prepared draft created the verb but never registered it, leaving `SKILL.md` § Self-Identification factually wrong (names only `/shannon-report`) and § When to Invoke silent on `/shannon-goal`. **AC#7 added** — the "reuses EPIC-009's aggregation" claim was overstated; the shipped § Report Pipeline writes a dated file and appends to `knowledge_index.md`, so reuse is now explicitly bounded read-only (no file side-effects, matching the ux_guide example). **AC#8 added** — `ux_guide.md:92` binds both supervisor commands to naming a missing config and pointing at `./.claude/shannon-supervisor.json`; no AC had covered `/shannon-goal` failure modes. **AC#2 revised** — the ratified example has four elements (Intent echo, both counts, footer), not two; the greppable category labels now land as plain prose. **AC#3 revised** — restored parent AC#6's *Verifiable* clause (name the Feature by ID). **AC#5 revised** — scoped honestly: verifies contract behaviour when exercised; literal slash-command auto-triggering stays deferred to EPIC-011 per EPIC-009's honest deferral. **AC#6 revised** — guard widened to include mandated documents (sibling TASK-024 contemplates a `ux_guide` amendment, so document-editing is live in this Epic). Context gained the `development_guide` v1.4 source-before-deploy rule and doc versions. Directing-party disposition: the Spike-promotion case that `conceptual_design.md` v1.7 establishes but the `ux_guide.md` v1.2 footer omits is a Guide-vs-upstream alignment question — routed to `scratchpad.md` for `/document-review ux_guide.md`, not folded into this Task (Tasks consume Guides; they do not update them). Status: DRAFT → ELABORATED.
- **2026-07-18** — DRAFT: Task created during EPIC-010 planning (Gate 2) with **prepared elaboration draft** and **prepared plan draft** (Cascading Preparation per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*). Covers EPIC-010 AC#1 and AC#6. Descriptive title used from the outset. Prepared drafts surface at `/task-elaborate TASK-022` (Gate 1) and `/task-plan TASK-022` (Gate 2).
