# Development Guide

**Status**: DRAFT
**Last Reviewed**: 2026-11-12
**Approved**: 2026-05-29 (through v1.5; v1.6 awaiting Gate 1)

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

Every change reaches `master` through a reviewed pull request. A reviewer outside the session that wrote the change catches what its author cannot see, and with several agents working in the repository (see *Multi-Agent Coordination* below) the pull request is the one place each change is checked before it lands.

### Branching

- **master** — The single long-lived branch, and the default branch. It changes only by merging a pull request. Nobody, human or agent, commits or pushes to it directly
- **Topic branches** — All work happens on a topic branch cut from the latest `master`, one branch per pull request. Name it for the work (`docs/dev-guide-landing`, `task-033-testing-strategy`); an agent may prefix its own name (`claude/…`, `codex/…`). Delete the branch once its pull request has merged

### Repository Rules

The rules below are enforced on GitHub by a ruleset on `master`, so they hold whoever pushes:

- A pull request is required, with **one approving review of the latest push**; approvals go stale and are dismissed when new commits are pushed
- **Force-push and deletion** of `master` are blocked
- The only bypass is the repository admin, on pull requests only. No bot or agent is on the bypass list
- Changing the ruleset is the maintainer's decision. A building agent never changes it

### Commits

- **Conventional, but not strict** — Capitalised imperative subject ("Add X", "Refactor Y", "Fix Z"). Body explains "why" when not obvious
- **Run or test before committing** — A change is checked before it is committed: the *Pre-Commit Checklist* in § Testing Strategy, plus any check the change itself names
- **Say who wrote it** — Each commit carries the identity of the agent that wrote it. An agent without a GitHub identity of its own commits with an author name that says which agent it is. No agent commits or pushes under a reviewer's identity
- **No commit hooks** — Shannon has no test suite; hooks would have nothing to enforce

### Commit Cadence

Shannon's default: **commit after every approved gate**, on the gate's topic branch. Source control is assumed.

- **After document approval (Gate 1)** — Commit the document's DRAFT → APPROVED transition, along with any edits made during review
- **After work-item review (Gate 3)** — Commit the approved state, including archive moves (for tasks), parent feature/epic updates, and any documents updated during the work

Each gate's work rides its own pull request, and the squash merge of that pull request is the commit on `master`. So `master`'s history mirrors the framework's lifecycle: each commit there corresponds to a decision the gate's approval authority explicitly approved. Pre-gate experimentation is fine — multiple in-progress commits per gate on the branch are expected — but the gate itself is the unit of "this is now part of the project." See *Push Cadence* below for the paired sync directive.

#### Supervisor cadence runs

Autonomous supervisor runs (per `technical_design.md` § Cadence) are read-mostly: each run produces a dated report at `docs/supervisor/report-YYYY-MM-DD.md` and, in the configurable-ceiling case, may exercise delegated gate approvals on Tasks (and, by default, Epics and Spikes — see `conceptual_design.md` § Business Rules → *Gate Authority Split*). Commit cadence inside an autonomous run:

- **One commit per run, not per gate** — A cadence run that approves multiple Task gates batches all of its writes (the dated report plus any per-Task transitions it ratified) into a single commit at the end of the run, rather than committing after each individual gate. This preserves the "one commit per decision" intent at the granularity that makes sense for a batched autonomous pass: the decision is the run, not each gate inside it
- **The run lands by pull request** — The run commits on its own topic branch, pushes the branch and opens a pull request. It never pushes to `master`, force-pushes, or rewrites history. The pull request merges like any other, after an approved reviewer has approved it. The headless permission contract in `technical_design.md` § Cadence allows only read-only git, so it does not yet allow the run to commit, push or open a pull request; until it does, the run leaves its writes in the working tree and the next interactive session commits them on a topic branch, pushes the branch and opens the pull request
- **Commit message names the run** — Subject `Supervisor report YYYY-MM-DD` (capitalised imperative-equivalent; the report's filename is the natural anchor); body enumerates any gate transitions the run ratified, by work item ID
- **Interactive supervisor invocations follow the default** — A `/shannon-report` run inside an interactive directing-party session falls back to the standard per-gate commit cadence above. The batched form is specifically for the headless autonomous case

The same agent-identity constraint applies in either case: a supervisor commit must not ratify work the same agent implemented (per `conceptual_design.md` § Business Rules → *Supervisor Distinct From Implementer*).

### Push Cadence

Shannon's default: **push the topic branch to the remote** at three named triggers, so commits do not sit unsynced. A push is always of a topic branch; `master` moves only by merge.

- **After every Gate 3 approval** — paired with the Commit Cadence Gate-3 trigger above, so commit-then-push reads as a single motion, and followed by opening (or updating) the gate's pull request
- **At session end** — before the implementer or directing party stops a working session for the day or hands off to another agent — i.e. before any pause long enough that local commits would otherwise sit unsynced through the gap
- **At the end of every autonomous supervisor run** — paired with the supervisor-batch commit described above. A headless cadence run that lands a report (and possibly delegated gate ratifications) pushes its branch and opens its pull request before exiting (once the headless contract allows it; see *Supervisor cadence runs* above), so the supervisor's findings reach the remote before the directing party next opens a session. Once that pull request merges, the SessionStart hook's health summary (per `technical_design.md` § System Architecture → *Supervisor* → *Hook integration*) reflects the latest cadence findings rather than stale local state

Pre-Gate-3 pushes are permitted but not required. See *Commit Cadence* above — the cadences are paired.

### Pull Requests

- **Required for every change** — There are no direct commits to `master`. A pull request is PR-sized: one gate, one work item's step, or one coherent fix
- **The description is the evidence** — Name the work item (or say it is maintenance), say what changed and why, list the checks run and their results, and say plainly what was not verified
- **Independent review** — A pull request merges only after an **approved reviewer** that neither wrote nor pushed to it has approved its **current head commit**. Approved reviewers are GitHub Apps the maintainer has approved for this role. A fix for review findings goes on the same branch and needs a fresh approval
- **Gate pull requests also need the gate's approval authority** — A pull request that approves a gate merges only on the decision of that gate's approval authority (per `conceptual_design.md` § Business Rules → *Gate Authority Split*), in addition to the review: the directing party for the Vision and Feature gates, the supervisor for Task gates and, unless reserved, Epic and Spike gates. A pull request that approves a mandated document (a DRAFT → APPROVED transition, or any change that moves a document's version) needs the directing party's decision. Ordinary pull requests (maintenance, bookkeeping, corrections) need the review alone
- **Merging** — Squash merge, pinned to the approved head commit. Squash-only is a convention: the ruleset does not restrict merge methods. Never merge with an admin bypass, and never merge a pull request whose head changed after its approval. A pull request that goes public in a new way, or touches security, waits for the maintainer's direction
- **Keep it public-safe** — The repository is public, so a push or a pull request is publication. Nothing carries secrets or private facts, and the repository's files name no reviewers and list no other repositories

### Multi-Agent Coordination

Shannon's framework explicitly supports multi-agent configurations under the three-role taxonomy (directing party, supervisor, implementer — see `conceptual_design.md` § Glossary and `vision.md` § Target Users → *Three roles, configurably separable*). The agents coexist on shared files *by convention*, not by technical control (see `technical_design.md` § Cooperative Access). Two configurations are typical:

- **Directing party + implementer** — solo configuration in which the directing party also occupies the supervisor role (permitted per Vision § Target Users); the agent-identity gate-integrity constraint still applies — the human cannot approve gates on work the implementer agent produced
- **Directing party + supervisor + implementer** — fuller configuration in which a distinct supervisor agent performs continuous health vigilance and absorbs Task (and, by default, Epic and Spike) gate authority per `conceptual_design.md` § Business Rules → *Gate Authority Split*

The development practice that makes shared-file operation safe applies to both configurations:

- **Disjoint work items** — Agents operating concurrently should be assigned to different work items; the file-based model has no locking, and overlapping writes will surface as ordinary diffs to be resolved by the directing party
- **No silent overwrites** — When an implementer touches a file another agent recently modified, surface the diff and ask before overwriting
- **Cooperative ID allocation** — Simultaneous `*-create` operations may produce colliding IDs; resolve by reading the index at the moment of allocation and accepting the merge conflict if one arises (see `technical_design.md` § ID Allocation)
- **One branch per agent's work** — Each agent works on its own topic branch and pull request. When two open pull requests touch the same file, whichever merges second rebases onto the new `master` and carries its edits across; the review of the rebased head is a fresh one

Future versions may add architectural enforcement of the *Supervisor Distinct From Implementer* rule (`conceptual_design.md` § Business Rules); the current version trusts agents and the directing party to follow the convention.

### Supervisor Report Files

Supervisor reports are Knowledge Note subtypes (per `conceptual_design.md` § Domain Model → *Knowledge Note*) living at `./docs/supervisor/report-YYYY-MM-DD.md`. The full storage and naming convention — including same-day suffix handling — is codified in `technical_design.md` § Data Model → *Supervisor Report Files*. The development guide's dogfood-specific commitments:

- **Reports are committed, not gitignored** — Supervisor reports are durable project knowledge; they ride the supervisor-batch commit cadence above and live in version control alongside the rest of `docs/`
- **Same-day suffix files are also committed** — A `report-YYYY-MM-DD-2.md` from a second run on the same date is committed as-is; the cadence does not retroactively edit the prior report
- **Optional state file is gitignored** — `./.claude/supervisor/state.json` (per `technical_design.md` § Data Model → *Cadence State*) is a local-only UX aid; it does not belong in the remote

---

## CI/CD

### Pipeline Stages

No automated pipeline. Shannon has no compiled artefacts, no automated tests, and no deployment target. The "pipeline" is: edit Markdown on a topic branch, run the *Pre-Commit Checklist*, open a pull request, independent review, merge; then deploy into a project and exercise.

If automated checks are added later, they follow two rules. Each job only calls a repository script that runs the same way locally and on CI, and the job needs no secrets. A check becomes a required check on `master` only after it has passed on a real pull request, and a new check counts only once a deliberately planted failure has been seen to make it fail.

### Distribution

- **Primary** — `git clone` from GitHub, then copy the `shannon/` tree into the target project's `.claude/`
- **Roadmap** — Curl install script, GitHub template repository, language-specific package managers (npm, pip)

---

## Version History

### 2026-11-12 - v1.6

- The directing party directed that this guide follow the reviewed pull-request standard the maintainer now applies to every development repository. § Git Workflow and § CI/CD are rewritten to it:
  - **§ Git Workflow (opening)** — every change reaches `master` through a reviewed pull request, and why
  - **§ Git Workflow → Branching** — `master` changes only by merge; all work on topic branches, one per pull request
  - **§ Git Workflow → Repository Rules (new subsection)** — the ruleset already enforced on `master`: one approval of the latest push, stale approvals dismissed, force-push and deletion blocked, admin-only bypass on pull requests, ruleset changes are the maintainer's
  - **§ Git Workflow → Commits** — run or test before committing; each commit says which agent wrote it; no agent pushes under a reviewer's identity
  - **§ Git Workflow → Commit Cadence** — gate commits land on the gate's topic branch, and the squash merge is the commit on `master`; autonomous supervisor runs land by pull request and never push to `master`, force-push or rewrite history
  - **§ Git Workflow → Push Cadence** — pushes are of topic branches; each trigger is followed by opening or updating the pull request
  - **§ Git Workflow → Pull Requests** — replaces "Optional" with: required for every change; the description as evidence (work item, checks run, what was not verified); independent approval of the current head by an approved reviewer that neither wrote nor pushed to it; gate pull requests also need the gate's approval authority (per *Gate Authority Split*) and mandated-document pull requests the directing party's decision; squash merge pinned to the approved head, never an admin bypass; public-safe content
  - **§ Git Workflow → Multi-Agent Coordination** — one branch per agent's work; the second of two overlapping pull requests rebases and is reviewed afresh
  - **§ CI/CD → Pipeline Stages** — the manual pipeline now runs through a pull request; rules for any automated checks added later (portable scripts, no secrets, required only after passing on a real pull request, proven by a planted failure)
- Classified as a **substantive revision per `conceptual_design.md` § Re-reviewing → *Status semantics*** — it retracts the approved claims that pull requests are optional and that direct commits to `master` are acceptable. Made at the directing party's direction. The document is DRAFT for the revision and returns to APPROVED through Gate 1, given by the directing party
- Header keeps the original approval date (2026-05-29); v1.5 was an additive amendment that stayed APPROVED, so 2026-08-28 is its version date, not an approval
- Known follow-up, outside this revision: EPIC-011 AC#4 ("remote reflects the supervisor-batch commit") assumes a run that pushes its own commit, the drift checker measures push lag without reference to the run's branch, and `technical_design.md` § Cadence does not yet let a headless run commit, push a branch or open a pull request (captured in the scratchpad)
- Status: DRAFT (Gate 1 pending)

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
