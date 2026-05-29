# UX Guide

**Status**: APPROVED
**Last Reviewed**: 2026-05-29
**Approved**: 2026-05-29

---

**Project Name**: Shannon

> Shannon has no graphical user interface. Its "interaction surface" is the set of slash commands invoked inside Claude Code and the prose those commands generate. This guide captures the principles that shape that surface — how commands feel to use, how Shannon talks to its directing party, what the implied UX of a CLI-only meta-framework should be.

---

## Design Principles

### 1. **Predictable Naming**

Every command follows `/[type]-[verb]`. A directing party who learns `/task-elaborate` can predict that `/feature-elaborate`, `/epic-elaborate`, and `/spike-elaborate` exist. Surprise is a defect.

### 2. **Explicit Gates, Implicit Bookkeeping**

Quality gate outcomes always announce themselves: "I have drafted the requirements. Please review and approve to mark this ELABORATED." Bookkeeping that does not cross a gate — index updates, cross-reference maintenance, file moves below the directing party's notice — happens silently. The directing party attends to decisions; Shannon attends to housekeeping.

### 3. **Conversation Resumes**

Shannon commands are interruptions, not destinations. When a command completes, the assistant returns to the conversation the directing party was having. The directing party does not have to say "OK now back to what we were doing."

### 4. **Plain Text is the Final Output**

Every artefact Shannon produces is human-readable Markdown. No tool is required to read it, audit it, or modify it. This is a UX commitment as much as a technical one — the directing party is never locked out of their own project.

---

## Command Surface

### Naming Convention

- **Verb groups by type**: `/feature-*`, `/epic-*`, `/task-*`, `/spike-*`
- **Documents have their own family**: `/document-create` (mandated docs and knowledge notes), `/document-review`
- **One-offs are prefixed `shannon-`**: `/shannon-setup`, `/shannon-report`, `/shannon-goal`

### Verb Vocabulary

The same five verbs apply to every work item type:

| Verb | What it does | Gate |
|---|---|---|
| `create` | Capture in DRAFT | — |
| `elaborate` | Complete requirements | **G1** — DRAFT → ELABORATED |
| `plan` | Define implementation approach | **G2** — ELABORATED → PLANNED |
| `implement` | Execute the plan; iterate freely between IMPLEMENTING, IMPLEMENTED, and REVIEW | — |
| `review` | Verify and approve | **G3** — REVIEW → APPROVED |

Consistency across types is the point. A directing party who has learned the task lifecycle knows the spike lifecycle. The three quality gates are named G1, G2, G3 throughout Shannon and in this guide.

### Argument Conventions

- Commands accept an optional ID or hint as the first argument
- When omitted, the command infers the target from recent conversation context or asks
- Commands never fail silently on ambiguous targets — they surface the ambiguity and ask

### Supervisor Commands

Two supervisor commands surface continuous-vigilance flows (see `technical_design.md` § API Design → *Supervisor Verbs*):

- **`/shannon-report`** — Run a cadence audit and write a dated report. Takes no arguments. Output is a one-line confirmation pointing at the new report file (full presentation pattern: see § Interaction Patterns → *Supervisor Report Presentation*):

  ```
  Supervisor report written: docs/supervisor/report-2026-05-29.md
    3 drift findings · 2 stuck items · push lag +5 commits.
  Open it? (or: triage inline / defer)
  ```

- **`/shannon-goal [intent]`** — Decompose a high-level directing-party intent into candidate work items, citing existing artefacts where alignment exists and surfacing gaps where it doesn't. `[intent]` is a free-text hint (e.g. *"make onboarding feel less abrupt"*). Output is a categorised list of candidate work items with their alignment story:

  ```
  Intent: "make onboarding feel less abrupt"

  Candidates aligned with existing artefacts (2):
    - Extend FEAT-001 § Ideal State to name first-session experience
    - New Task under EPIC-005 — Soften /shannon-setup conclusion message

  Candidates surfacing gaps (1):
    - No Feature elaborates "first-session experience" yet — directing-party
      approval needed before scratchpad promotion to Feature

  Promote which? (Tasks may be auto-promoted on supervisor authority;
  Epics and Features require your approval.)
  ```

Failure modes for both commands surface specifically: a missing supervisor configuration file is named (not "Error: config missing") and the user is pointed at `./.claude/shannon-supervisor.json` per `technical_design.md` § Data Model → *Supervisor Configuration*.

---

## Voice and Tone

### Voice

- **Second person** — Address the directing party directly ("You're about to elaborate FEAT-001 ...")
- **Present tense** — Describe what is happening now ("I'm drafting the plan now") rather than what will happen ("I will draft the plan")
- **Active voice** — "I read vision.md" rather than "vision.md was read"

### Tone

- **Concise** — One sentence is almost always enough. The directing party is reading inside an AI conversation, not a manual
- **Honest about uncertainty** — When a document is DRAFT and being used as context, say so (see *DRAFT Context Caveat* under Interaction Patterns)
- **Surface findings, not summaries of activity** — Report what changed and what the directing party needs to decide, not a play-by-play of every file read

### Prose Style

- **Sentences under 25 words where possible** — Long sentences hide important details
- **No exclamation marks** — They read as either childish or sarcastic in an AI context
- **No emoji** — Unless the directing party requests them, emoji clutter terminal output and disrupt screen readers

---

## Interaction Patterns

### Gate Approval

When Shannon reaches a quality gate (G1, G2, or G3), it presents the proposed transition and waits for explicit approval from the gate authority holder for that work-item type (the directing party or the supervisor, per `conceptual_design.md` § Business Rules → *Gate Authority Split*).

When the directing party holds gate authority (Vision and Features always; Epics and Spikes when reserved by the project), the gate is interactive:

```
I've drafted the requirements for FEAT-009:

  [summary of requirements]

Approve to mark this ELABORATED (G1), or describe changes you'd like.
```

The directing party's response is the gate. Silent transitions across gates are a defect.

When the supervisor holds gate authority (Tasks always; Epics and Spikes by default), the gate is exercised on the supervisor's cadence and surfaced to the directing party after the fact via *Supervisor-Approved Gate Notification* (below). In an interactive session, a supervisor that recognises a gate ripeness still presents the transition explicitly to the directing party for visibility:

```
TASK-042 elaboration ready for G1. Supervisor authority applies.

  [summary of requirements]

Approving on supervisor authority; override or annotate before I proceed.
```

Silence after the announcement counts as approval (supervisor authority is delegated, not requested); explicit override returns the gate to interactive directing-party approval.

For G3 task approvals specifically — whether the gate authority holder is the directing party or the supervisor — the announcement names archive movement:

```
TASK-042 marked APPROVED (G3). Moving to docs/tasks/archive/.
```

### Presenting Findings

When an alignment subagent, review, or analysis surfaces findings, Shannon presents them using the canonical four-category schema (see `technical_design.md § Document Alignment Check`):

```
Review of conceptual_design.md against vision.md (APPROVED):

  Drift (1)
    - Glossary "Quality Gate" still says "human approval point" — vision now allows directing party (human or supervising agent)

  Gaps (2)
    - No workflow for alignment drift detection (vision § Directional Targets commits to it)
    - Knowledge Note entity doesn't bind to "knowledge accumulates" vision commitment

  Internal contradiction (1)
    - Feature Activity attribute (STABLE/ACTIVE) contradicts Unified Status Lifecycle rule

  Strength (1)
    - "Iterative Implementation Zone" rule cleanly elaborates the lifecycle diagram

Apply / defer / discuss?
```

Findings are categorised, then the directing party decides which to apply inline, which to defer to scratchpad, and which to ignore.

### DRAFT Context Caveat

When the implementer uses a DRAFT document as authoritative context, it surfaces the uncertainty before proceeding:

```
Note: I'm using technical_design.md as context for this plan, but it's still DRAFT and not yet authoritative. Findings may need reconciliation when it's approved. Proceed?
```

The pattern is mandatory — the *DRAFT Documents Are Not Authoritative* business rule (conceptual_design.md) depends on it being visible.

### Cascading Operations

When the directing party invokes an operation on a parent work item that affects children (e.g. `/epic-plan`), Shannon does bulk preparation, stashes prepared drafts inside the child work items in DRAFT status, and reports the result:

```
EPIC-003 planned and marked PLANNED (G2). Drafted 4 child tasks in DRAFT with prepared elaborations and plans:

  TASK-042 — Add Google OAuth provider (elaboration + plan drafted)
  TASK-043 — Add GitHub OAuth provider (elaboration + plan drafted)
  TASK-044 — Wire OAuth UI components (elaboration drafted)
  TASK-045 — Add E2E tests (elaboration drafted)

When you run /task-elaborate or /task-plan on any of these, I'll surface the prepared draft for your review at G1 / G2.
```

Each child still passes through its own gates individually. No new statuses are introduced; the prepared content surfaces at the moment the child's standard gate command is invoked. See `technical_design.md § Cascading Operations` for the reasoning.

If a prepared draft is stale (parent or sibling work has moved since preparation), the implementer warns when surfacing and offers to refresh.

### Supervisor Report Presentation

When a supervisor cadence run completes, its findings surface to the directing party as a dated report at `./docs/supervisor/report-YYYY-MM-DD.md` (a Knowledge Note subtype — see `conceptual_design.md` § Domain Model → *Knowledge Note*). The implementer announces the report at the next opportunity — either at session start (per the supervisor's SessionStart hook integration described in `technical_design.md` § System Architecture → *Supervisor*) or inline when the directing party invokes a command:

```
Supervisor report 2026-05-29 ready:

  3 drift findings, 2 stuck items, push lag +5 commits.

  Top item: conceptual_design.md drifted from technology_stack.md on the role taxonomy
  (Gate Authority Split language not yet propagated to § Glossary).

  Open report / triage findings / defer?
```

The presentation is **hybrid** by default: a diagnostic header (counts) followed by a one- or two-finding narrative body. Diagnostic-only or conversational-only presentations are valid project-level customisations but are not the framework default. Directing party chooses whether to open the full report, triage findings inline, or defer to the next session.

Supervisor reports are not gated artefacts — they are working knowledge, like any other Knowledge Note. The directing party's actions on report findings flow through the normal channels (`/document-review`, `/[type]-elaborate`, scratchpad capture).

### Supervisor-Approved Gate Notification

When the supervisor exercises delegated gate authority (Task gates always; Epic and Spike gates by default per `conceptual_design.md` § Business Rules → *Gate Authority Split*), the directing party learns about the decision after the fact rather than being asked to approve in the moment. The supervisor records the decision in the work item's Activity Log and surfaces a one-line notification at the next session start or relevant command:

```
Since your last session, the supervisor approved:

  TASK-042  Gate 1 (ELABORATED)  — Add Google OAuth provider
  TASK-043  Gate 2 (PLANNED)     — Add GitHub OAuth provider
  TASK-041  Gate 3 (APPROVED)    — Wire OAuth UI components → archived

Review any decision? (Override is permitted — supervisor decisions are not infallible.)
```

The directing party can override any supervisor-approved gate by invoking the relevant command on the work item; this returns the item to the prior status and re-runs the gate under directing-party authority. Override is rare by design — the supervisor's delegated authority exists precisely to spare the directing party from routine decisions — but the override channel is always open.

Vision and Feature gates never appear in this notification stream because they are never supervisor-approved (the fixed floor per *Gate Authority Split*).

### Knowledge Note Creation

When the implementer encounters something worth persisting as knowledge (research finding, implementation gotcha, decision rationale, doc extension), it prompts:

```
This investigation produced findings worth a knowledge note:
  - Comparison of OAuth approaches, with recommendation for PKCE

Capture as: Research / Implementation Details / Extension?
```

The directing party picks the type (or declines). On accept, the implementer creates the note from the template into `./docs/knowledge/`, adds an entry to `knowledge_index.md`, and cross-references from the originating work item.

Spike outputs always produce a knowledge note as the durable artefact; for other work items, knowledge capture is optional but suggested when the implementer notices a candidate.

### Cooperative Access Collision

When Shannon detects that another agent has touched a file the implementer is about to write, the implementer surfaces the diff rather than overwriting silently:

```
Another agent has modified docs/conceptual_design.md since I last read it.
Concurrent change (likely from another agent in this session — supervisor audit, directing-party edits, or a parallel implementer):

  + Added "Directing Party" glossary entry
  + Updated Three Hard Gates business rule

How do you want to proceed?
  (1) Reload and re-do my work on top of these changes
  (2) Show me the merge surface and let me choose
  (3) Discard the other agent's changes (rare — describe why)
```

This is the user-visible side of the *Cooperative Access* commitment from `technology_stack.md § Security Considerations` and `technical_design.md § Cooperative Access`. The framework has no file locking; coordination happens here.

### Commit Cadence Reminder

When the directing party reaches a gate moment (G1, G2, G3) and there are uncommitted changes from a prior gate, the implementer reminds before proceeding:

```
Before approving this Gate 1 transition: you have uncommitted changes from the prior approval of vision.md (Gate 1, 2026-05-15). Per development_guide.md § Commit Cadence, the default is "commit after every approved gate."

Commit those changes now, or proceed and commit both together?
```

The default convention (per `development_guide.md § Commit Cadence`) is one commit per approved gate. The reminder makes the convention visible; it does not enforce.

### Error Surfacing

When something Shannon needs is missing, the error is specific and actionable:

```
Cannot elaborate FEAT-001 — vision.md does not exist.
Run /document-create vision to create it.
```

Never: "Error: missing document."

### Resumption

After a command completes its work, Shannon explicitly returns to the conversation:

```
FEAT-001 marked ELABORATED (G1). Returning to our discussion of authentication scope.
```

Index updates and cross-reference maintenance happen silently as part of the gate transition; only the gate outcome itself is announced.

---

## Accessibility

- **Plain text first** — Every output is screen-reader friendly by default
- **No colour-only signals** — Status indicators use words (DRAFT, APPROVED), not colour swatches
- **No reliance on terminal width** — Output should remain readable in narrow terminals; avoid wide tables where lists work

---

## Version History

### 2026-05-29 - v1.2

- Cascade from Vision v2.4 (APPROVED 2026-05-28, commit `d2fd797`), conceptual_design v1.7 (APPROVED 2026-05-29, commit `a8fe1e0`), technology_stack v1.3 (APPROVED 2026-05-29, commit `c7d66e4`), and technical_design v1.2 (APPROVED 2026-05-29, commit `71b7ac5`) introducing the supervisor as a third role, codifying the gate-authority split, and committing to `/shannon-report` and `/shannon-goal` at the API surface. Pass 1 alignment surfaced findings UX-1 through UX-4 plus the optional `/shannon-report` and `/shannon-goal` command-UX extension; this version addresses all five.
  - **§ Interaction Patterns → *Cooperative Access Collision*** (UX-1) — example output refreshed to retire "supervising agent" wording per Vision v2.4's naming-collision retirement; the parenthetical hint now names the three plausible actors (supervisor audit, directing-party edits, parallel implementer) without committing to which
  - **§ Interaction Patterns → *Supervisor Report Presentation* (new pattern)** (UX-2) — codifies how dated supervisor reports surface to the directing party; hybrid presentation (diagnostic header + 1–2 finding narrative body) is the framework default; references `technical_design.md` § System Architecture → *Supervisor* for the SessionStart hook integration that drives session-start announcement
  - **§ Interaction Patterns → *Supervisor-Approved Gate Notification* (new pattern)** (UX-3) — codifies how the directing party discovers supervisor-exercised gate decisions after the fact, with one-line notifications at session start and the override channel always open
  - **§ Interaction Patterns → *Gate Approval*** (UX-4) — opening prose generalised from "directing party" to "the gate authority holder for that work-item type" per *Gate Authority Split*; v1.1's directing-party example preserved verbatim; new parallel supervisor-approved example added alongside; G3 archive movement note clarified to apply regardless of which role holds gate authority
  - **§ Command Surface → *Naming Convention*** — `/shannon-report` and `/shannon-goal` added to the "one-offs prefixed `shannon-`" inventory
  - **§ Command Surface → *Supervisor Commands* (new subsection)** — argument hints, output shape, and failure modes for `/shannon-report` and `/shannon-goal`; cross-references *Supervisor Report Presentation* for the full presentation pattern and `technical_design.md` § Data Model → *Supervisor Configuration* for the configuration failure mode
- Classified as **additive amendment per `conceptual_design.md` § Re-reviewing → *Status semantics*** — no v1.1 approved claim is contradicted. The *Gate Approval* generalisation widens "directing party's response is the gate" to "the gate authority holder's response is the gate", which is a vocabulary refresh tracking conceptual_design v1.7's role taxonomy, not a substantive narrowing. Document stays APPROVED across the bump (no DRAFT transition). Sibling precedent: technical_design v1.2 made the identical additive call with a parallel *Gate Enforcement* refresh
- Two deferrals carried forward from v1.1's scratchpad ("Gate Enforcement visibility" and "Voice differing for human vs agent directing party") are now addressed by UX-3 and UX-4 respectively — the v1.1 entries were correct to defer until the role taxonomy stabilised at Vision v2.4
- Status: APPROVED (2026-05-29)

### 2026-05-17 - v1.1

- Applied Gate 1 review findings (standard alignment + design-pass synthesis):
  - **V6 vocabulary sweep** — "user" → "directing party" / "implementer" throughout (~11 occurrences); principles, voice/tone, command surface, and interaction patterns all updated
  - **Cascading Operations rewrite (D1)** — Removed `PLAN-PENDING` framing; rewrote to option (b) pattern from `technical_design.md`: bulk preparation produces prepared drafts inside DRAFT children, surfaced at each child's standard gate command. Includes stale-draft warning
  - **Verb table update (D2)** — Now names the three gates (G1/G2/G3) and reflects the IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW iterative zone explicitly
  - **Internal contradiction reconciled (IC1)** — "Explicit gates, implicit bookkeeping" clarified: gate outcomes announced; index/cross-reference work silent
  - **Gates named (A1)** — G1, G2, G3 introduced and used consistently
  - **Command Surface additions (A2)** — `/shannon-setup` and `/document-create` for knowledge notes now explicitly mentioned
  - **Archive UX (A3)** — G3 task approval announcement names the archive move
  - **New pattern: Presenting Findings (N1)** — Canonised the four-category schema (Drift / Gap / Internal contradiction / Strength) from `technical_design.md § Document Alignment Check`
  - **New pattern: DRAFT Context Caveat (N3)** — Promoted from inline example to a named pattern with mandatory wording, supporting the *DRAFT Documents Are Not Authoritative* rule
  - **New pattern: Knowledge Note Creation (N2)** — Surfaces the workflow added in `conceptual_design.md § Capturing Knowledge as the Project Runs`; covers prompt-to-capture and classification (Research / Implementation Details / Extension)
  - **New pattern: Cooperative Access Collision (N4)** — UX side of the cooperative-access commitment; surfaces concurrent agent edits as diffs with resolution options
  - **New pattern: Commit Cadence Reminder (N5)** — Implements the development_guide convention as a gate-moment reminder
- Deferred (captured in scratchpad):
  - Gate Enforcement visibility (surfacing supervisor ≠ implementer at gate moments) — too speculative until multi-agent configurations are exercised
  - Documentation upkeep ratio surfacing (aggregate metric) — requires instrumentation not yet built
  - Voice differing for human vs agent directing party — premature speculation
- Status: APPROVED (2026-05-17)

### 2026-05-15 - v1.0

- Initial UX guide drafted; reframed as "interaction design" for a CLI-only framework
- Status: DRAFT
