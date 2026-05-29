# Development Guide

**Status**: APPROVED
**Last Reviewed**: 2026-05-29
**Approved**: 2026-05-29

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

### Patterns to Avoid

- **Verbose example blocks inside templates** — Templates should be the shape; examples bloat them and tempt readers to copy the example verbatim
- **Implicit cross-references** — Always include explicit paths or section anchors when one document references another
- **Status fields in places without a real status** — Only DRAFT/APPROVED on mandated documents; only the unified lifecycle on work items

---

## Testing Strategy

Shannon has no unit tests because Shannon has no units. The framework's correctness is the correctness of templates and prompts in the eyes of Claude Code and a real user.

### Test Levels

- **Template review** — Read each template after changes to check the shape is coherent and the placeholders are sensible
- **Deployed exercise** — Deploy the changed templates into a fresh project. Run the full lifecycle on a real work item. Confirm the AI follows the intended flow at each gate
- **Dogfood pass** — Run new commands and skills against this repository's own `docs/`. If something feels awkward when applied to Shannon itself, it will feel awkward elsewhere

### What to Test

- Every command's skill invocation actually triggers the intended skill
- Every quality gate prompts for explicit directing-party approval
- Every template renders to a coherent document when instantiated
- Every index update happens at the right transition

### Pre-Commit Checklist

Before committing template, command, or skill changes:

- [ ] Templates open and render in a Markdown viewer without errors
- [ ] No stale references to removed concepts (e.g. "phases", "code_style_guide.md")
- [ ] Cross-references are correct paths
- [ ] At least a mental dry-run of the affected workflow
- [ ] Did this work resolve a **framework-general ambiguity surfaced during this work — a convention, workflow gap, or rule clarification that future work items would otherwise re-derive**? If yes, capture it in `scratchpad.md` for promotion or open a follow-up work item against the relevant mandated document. (See also the matching soft prompts in `shannon/skills/work-items/skill.md` § Process: Plan and § Process: Review.)

### Instrumentation

Distinct from the absent test suite, instrumentation is the work of capturing data needed to evaluate the vision's *Measurable Targets*. Currently:

- **Documentation upkeep ratio** (<10% of session time on `/document-*` commands) — Requires session-time tracking inside the `project-documentation` skill. Not yet implemented; flagged in vision § Measurable Targets as a future commitment
- **Planning approval rate** (80%+ at Gate 2 without revision) — Measurable from Activity Log entries on work items; no separate instrumentation needed
- **Setup time** (<5 min from `/shannon-setup` to first PLANNED task) — Measurable by timestamps; no separate instrumentation needed

Instrumentation lives in the skill that owns the relevant workflow. As measurable targets are added or refined, the corresponding instrumentation is part of the work that introduces them.

---

## Git Workflow

### Branching

- **master** — Single long-lived branch. Shannon has a single maintainer at present; no team-branching model required. The framework itself supports multi-agent configurations under the three-role taxonomy (directing party, supervisor, implementer — see `conceptual_design.md` § Glossary), but the codebase-of-Shannon-itself does not yet operate that way
- **Topic branches** — Optional for substantial refactors (e.g. `refactor/shannon-v2`). Squash-merge to master

### Commits

- **Conventional, but not strict** — Capitalised imperative subject ("Add X", "Refactor Y", "Fix Z"). Body explains "why" when not obvious
- **No commit hooks** — Shannon has no test suite; hooks would have nothing to enforce

### Commit Cadence

Shannon's default: **commit after every approved gate**. Source control is assumed.

- **After document approval (Gate 1)** — Commit the document's DRAFT → APPROVED transition, along with any edits made during review
- **After work-item review (Gate 3)** — Commit the approved state, including archive moves (for tasks), parent feature/epic updates, and any documents updated during the work

This produces a commit history that mirrors the framework's lifecycle: each commit corresponds to a decision the directing party explicitly approved. Pre-gate experimentation is fine — multiple in-progress commits per gate are expected — but the gate itself is the unit of "this is now part of the project." See *Push Cadence* below for the paired sync directive.

#### Supervisor cadence runs

Autonomous supervisor runs (per `technical_design.md` § Cadence) are read-mostly: each run produces a dated report at `docs/supervisor/report-YYYY-MM-DD.md` and, in the configurable-ceiling case, may exercise delegated gate approvals on Tasks (and, by default, Epics and Spikes — see `conceptual_design.md` § Business Rules → *Gate Authority Split*). Commit cadence inside an autonomous run:

- **One commit per run, not per gate** — A cadence run that approves multiple Task gates batches all of its writes (the dated report plus any per-Task transitions it ratified) into a single commit at the end of the run, rather than committing after each individual gate. This preserves the "one commit per decision" intent at the granularity that makes sense for a batched autonomous pass: the decision is the run, not each gate inside it
- **Commit message names the run** — Subject `Supervisor report YYYY-MM-DD` (capitalised imperative-equivalent; the report's filename is the natural anchor); body enumerates any gate transitions the run ratified, by work item ID
- **Interactive supervisor invocations follow the default** — A `/shannon-report` run inside an interactive directing-party session falls back to the standard per-gate commit cadence above. The batched form is specifically for the headless autonomous case

The same agent-identity constraint applies in either case: a supervisor commit must not ratify work the same agent implemented (per `conceptual_design.md` § Business Rules → *Supervisor Distinct From Implementer*).

### Push Cadence

Shannon's default: **push local commits to the remote** at three named triggers, so commits do not sit unsynced.

- **After every Gate 3 approval** — paired with the Commit Cadence Gate-3 trigger above, so commit-then-push reads as a single motion
- **At session end** — before the implementer or directing party stops a working session for the day or hands off to another agent — i.e. before any pause long enough that local commits would otherwise sit unsynced through the gap
- **At the end of every autonomous supervisor run** — paired with the supervisor-batch commit described above. A headless cadence run that lands a report (and possibly delegated gate ratifications) pushes before exiting, so the supervisor's findings reach the remote before the directing party next opens a session. This is what makes the SessionStart hook's health summary (per `technical_design.md` § System Architecture → *Supervisor* → *Hook integration*) reflect the latest cadence findings rather than stale local state

Pre-Gate-3 pushes are permitted but not required. See *Commit Cadence* above — the cadences are paired.

### Pull Requests

- **Optional** — Direct commits to master are acceptable while Shannon has a single maintainer
- **Use PRs for**: substantial refactors, anything you want to think through in writing, anything that benefits from `/ultrareview`

### Multi-Agent Coordination

Shannon's framework explicitly supports multi-agent configurations under the three-role taxonomy (directing party, supervisor, implementer — see `conceptual_design.md` § Glossary and `vision.md` § Target Users → *Three roles, configurably separable*). The agents coexist on shared files *by convention*, not by technical control (see `technical_design.md` § Cooperative Access). Two configurations are typical:

- **Directing party + implementer** — solo configuration in which the directing party also occupies the supervisor role (permitted per Vision § Target Users); the agent-identity gate-integrity constraint still applies — the human cannot approve gates on work the implementer agent produced
- **Directing party + supervisor + implementer** — fuller configuration in which a distinct supervisor agent performs continuous health vigilance and absorbs Task (and, by default, Epic and Spike) gate authority per `conceptual_design.md` § Business Rules → *Gate Authority Split*

The development practice that makes shared-file operation safe applies to both configurations:

- **Disjoint work items** — Agents operating concurrently should be assigned to different work items; the file-based model has no locking, and overlapping writes will surface as ordinary diffs to be resolved by the directing party
- **No silent overwrites** — When an implementer touches a file another agent recently modified, surface the diff and ask before overwriting
- **Cooperative ID allocation** — Simultaneous `*-create` operations may produce colliding IDs; resolve by reading the index at the moment of allocation and accepting the merge conflict if one arises (see `technical_design.md` § ID Allocation)

Future versions may add architectural enforcement of the *Supervisor Distinct From Implementer* rule (`conceptual_design.md` § Business Rules); the current version trusts agents and the directing party to follow the convention.

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
