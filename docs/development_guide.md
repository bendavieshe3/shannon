# Development Guide

**Status**: APPROVED
**Last Reviewed**: 2026-11-01
**Approved**: 2026-11-01 (feature-level governance design; implementation pending independent review)

---

**Project Name**: Shannon

## Environment Setup

### Prerequisites

- **Git** — for cloning the source repository and tracking template/command changes
- **Claude Code** — Shannon is a Claude Code framework; development happens inside it

### First-Time Setup

1. Clone the repository: `git clone https://github.com/<owner>/shannon.git`
2. Open the repository in Claude Code
3. Read `CLAUDE.md` at the project root for an orientation to the codebase
4. Read `docs/vision.md` to understand what Shannon is and is not

### Secrets and Configuration

Shannon has no secrets and requires no configuration. The framework operates entirely on local files.

---

## Build and Run

Shannon has no build step. Templates are plain Markdown files; they are "run" by being copied into a deployed project's `.claude/` directory and invoked through Claude Code commands.

### Develop

No dev server. Edit Markdown files directly in Claude Code.

### Test

There is no automated test suite for Shannon itself. Validation happens by deploying templates into a real project and exercising the workflow. See **Testing Strategy** below.

### Build

There is no build. Distribution is git-based: users clone or copy the `shannon/` source tree into their project's `.claude/`.

---

## Code Style

Shannon contains almost no code — its substance is Markdown templates and prompts. Style rules apply to those.

### Markdown

- **Heading hierarchy** — One `#` per file (the title). Subsections use `##`, sub-subsections `###`. Never skip levels
- **Line length** — No hard wrap; let editors and renderers handle wrapping. Tables and code blocks excepted
- **Lists** — Dash (`-`) bullets, two-space indent for nested levels. Numbered lists only for ordered procedures
- **Code blocks** — Fenced (triple backticks) with a language tag where one applies; use ` ``` ``` ` plain for ASCII diagrams and shell snippets without a clear language
- **Spelling** — British English in prose ("colour", "behaviour", "organisation"); American spelling allowed in code identifiers where the surrounding ecosystem uses it

### Template Structure

- **Frontmatter is metadata at the top** — `**Status**`, `**Last Reviewed**`, `**Project Name**` (where applicable), as a block under a single `---` separator
- **Placeholders use square brackets** — `[Project name]`, `[YYYY-MM-DD]`, `[Description]`
- **Comments use HTML `<!-- ... -->`** — Sparingly; prefer self-explanatory structure over instructional comments
- **No example blocks in templates** — Templates are the shape, not a tutorial. Examples belong in guides

### Naming

- **Files** — kebab-case (`feature-create.md`, `shannon-overview.md`)
- **Work item slugs** — kebab-case derived from the work item name (`FEAT-001-easy-to-setup.md`)
- **Directory names** — lowercase, single-word where possible (`skills`, `templates`, `commands`, `guides`)

### Patterns to Follow

- **Self-contained templates** — A template should be usable without referring to a separate "how to fill this in" guide. Inline guidance is allowed; tutorial-length explanations are not
- **Explicit skill invocation** — Commands state "You MUST invoke the [skill] skill" rather than assuming activation
- **Single source of truth per concept** — If a concept (e.g. the unified status model) appears in multiple files, one file is canonical and others reference it
- **Source-of-truth body before derived artefacts** — When an edit touches a source-of-truth body and one or more derived indexes, references, or bookkeeping artefacts, work *source-of-truth body before derived index / references, then verify*. *Derived artefacts* explicitly include: **work-item index entries** (e.g. `task_index.md`, `epic_index.md`, `feature_index.md`); **parent Tasks-line entries** (the line in a parent work item's § Tasks / § Plan list naming the child); and **cross-references that name the source-of-truth artefact by path or ID** (other documents pointing at the edited artefact). Verification is re-reading the body and, where applicable, a `grep` of the derived state to confirm convergence. Worked precedent: **TASK-003** (`docs/tasks/archive/TASK-003-apply-partial-completeness-affordance.md`). Companion edit-discipline rule: see `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* (the AC-writing convention from EPIC-007 AC#4)
- **Acceptance criteria cite the governing rule** — An acceptance criterion asserts the **governing rule**: a `conceptual_design.md` business rule, or the prose commitment in a Guide. Two forms of citation fail, and both fail the same way — the criterion ends up asserting something other than the rule:
  - **A worked example read as a specification.** An example is illustrative and may abbreviate. Copying it verbatim into an AC imports the abbreviation as shipped behaviour.
  - **A version-pinned document citation** (*"`ux_guide.md` v1.2 § Command Surface"*). Documents move. The pin does not, so the criterion silently starts asserting a superseded shape.

  A fenced example or a version-pinned reference may be cited as **corroborating evidence** — never as the thing the criterion asserts. Where an AC needs a grep-verifiable substring, draw the substring from the rule, not from an illustration of it.

  The pull toward the example is not carelessness: a worked example is *testable* where Guide prose usually is not, so an implementer drafting an AC reaches for the example precisely because it yields a verifiable criterion. The convention's job is to give them the rule to reach for instead.

  Worked precedent — three instances across two Epics, one cause: **TASK-022 AC#2** (cited the ratified `ux_guide.md` example, which listed three promotion targets where the rule has four; corrected by TASK-027); the **TASK-023 prepared draft** (derived the wrong report-header shape from an abbreviated example in the same Guide); **EPIC-010 AC#1/AC#2** (pinned `ux_guide.md` v1.2 while the Guide reached v1.4, so read literally at Gate 3 the AC demanded the output shape TASK-027 had just corrected away from). Companion AC-writing rule: `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards*

### Patterns to Avoid

- **Verbose example blocks inside templates** — Templates should be the shape; examples bloat them and tempt readers to copy the example verbatim
- **Implicit cross-references** — Always include explicit paths or section anchors when one document references another
- **Status fields in places without a real status** — Only DRAFT/APPROVED on mandated documents; the human-governed lifecycle on Features; optional execution records may use progress labels without mandatory gates

---

## Testing Strategy

Shannon has no unit tests because Shannon has no units. The framework's correctness is the correctness of templates and prompts in the eyes of Claude Code and a real user.

### Test Levels

- **Template review** — Read each template after changes to check the shape is coherent and the placeholders are sensible
- **Deployed exercise** — Deploy the changed templates into a fresh project. Run the full lifecycle on a real work item. Confirm the AI follows the intended flow at each gate
- **Dogfood pass** — Run new commands and skills against this repository's own `docs/`. If something feels awkward when applied to Shannon itself, it will feel awkward elsewhere

### What to Test

- Every command's skill invocation actually triggers the intended skill
- Every Feature quality gate requires explicit human approval; optional records add no human gates
- Every template renders to a coherent document when instantiated
- Every index update happens at the right transition

### Pre-Commit Checklist

Before committing template, command, or skill changes:

- [ ] Templates open and render in a Markdown viewer without errors
- [ ] No stale references to removed concepts (e.g. "phases", "code_style_guide.md")
- [ ] Cross-references are correct paths
- [ ] At least a mental dry-run of the affected workflow
- [ ] Did this work resolve a **framework-general ambiguity surfaced during this work — a convention, workflow gap, or rule clarification that future work items would otherwise re-derive**? If yes, capture it in `scratchpad.md` for promotion or open a follow-up work item against the relevant mandated document. The capture responsibility also appears in `shannon/skills/work-items/skill.md` § Feature lifecycle → Implement — agent-managed delivery.

### Instrumentation

Distinct from the absent test suite, instrumentation is the work of capturing data needed to evaluate the vision's *Measurable Targets*. Currently:

- **Documentation upkeep ratio** (<10% of session time on `/document-*` commands) — Requires session-time tracking inside the `project-documentation` skill. Not yet implemented; flagged in vision § Measurable Targets as a future commitment
- **Planning approval rate** (80%+ at Gate 2 without revision) — Measurable from Feature Activity Log entries; no separate instrumentation needed
- **Setup time** (<5 min from `/shannon-setup` to first Feature approach approval) — Measurable by timestamps; no separate instrumentation needed

Instrumentation lives in the skill that owns the relevant workflow. As measurable targets are added or refined, the corresponding instrumentation is part of the work that introduces them.

---

## Git Workflow

### Branching

- **master** — default integration branch, changed through reviewed pull requests.
- **Topic branches** — implement coherent tested changes on a branch; preserve Feature or governing engineering-rule traceability.

### Commits

- **Conventional, but not strict** — Capitalised imperative subject ("Add X", "Refactor Y", "Fix Z"). Body explains "why" when not obvious
- **No commit hooks** — Shannon has no test suite; hooks would have nothing to enforce

### Commit Cadence

Commit coherent, checked changes throughout authorised execution; do not wait for an optional work-item gate. Record explicit Feature/document decisions with their source. Feature Gate 3 acceptance remains a human decision distinct from a commit or merge. Never commit before running appropriate checks.

Supervisor reports may be committed as a single checked reporting change under the project's existing contribution permissions. A reporting run neither approves Features nor grants publication authority.

### Push Cadence

Push tested topic-branch commits during authorised work and at handoff, subject to publication permission. This repository is public: inspect the staged diff for secrets, private deployment details and unrelated changes first. Do not infer human Feature acceptance, live deployment or permission for unattended operation from a push.

### Pull Requests

All Shannon source changes reach the default branch through a pull request. An approved reviewer who did not implement or push the change must approve the current head before merge. Resolve findings and obtain fresh approval after a head change. Human product acceptance is distinct from technical approval and merge.

### Multi-Agent Coordination

The human directs Vision and Features; the implementer delivers and tests; a distinct reviewer provides independent technical judgement. The human can accept delivered work, including agent-produced work. Optional supervisors audit health without lower-level gate authority.

Delegation is optional and requires the applicable authorisation. Concurrent agents coordinate disjoint changes, re-read before writes and reconcile diffs without silent overwrite. Allocate IDs against current indexes. The implementer cannot satisfy independent review by changing its own role label.

### Supervisor Report Files

Supervisor reports are Knowledge Note subtypes (per `conceptual_design.md` § Domain Model → *Knowledge Note*) living at `./docs/supervisor/report-YYYY-MM-DD.md`. The full storage and naming convention — including same-day suffix handling — is codified in `technical_design.md` § Data Model → *Supervisor Report Files*. The development guide's dogfood-specific commitments:

- **Reports are committed, not gitignored** — Supervisor reports are durable project knowledge; they ride the supervisor-batch commit cadence above and live in version control alongside the rest of `docs/`
- **Same-day suffix files are also committed** — A `report-YYYY-MM-DD-2.md` from a second run on the same date is committed as-is; the cadence does not retroactively edit the prior report
- **Optional state file is gitignored** — `./.claude/supervisor/state.json` (per `technical_design.md` § Data Model → *Cadence State*) is a local-only UX aid; it does not belong in the remote

---

## CI/CD

### Pipeline Stages

None. Shannon has no compiled artefacts, no automated tests, and no deployment target. The "pipeline" is: edit Markdown, deploy into a project, exercise.

### Distribution

- **Primary** — `git clone` from GitHub, then copy the `shannon/` tree into the target project's `.claude/`
- **Roadmap** — Curl install script, GitHub template repository, language-specific package managers (npm, pip)

---

## Version History

### 2026-11-12 - Reference repair

- Replace the removed soft-prompt pointer with the current implementation section, clarify Feature-only lifecycle labels and measure planning approval from Feature logs. Factual alignment within the approved Feature-level governance design; no new Feature delivery acceptance is recorded.

### 2026-11-01 - v2.0

- Substantive revision approved by Ben: preserve all six documents and alignment, trace everything from the Vision, retain human Feature gates, and let agents manage execution below Features. Independent review remains distinct from implementation. Historical work records and identifiers are preserved.


### 2026-08-28 - v1.5

- Per TASK-029 — Acceptance Criteria Cite Governing Rules, Not Version-Pinned References — one additive amendment codifying a convention surfaced through three shipped defects across two Epics:
  - **§ Code Style → Patterns to Follow** — new bullet *Acceptance criteria cite the governing rule*, sibling to *Source-of-truth body before derived artefacts*. Names both failure forms (a worked example read as a specification; a version-pinned document citation), states the corroborating-evidence allowance, and names why the pull toward the example exists (an example is testable where Guide prose is not). Cites three instances as worked precedent — TASK-022 AC#2, the TASK-023 prepared draft, EPIC-010 AC#1/AC#2. Cross-references `conceptual_design.md` § Business Rules → *Scope-Boundary Acceptance Criteria Use Cross-Type Guards* as companion AC-writing rule
- Companion skill-half landed in the same Task per the EPIC-008 two-touch precedent: `shannon/skills/work-items/skill.md` § Process: Elaborate carries a step-adjoining soft prompt at the moment acceptance criteria are drafted, pointing back at this pattern
- Amended **by a work item rather than `/document-review`**, per `conceptual_design.md` v1.8 § Business Rules → *Work Items Consume the UX Guide; May Refine the Development Guide* — the Development Guide describes the process work items execute, so the amendment rides TASK-029's own gates
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing → *Status semantics*** — no existing approved claim contradicted; document stays APPROVED across the bump (no DRAFT transition)
- Status: APPROVED (2026-08-28)

### 2026-05-29 - v1.4

- Cascade from Vision v2.4 (APPROVED 2026-05-28, commit `d2fd797`), conceptual_design v1.7 (APPROVED 2026-05-29, commit `a8fe1e0`), technology_stack v1.3 (APPROVED 2026-05-29, commit `c7d66e4`), and technical_design v1.2 (APPROVED 2026-05-29, commit `71b7ac5`) introducing the supervisor as a third role and codifying the gate-authority split. Pass 1 alignment surfaced findings DG-1 and DG-2; this version addresses both, plus the optional § Supervisor Report Files dogfood note
  - **§ Git Workflow → Branching** — refreshed "supervisor + implementer under V6" wording to the three-role taxonomy (directing party, supervisor, implementer) per Vision v2.4 § Target Users → *Three roles, configurably separable* and conceptual_design v1.7 § Glossary
  - **§ Git Workflow → Multi-Agent Coordination** — opening paragraph refreshed to the three-role taxonomy; two typical configurations named explicitly (directing party + implementer with directing-party-as-supervisor solo collapse; directing party + supervisor + implementer fuller case); closing "future versions" sentence updated to reference the canonical *Supervisor Distinct From Implementer* rule rather than "supervisor ≠ implementer"
  - **§ Git Workflow → Commit Cadence** — new sub-subsection *Supervisor cadence runs* committing to one commit per autonomous run (rather than per gate inside the run), a `Supervisor report YYYY-MM-DD` subject convention, and interactive-`/shannon-report` falling back to the standard per-gate cadence
  - **§ Git Workflow → Push Cadence** — third trigger added: at the end of every autonomous supervisor run, paired with the supervisor-batch commit and making the SessionStart hook's health summary reflect the latest cadence findings
  - **§ Git Workflow → Supervisor Report Files (new subsection)** — names the three dogfood-specific commitments (reports committed, same-day suffix files committed, optional state file gitignored); cross-references technical_design v1.2 for the full convention
  - **Scheduler choice for the Shannon-self project — DEFERRED** — technology_stack v1.3 commits to the abstract pattern (headless mode + external scheduler the project configures) and notes each project documents its scheduler choice in its own `development_guide.md`. The Shannon-self project's own scheduler choice is deferred to FEAT-009 elaboration, where the supervisor's first dogfood run will surface whether a specific scheduler should be named here
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing → *Status semantics*** — no existing approved claim contradicted; document stays APPROVED across the bump (no DRAFT transition). Sibling precedent: technology_stack v1.3 and technical_design v1.2 made the identical additive call on this cascade
- Status: APPROVED (2026-05-29)

### 2026-05-24 - v1.3

- Per EPIC-008 — Development Conventions Surfaced Through Dogfooding — additive amendments codifying three dev-discipline conventions surfaced during EPIC-005 / EPIC-006 dogfooding:
  - **§ Code Style → Patterns to Follow** — new bullet *Source-of-truth body before derived artefacts* (editing-order convention; cites TASK-003 as worked precedent; cross-references EPIC-007 AC#4's scope-guard rule in `conceptual_design.md` § Business Rules as companion edit-discipline / AC-writing rule)
  - **§ Git Workflow → Push Cadence** — new subsection sibling to Commit Cadence, naming two triggers (after every Gate 3 approval; at session end) with inline "session end" definition
  - **§ Testing Strategy → Pre-Commit Checklist** — new checklist item operationalising the meta-gap routing channel (framework-general ambiguity surfaced during work → `scratchpad.md` capture or follow-up work item)
- Reciprocal cross-reference added to existing § Git Workflow → Commit Cadence prose pointing at the new Push Cadence subsection
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing → *Status semantics*** — no existing approved claim contradicted; document stays APPROVED across the bump (no DRAFT transition)
- EPIC-007 (Work-Item Conventions Surfaced Through Dogfooding) is the contemporaneous sibling exercise of the routing channel established at the new Pre-Commit Checklist item — together, EPIC-007 and EPIC-008 are the first two formal exercises of that channel
- Status: APPROVED (2026-05-24)

### 2026-05-16 - v1.2

- Applied Gate 1 review findings:
  - **V1**: Reframed "single-developer project" in Branching and Pull Requests (lines 119, 138 of prior version) to "single maintainer at present; the framework supports multi-agent configurations" — aligns with V6 vocabulary in vision, conceptual_design, and technical_design
  - **V2**: "explicit user approval" → "explicit directing-party approval" in Testing Strategy § What to Test
  - **G1**: Added "Multi-Agent Coordination" subsection under Git Workflow elaborating the Cooperative Access convention named in technology_stack and technical_design (disjoint work items, no silent overwrites, cooperative ID allocation, by-convention enforcement)
  - **G2**: Added "Instrumentation" subsection under Testing Strategy naming the measurable-target work that lives in skills (documentation upkeep ratio, planning approval rate, setup time)
- Status: APPROVED (2026-05-16)

### 2026-05-15 - v1.1

- Added "Commit Cadence" subsection under Git Workflow: source control assumed by default; commit after Gate 1 (document approval) and Gate 3 (work-item review)
- Status: DRAFT

### 2026-05-15 - v1.0

- Initial development guide drafted
- Folded former code_style_guide.md content into Code Style section
- Status: DRAFT
