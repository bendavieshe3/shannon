# UX Guide

**Status**: DRAFT
**Last Reviewed**: 2026-05-15

---

**Project Name**: Shannon

> Shannon has no graphical user interface. Its "interaction surface" is the set of slash commands invoked inside Claude Code and the prose those commands generate. This guide captures the principles that shape that surface — how commands feel to use, how Shannon talks to its user, what the implied UX of a CLI-only meta-framework should be.

---

## Design Principles

### 1. **Predictable Naming**

Every command follows `/[type]-[verb]`. A user who learns `/task-elaborate` can predict that `/feature-elaborate`, `/epic-elaborate`, and `/spike-elaborate` exist. Surprise is a defect.

### 2. **Explicit Gates, Implicit Bookkeeping**

Quality gates always announce themselves: "I have drafted the requirements. Please review and approve to mark this ELABORATED." Bookkeeping (index updates, status transitions, cross-reference maintenance) happens silently in the background. The user attends to decisions; Shannon attends to housekeeping.

### 3. **Conversation Resumes**

Shannon commands are interruptions, not destinations. When a command completes, the assistant returns to the conversation the user was having. The user does not have to say "OK now back to what we were doing."

### 4. **Plain Text is the Final Output**

Every artefact Shannon produces is human-readable Markdown. No tool is required to read it, audit it, or modify it. This is a UX commitment as much as a technical one — the user is never locked out of their own project.

---

## Command Surface

### Naming Convention

- **Verb groups by type**: `/feature-*`, `/epic-*`, `/task-*`, `/spike-*`
- **Documents have their own family**: `/document-create`, `/document-review`
- **One-offs are prefixed `shannon-`**: `/shannon-setup`

### Verb Vocabulary

The same five verbs apply to every work item type:

| Verb | What it does |
|---|---|
| `create` | Capture in DRAFT |
| `elaborate` | Complete requirements (Gate 1) |
| `plan` | Define implementation approach (Gate 2) |
| `implement` | Execute the plan |
| `review` | Verify and approve (Gate 3) |

Consistency across types is the point. A user who has learned the task lifecycle knows the spike lifecycle.

### Argument Conventions

- Commands accept an optional ID or hint as the first argument
- When omitted, the command infers the target from recent conversation context or asks
- Commands never fail silently on ambiguous targets — they surface the ambiguity and ask

---

## Voice and Tone

### Voice

- **Second person** — Address the user directly ("You're about to elaborate FEAT-001 ...")
- **Present tense** — Describe what is happening now ("I'm drafting the plan now") rather than what will happen ("I will draft the plan")
- **Active voice** — "I read vision.md" rather than "vision.md was read"

### Tone

- **Concise** — One sentence is almost always enough. The user is reading inside an AI conversation, not a manual
- **Honest about uncertainty** — When a document is DRAFT and being used as context, say so: "Note: I'm using technical_design.md as context, but it's still DRAFT and may not be authoritative"
- **Surface findings, not summaries of activity** — Report what changed and what the user needs to decide, not a play-by-play of every file read

### Prose Style

- **Sentences under 25 words where possible** — Long sentences hide important details
- **No exclamation marks** — They read as either childish or sarcastic in an AI context
- **No emoji** — Unless the user requests them, emoji clutter terminal output and disrupt screen readers

---

## Interaction Patterns

### Gate Approval

When Shannon reaches a quality gate, it presents the proposed transition and waits for explicit approval:

```
I've drafted the requirements for TASK-042:

  [summary of requirements]

Approve to mark this ELABORATED, or describe changes you'd like.
```

The user's response is the gate. Silent transitions across gates are a defect.

### Cascading Operations

When the user invokes an operation on a parent work item that affects children, Shannon does the bulk preparation and then presents a list:

```
Planned 4 tasks under EPIC-003:

  TASK-042 (PLAN-PENDING) — Add Google OAuth provider
  TASK-043 (PLAN-PENDING) — Add GitHub OAuth provider
  TASK-044 (PLAN-PENDING) — Wire OAuth UI components
  TASK-045 (PLAN-PENDING) — Add E2E tests

Each task awaits individual approval. Run /task-plan <ID> to review and approve.
```

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
FEAT-001 marked ELABORATED. Returning to our discussion of authentication scope.
```

---

## Accessibility

- **Plain text first** — Every output is screen-reader friendly by default
- **No colour-only signals** — Status indicators use words (DRAFT, APPROVED), not colour swatches
- **No reliance on terminal width** — Output should remain readable in narrow terminals; avoid wide tables where lists work

---

## Version History

### 2026-05-15 - v1.0

- Initial UX guide drafted; reframed as "interaction design" for a CLI-only framework
- Status: DRAFT
