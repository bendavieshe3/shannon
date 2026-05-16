# Development Guide

**Status**: APPROVED
**Last Reviewed**: 2026-05-16
**Approved**: 2026-05-16

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

### Instrumentation

Distinct from the absent test suite, instrumentation is the work of capturing data needed to evaluate the vision's *Measurable Targets*. Currently:

- **Documentation upkeep ratio** (<10% of session time on `/document-*` commands) — Requires session-time tracking inside the `project-documentation` skill. Not yet implemented; flagged in vision § Measurable Targets as a future commitment
- **Planning approval rate** (80%+ at Gate 2 without revision) — Measurable from Activity Log entries on work items; no separate instrumentation needed
- **Setup time** (<5 min from `/shannon-setup` to first PLANNED task) — Measurable by timestamps; no separate instrumentation needed

Instrumentation lives in the skill that owns the relevant workflow. As measurable targets are added or refined, the corresponding instrumentation is part of the work that introduces them.

---

## Git Workflow

### Branching

- **master** — Single long-lived branch. Shannon has a single maintainer at present; no team-branching model required. The framework itself supports multi-agent configurations (supervisor + implementer under V6), but the codebase-of-Shannon-itself does not yet operate that way
- **Topic branches** — Optional for substantial refactors (e.g. `refactor/shannon-v2`). Squash-merge to master

### Commits

- **Conventional, but not strict** — Capitalised imperative subject ("Add X", "Refactor Y", "Fix Z"). Body explains "why" when not obvious
- **No commit hooks** — Shannon has no test suite; hooks would have nothing to enforce

### Commit Cadence

Shannon's default: **commit after every approved gate**. Source control is assumed.

- **After document approval (Gate 1)** — Commit the document's DRAFT → APPROVED transition, along with any edits made during review
- **After work-item review (Gate 3)** — Commit the approved state, including archive moves (for tasks), parent feature/epic updates, and any documents updated during the work

This produces a commit history that mirrors the framework's lifecycle: each commit corresponds to a decision the directing party explicitly approved. Pre-gate experimentation is fine — multiple in-progress commits per gate are expected — but the gate itself is the unit of "this is now part of the project."

### Pull Requests

- **Optional** — Direct commits to master are acceptable while Shannon has a single maintainer
- **Use PRs for**: substantial refactors, anything you want to think through in writing, anything that benefits from `/ultrareview`

### Multi-Agent Coordination

Shannon's framework explicitly supports multi-agent configurations (supervisor + implementer under V6) but enforces the separation *by convention*, not by technical control (see `technical_design.md § Cooperative Access`). The development practice that makes this safe:

- **Disjoint work items** — Agents operating concurrently should be assigned to different work items; the file-based model has no locking, and overlapping writes will surface as ordinary diffs to be resolved by the directing party
- **No silent overwrites** — When an implementer touches a file another agent recently modified, surface the diff and ask before overwriting
- **Cooperative ID allocation** — Simultaneous `*-create` operations may produce colliding IDs; resolve by reading the index at the moment of allocation and accepting the merge conflict if one arises (see `technical_design.md § ID Allocation`)

Future versions may add architectural enforcement of the supervisor ≠ implementer rule; the current version trusts agents and the directing party to follow the convention.

---

## CI/CD

### Pipeline Stages

None. Shannon has no compiled artefacts, no automated tests, and no deployment target. The "pipeline" is: edit Markdown, deploy into a project, exercise.

### Distribution

- **Primary** — `git clone` from GitHub, then copy the `shannon/` tree into the target project's `.claude/`
- **Roadmap** — Curl install script, GitHub template repository, language-specific package managers (npm, pip)

---

## Version History

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
