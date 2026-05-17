# UX Guide

**Status**: APPROVED
**Last Reviewed**: 2026-05-17
**Approved**: 2026-05-17

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
- **One-offs are prefixed `shannon-`**: `/shannon-setup`

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

When Shannon reaches a quality gate (G1, G2, or G3), it presents the proposed transition and waits for explicit approval from the directing party:

```
I've drafted the requirements for TASK-042:

  [summary of requirements]

Approve to mark this ELABORATED (G1), or describe changes you'd like.
```

The directing party's response is the gate. Silent transitions across gates are a defect.

For G3 task approvals specifically, the announcement also names archive movement:

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
Concurrent change (likely the supervising agent's review edits):

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
