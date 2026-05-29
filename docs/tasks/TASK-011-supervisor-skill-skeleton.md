# TASK-011: Supervisor Skill Skeleton and Configuration Handling

## Metadata

- **Status**: ELABORATED
- **Type**: Task
- **Parent**: [EPIC-009](../epics/EPIC-009-health-reporting-surface.md)
- **Feature**: [FEAT-009](../features/FEAT-009-supervisor.md)
- **Tags**: #supervisor #skill #skeleton #configuration #portability
- **Created**: 2026-05-30
- **Updated**: 2026-05-30

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`. Tasks are archived to `./archive/` once APPROVED.

---

## Requirements

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-elaborate TASK-011` (Gate 1).*

### Overview

The foundational Task of EPIC-009: create the supervisor skill's directory skeleton at `./.claude/skills/shannon-supervisor/` and land the `SKILL.md` body that contracts the `/shannon-report` slash-command and the supervisor's configuration-file handling. This Task closes the structural half of EPIC-009 AC#1 (skill directory layout and self-identification) and the configuration-file half of EPIC-009 AC#6 (presence/absence handling without crashing). It is the prerequisite for every other Task in EPIC-009: the three checker definitions (Tasks 2–4) land under `checkers/`; the report writer (Task 5) and the two hooks (Tasks 6–7) all reference `SKILL.md`'s contracts; the dogfood run (Task 8) verifies them end-to-end. Out of scope here: the three checker definitions themselves (sibling Tasks 2–4); the report-writing pipeline (Task 5); the two hooks (Tasks 6–7); the first dogfood report (Task 8).

### Acceptance Criteria

- **AC#1 — Four-subdirectory layout exists.** The directory `./.claude/skills/shannon-supervisor/` exists with the four subdirectory children named at `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Skill directory layout*: `SKILL.md` (the supervisor logic file), `templates/` (report templates), `checkers/` (checker definitions — populated by sibling Tasks 2–4), `scripts/` (helper scripts). The `templates/` and `scripts/` subdirectories may be empty at this Task's Gate 3 (they are populated by Tasks 5 and 8); the existence of the directory is what matters. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Skill directory layout*.

- **AC#2 — `SKILL.md` carries the self-identification line.** The supervisor's `SKILL.md` begins with the explicit self-identification line per the Skill Invocation Pattern at `technical_design.md` v1.2 § API Design → *Skill Invocation Pattern* — the line that confirms the skill activated on invocation. The exact phrasing follows the established Shannon pattern (e.g. `When invoked, start your response with: "Activating shannon-supervisor skill for [verb]."`). The self-identification line applies to **direct command-invocation paths only** (`/shannon-report` and the EPIC-010 `/shannon-goal`); hook-event activations (PreToolUse and PostToolUse from sibling TASKs 16–17, and SessionStart / preCompact / Stop from sibling EPICs 010–011) are not user-message responses and do not emit a self-identification line. Derives from `technical_design.md` v1.2 § API Design → *Skill Invocation Pattern*.

- **AC#3 — `/shannon-report` slash-command contract codified in `SKILL.md`.** `SKILL.md` codifies the `/shannon-report` slash-command's contract: takes no arguments; fans out into the three checker subagents (Alignment, Lifecycle, Drift) per AC#2 of the parent Epic; aggregates findings; writes a dated report at `./docs/supervisor/report-YYYY-MM-DD.md`; indexes the report in `knowledge_index.md` under Type *Supervisor Report*. The full report-writing pipeline lives in Task 5 (`SKILL.md` may reference it by section anchor); this Task's scope is the contract statement. Derives from `technical_design.md` v1.2 § System Architecture → *Supervisor* → *Slash-command surface* and § API Design → *Supervisor Verbs*.

- **AC#4 — Configuration-file presence/absence handled without crashing.** `SKILL.md` codifies the configuration-file handling per `technical_design.md` v1.2 § Data Model → *Supervisor Configuration*: if `./.claude/shannon-supervisor.json` is absent, all fields take the supervisor-authority defaults (`epic_gate_authority: supervisor`, `spike_gate_authority: supervisor`, `report_directory: docs/supervisor`); if present, the file's named fields override defaults uniformly; absent fields take the default even when the file is present. The skill must not crash on a missing file or on a present-but-empty file. Verifiable: a dry-run invocation with no configuration file present succeeds using defaults; an invocation with an empty `{}` JSON file present succeeds using defaults. Derives from `technical_design.md` v1.2 § Data Model → *Supervisor Configuration* and parent Epic AC#6.

- **AC#5 — Project-relative paths throughout `SKILL.md` and templates.** Every path reference inside `SKILL.md` uses project-relative form (`./docs/`, `./.claude/`) — no Shannon-self-specific paths (e.g. `docs/features/FEAT-009-supervisor.md` literal), no hardcoded absolute paths, no references to `/Volumes/`, `~/`, or this repository's specific file names. This converts the FEAT-009 § Plan Risk *Supervisor skill portability not exercised until first non-Shannon-self deployment* into a Gate-3-checkable artefact per parent Epic AC#1 G-F extension. Verifiable: a literal grep of `SKILL.md` for the substrings FEAT-, EPIC-, Shannon-self, /Volumes/, ~/, and the absolute path of this repository returns no matches. Derives from parent Epic AC#1 (the G-F portability extension applied at Gate 1).

- **AC#6 — Scope-bounded edit: no sibling Task's territory touched.** Per `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*: this Task creates `./.claude/skills/shannon-supervisor/SKILL.md` and the four-subdirectory layout only. No checker definitions under `checkers/` (Tasks 2–4 territory); no report-writer logic body under `SKILL.md` § Report Pipeline (Task 5 territory); no hook configuration in any `settings.json` (Tasks 6 and 7 territory); no `./docs/supervisor/` directory contents (Task 8 territory); no mandated document amended (parent Epic AC#9 — additive only, and the supervisor skill is net-new not a document amendment); no `./shannon/skills/shannon-supervisor/` shipping-source mirror — the distribution mirror that pairs with `./.claude/skills/shannon-supervisor/` for `/shannon-setup` deployment to non-Shannon-self projects is **explicitly deferred** to a future `/shannon-setup`-update Epic (see § Risks below), not silently out of scope. Derives from `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* and parent Epic AC#8.

### Context

- **Parent Epic**: [EPIC-009 — Health Reporting Surface](../epics/EPIC-009-health-reporting-surface.md) — this is Task 1 of 8; closes EPIC-009 AC#1 (structural half) and AC#6 (configuration-file handling half).
- **Parent Feature**: [FEAT-009 — Supervisor](../features/FEAT-009-supervisor.md) — § Ideal State *Portability to non-Shannon-self projects* (AC#5 here is the portability discipline's first lived exercise).
- **Technical Design**: § System Architecture → *Supervisor* → *Skill directory layout* (AC#1 source); § API Design → *Skill Invocation Pattern* (AC#2 source); § API Design → *Supervisor Verbs* + § System Architecture → *Supervisor* → *Slash-command surface* (AC#3 source); § Data Model → *Supervisor Configuration* (AC#4 source).
- **Technology Stack**: § Supervisor Tooling → *Committed primitives* → *Skill frontmatter control* (the primitive this Task exercises); § Supervisor Tooling → *Configuration storage* (`./.claude/` as the configuration root).
- **Conceptual Design**: § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (AC#6 source).
- **Phase-0 Spike**: § 4 (Skills Discovery & Packaging — informs the four-subdirectory layout).
- **Sibling Tasks** (downstream): TASK-012 (Alignment Checker), TASK-013 (Lifecycle Checker), TASK-014 (Drift Checker), TASK-015 (Report writer + index updater), TASK-016 (PreToolUse hook), TASK-017 (PostToolUse hook), TASK-018 (Dogfood run).

---

## Plan

*Prepared during EPIC-009 planning (Gate 2), not yet reviewed. Surfaces at `/task-plan TASK-011` (Gate 2).*

### Approach

Create the four-subdirectory skeleton, then author `SKILL.md` as a single coherent body containing: (a) the self-identification line at the top; (b) the `/shannon-report` slash-command contract; (c) the configuration-file presence/absence handling logic. Follow the editing-order convention at `development_guide.md` v1.4 § Code Style → Patterns to Follow → *Source-of-truth body before derived artefacts*: the skill body is the source-of-truth; there is no derived artefact at this Task (the deployed-copy re-sync convention from TASK-009 does not apply because this skill is written directly into `./.claude/` — it is not mirrored from `./shannon/skills/`). Apply the plain-prose substring discipline (parent Epic AC#7) to AC#5's grep targets — verbatim substrings land as plain prose.

### Steps

1. **Create the four-subdirectory layout.** `mkdir -p ./.claude/skills/shannon-supervisor/{templates,checkers,scripts}`. Closes AC#1 structural half.
2. **Author `SKILL.md`** with the self-identification line, the `/shannon-report` contract, and the configuration-file handling logic. Use project-relative paths only — discipline check at end. Closes AC#2, AC#3, AC#4.
3. **Portability discipline verification.** Run literal greps against `SKILL.md` for the substrings `FEAT-`, `EPIC-`, `Shannon-self`, `/Volumes/`, this repository's absolute path. Each grep must return zero hits. Closes AC#5.
4. **Scope-bounded-diff verification.** Run `git status` to confirm only the expected new files under `./.claude/skills/shannon-supervisor/` are present and no sibling Task's territory has been touched. Closes AC#6.

### Dependencies

- **Depends on**: EPIC-009 PLANNED (Gate 2 must be approved before this Task elaborates). No sibling Task dependencies — this Task is the foundation of EPIC-009.
- **Cascade docs**: `technical_design.md` v1.2 (frozen at APPROVED); `technology_stack.md` v1.3 (frozen at APPROVED); `conceptual_design.md` v1.7 (frozen at APPROVED).

### Risks

- **`SKILL.md` body bloating into Task 5 territory.** The temptation will be to write the report-writing pipeline inline. **Mitigation**: AC#3 names the slash-command *contract*, not the implementation body; reference Task 5 by section anchor when describing the pipeline.
- **Portability check missing a Shannon-self leak.** A hardcoded path or example pointing at `docs/features/FEAT-009-...` could slip in. **Mitigation**: AC#5's grep targets are explicit; Step 3 runs them as a checklist.
- **Shipping-source mirror not yet established.** The supervisor skill is built directly into `./.claude/skills/shannon-supervisor/` only. Shannon's existing convention mirrors skills across `./shannon/skills/` (shipping source distributed by `/shannon-setup`) AND `./.claude/skills/` (deployed copy); FEAT-009 § Ideal State *Portability to non-Shannon-self projects* ultimately requires the mirror to ship the supervisor to other projects. **Mitigation**: the shipping-source mirror is **explicitly deferred** to a future `/shannon-setup`-update Epic that handles supervisor-skill deployment to non-Shannon-self projects (likely bundling Supervisor Report subtype handling for `knowledge_index.md` plus per-project gate-authority configuration into one coherent deployment Epic). EPIC-009 ships the operational supervisor for Shannon-self only; the distribution-to-other-projects concern becomes real when a second project adopts. Tracked via scratchpad M-10 (Shipping-source mirror convention for new skills not codified at framework level).

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

*Filled at Gate 3.*

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

- **2026-05-30** — ELABORATED (Gate 1 approved). Requirements refined from the prepared elaboration draft (carried over from EPIC-009 planning ratification commit `87626bb`). Three refinements applied inline at ratification: (R-1) AC#5 verifiable-sentence grep targets widened to include `~/` (matching the existing prose example in the Overview) and stripped of backticks per parent Epic AC#7 plain-prose substring discipline — closes Drift D-1; (R-2) AC#6 scope-guard extended to name the `./shannon/skills/shannon-supervisor/` shipping-source mirror as **explicitly deferred** to a future `/shannon-setup`-update Epic (rather than silently out of scope), with matching Risk added to § Risks forward-referencing the deferral home — closes Gap G-1; (G-2) AC#2 clarified that the self-identification line applies to direct command-invocation paths only (`/shannon-report`, `/shannon-goal`); hook-event activations are not user-message responses and do not emit a self-identification line — closes Gap G-2. **Directing-party decision at G-1**: shipping-source mirror deferred to a future `/shannon-setup`-update Epic — EPIC-009 is "first operational supervisor" and Phase 2 ships the supervisor for Shannon-self; the distribution-to-other-projects concern becomes real when a second project adopts and fits with a future Epic that updates `/shannon-setup` (likely including knowledge_index Supervisor Report subtype handling and per-project gate-authority configuration in the same Epic). No further Drift after R-1 closure (D-2 is a framework-general `technical_design.md` v1.2 internal inconsistency between lines 53 and 80, not a TASK-011 defect — routed to M-9). No Internal Contradiction. Six Strengths preserved (S-1 cascade-doc citation rigour — every AC carries a verified-accurate `Derives from` line per the field-report discipline; S-2 cross-type-guard form correctly applied at AC#6; S-3 scope-boundary completeness verified against sibling TASK-015 / TASK-016 / TASK-017 / TASK-018; S-4 configuration-handling concrete dry-run cases; S-5 portability discipline Gate-3-checkable grep targets; S-6 source-of-truth body discipline acknowledged at within-Task level honestly). **Two framework-general ambiguities routed to `scratchpad.md` per `development_guide.md:114`**: (M-9) `SKILL.md` filename casing inconsistency in `technical_design.md` v1.2 between line 53 (general § Skills lowercase `skill.md`) and line 80 (supervisor uppercase `SKILL.md`) — candidate `technical_design.md` § Skills clarification at next cascade revision; (M-10) Shipping-source mirror convention for new skills not codified at framework level — candidate `development_guide.md` § Code Style → Patterns to Follow extension or `shannon/skills/project-setup/skill.md` mirror-detection extension; the G-1 directing-party decision deferred the supervisor-skill mirror to a future `/shannon-setup`-update Epic. M-7 (portability discipline as verifiable convention) routing carried forward unchanged — TASK-011 implementation is its first lived exercise; revisit at TASK-011 Gate 3 with lived-in evidence. Prepared Plan draft (Plan section) carries forward unchanged to `/task-plan TASK-011` (Gate 2) — Approach paragraph's deployed-only framing now consistent with refined AC#6 + new Risk after R-2. Status: DRAFT → ELABORATED.
- **2026-05-30** — DRAFT: Task stub created with prepared elaboration draft and prepared plan draft during EPIC-009 planning (Gate 2). Cascading Preparation pattern per `technical_design.md` v1.2 § Key Algorithms → *Cascading Operations*. When the directing party runs `/task-elaborate TASK-011`, the prepared elaboration surfaces for Gate 1 review; when they run `/task-plan TASK-011`, the prepared plan surfaces for Gate 2 review. Descriptive title (*Supervisor Skill Skeleton and Configuration Handling*) used from the outset per `conceptual_design.md` § Domain Model → *Work Item* Naming. Parent: EPIC-009. Full elaboration pending `/task-elaborate TASK-011` (Gate 1).
