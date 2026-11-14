# FEAT-007: Lightweight Idea Capture

## Metadata

- **Status**: IMPLEMENTED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Lightweight Idea Capture" (added 2026-05-18 in Vision v2.2 in response to this Feature's surfaced gap)
- **Initial Implementation**: Partial — see Activity Log
  - **Met:** The live `docs/scratchpad.md` — one-line capture format, optional tags, no IDs, a Processed section, and an informal "process periodically" workflow; plus the Vision § Key Features anchor added in v2.2.
  - **Implemented in source 2026-11-13 (finish-to-vision push; not yet accepted):** `conceptual_design.md` v2.1 *Scratchpad* glossary entry, *Scratchpad Item* entity and *Processing the Scratchpad* workflow; `technical_design.md` v2.1 Data Model row and *Scratchpad Verbs*; `/scratchpad-add` and `/scratchpad-process` commands backed by the `work-items` skill § Scratchpad; a shipped `work-items/templates/scratchpad.md` that `/shannon-setup` instantiates; surfacing in `shannon_overview.md`, both READMEs and the project CLAUDE.md template.
  - **Remaining:** None in source; human Gate 3 acceptance is outstanding. Evidence: the first real `/scratchpad-process` pass (2026-11-14: 15 items disposed, 1 kept), and two later passes the same day closing the items EPIC-012, TASK-030 and TASK-032 delivered.
- **Created**: 2026-05-18
- **Updated**: 2026-11-14

---

## Requirements

### Overview

Shannon provides a low-friction capture point — `docs/scratchpad.md` — for ideas, half-formed work, and unprocessed TODOs that don't yet belong to a work item. The scratchpad is pre-workflow: items live there without IDs, without status, without a parent. When an idea coheres enough to be acted on, it gets promoted to a Feature, Epic, Task, or Spike (or moved to a knowledge note for durable findings, or simply dropped).

The capability exists because not every thought is ready to be a work item. Forcing premature classification creates friction; ignoring half-formed thoughts loses them. The scratchpad is the deliberate middle.

### Ideal State

- A single `docs/scratchpad.md` file at the project root of `docs/`, with a documented "process periodically" workflow
- One-line format, optional tags, no IDs — capture stays cheap
- A "Processed" section records items resolved or promoted, with a pointer to where they ended up
- A processing rhythm exists (currently informal — emerges with use)
- The framework's commands occasionally surface scratchpad items (e.g. as part of a future `/what-next` command — see scratchpad)
- The scratchpad is documented as a Shannon capability in vision and `shannon_overview.md`, not just an emergent file

### User Stories

#### Quick Capture Without Commitment

**As a** directing party,
**I want** to jot down an idea without classifying it,
**So that** I don't lose thoughts that aren't ready to be work items.

#### Periodic Processing

**As a** directing party,
**I want** a clear "process the scratchpad" rhythm,
**So that** captured items don't pile up indefinitely.

#### Promoting When Ready

**As a** directing party,
**I want** to promote a scratchpad item to a Feature/Epic/Task/Spike when it coheres,
**So that** the lightweight pattern dovetails cleanly with the formal work-item model.

### Context

- **Vision**: § Key Features — "Lightweight Idea Capture" (added in Vision v2.2 on 2026-05-18 to close the gap this Feature surfaced)
- **Conceptual Design**: Should add a *Scratchpad* glossary entry and possibly a workflow ("Processing the Scratchpad"). Currently silent
- **Technical Design**: Should describe the scratchpad file location, format, and processing mechanics. Currently silent
- **Project files**: `docs/scratchpad.md` (live, 11 items as of 2026-05-18)

---

## Plan

### Epics

- **Candidate next Epic: Formalise the scratchpad as a documented Shannon capability** — Add Vision reference (Key Feature), add Scratchpad concept to conceptual_design (glossary entry, Processing workflow), add technical_design notes on file structure, surface in `shannon_overview.md`. Possibly add a `/scratchpad` family of commands (`/scratchpad-add`, `/scratchpad-process`). This Feature self-describes as Partial because the file exists but the capability is not yet ratified in upstream docs.

### Dependencies

**Depends on**: FEAT-002 (Mandated Project Documentation) — scratchpad lives alongside mandated docs; FEAT-003 (Unified Work Item Model) — promotion targets are work items

**Depended on by**: Candidate future Feature `/what-next` (mentioned in scratchpad) — would surface aged scratchpad items as one input

### Risks

- **Junk-drawer drift** — Without periodic processing, scratchpad can degenerate into noise. Mitigation: any future formalisation should include a processing rhythm
- **Vision gap** — Currently elaborates a capability not named in Vision. Either Vision gets updated (next Vision review) or this Feature gets a different anchor; until then, the asymmetry is honest but uncomfortable
- **Premature command surface** — Adding `/scratchpad-*` commands now may calcify the pattern before it's matured by use. Capture commands as a candidate, not a commitment

---

## Success Metrics

- **Items captured** — Items added to scratchpad over time (qualitative; volume isn't itself a goal but absence indicates the capture step isn't happening)
- **Promotion rate** — Fraction of scratchpad items that eventually get promoted to work items vs dropped (healthy mix indicates the pattern is working)
- **Item age distribution** — Items shouldn't all be ancient — that would indicate processing isn't happening

---

## Activity Log

- **2026-11-14** — ELABORATED → PLANNED → IMPLEMENTED. Gate 2 approved by the directing party's approval of 2026-11-14 ("yes, pending decisions as recommended" on 2026-11-13, then "Just do it. Just do it all"), which covers the finish-to-vision plan offered on the Gate 2 card. Delivered in Shannon 5.1 (PR #16). Independent review as for PR #16. Awaiting Gate 3.
- **2026-11-14** — First real processing pass on Shannon's own scratchpad, following `work-items` § Scratchpad → Process: 32 open items read; 15 moved to § Processed (8 acted within approved intent, 1 to knowledge, 6 dropped as superseded by Feature-level governance), 1 kept with a dated note, 16 left as they were (7 wait on EPIC-012's conventions, the rest are not ready). No promotion needed a human decision. Evidence for Gate 3.
- **2026-11-13** — Implementation in source of the Plan's candidate ("formalise the scratchpad as a documented Shannon capability"), delivered directly under this Feature with no Epic, per Vision v3.0. Commands are limited to `add` and `process`, which addresses the *Premature command surface* risk: capture stays a one-line edit, and processing gets a named rhythm tied to the Drift Checker's scratchpad-pressure finding (the *Junk-drawer drift* mitigation). Approach offered to the directing party for Gate 2 in the finish-to-vision plan. No status change until that decision.
- **2026-05-22** — Re-elaborated (additive). **Trigger**: framework evolution — EPIC-006 (via TASK-002, commit `09844df`) delivered the queryable Partial-completeness affordance that pre-existing Partial Features must absorb. **Change**: added the `**Met:** / **Remaining:**` sub-block beneath the `Initial Implementation` line, surfacing the Partial state at a glance; applied via TASK-003. Additive — no previously-approved claim contradicted; status stays ELABORATED.
- **2026-05-18** — ELABORATED: Feature created. Partially implemented: `docs/scratchpad.md` exists and is actively used (11 items, 2 processed) as of this Feature's creation. The pattern is informal — no Vision anchor, no conceptual_design entity, no canonical processing workflow. A first Epic to formalise the capability is the obvious next step, blocked on the Vision update.
- **2026-05-18** — Vision Reference updated. Vision v2.2 (approved 2026-05-18) added "Lightweight Idea Capture" as a 5th Key Feature, closing the gap this Feature originally surfaced. Conceptual_design entity and `/scratchpad-*` commands remain Partial — candidate next Epic still applies.
