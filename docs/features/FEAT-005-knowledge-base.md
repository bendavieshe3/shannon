# FEAT-005: Knowledge Base

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Knowledge Base"
- **Initial Implementation**: Retrospective (predates this Feature's creation)
- **Created**: 2026-05-18
- **Updated**: 2026-05-18

---

## Requirements

### Overview

Shannon maintains a Knowledge Base — a dedicated directory (`./docs/knowledge/`) containing notes classified as Research, Implementation Details, or Extension. Knowledge notes capture investigation findings, implementation gotchas, decision rationales, and elaborations of mandated documents that don't fit inline. Spikes always produce a knowledge note as their primary durable artefact; other work items capture knowledge optionally when something worth persisting emerges.

The capability exists so that the same investigation doesn't have to happen twice. Without it, learnings disappear into commit history and chat logs.

### Ideal State

- Three note types — Research, Implementation Details, Extension — cover the realistic shapes of project knowledge
- The `knowledge_index.md` is the navigation surface, with one-line entries per note grouped by type
- Notes are cross-referenced from the originating work item and from any mandated document they extend
- Spike outputs land in the knowledge base automatically (not as an afterthought)
- The implementer prompts the directing party when it notices a knowledge-note candidate
- Knowledge notes are not gated artefacts — they're working knowledge, not reviewed context (per conceptual_design "Capturing Knowledge as the Project Runs" workflow)
- Future work touching related areas surfaces relevant notes via the index when reading context

### User Stories

#### Avoiding Repeated Investigation

**As a** directing party,
**I want** insights captured at the moment they're produced,
**So that** the same research doesn't happen again next month.

#### Extending Documents Without Bloating Them

**As a** directing party,
**I want** a place for elaboration that doesn't fit in mandated documents,
**So that** the mandated docs stay scoped while details remain accessible.

#### Surfacing Knowledge When Relevant

**As a** directing party,
**I want** the implementer to read related knowledge notes when elaborating new work,
**So that** prior learnings inform future decisions without me having to remember which notes exist.

### Context

- **Vision**: § Key Features ("Knowledge Base"), Core Principle 4 ("Adaptive Coherence") — "knowledge accumulates so the same investigation never happens twice"
- **Conceptual Design**: *Knowledge Note* entity (Research / Implementation Details / Extension types), *Capturing Knowledge as the Project Runs* workflow, *Spike Output Is Knowledge* business rule
- **UX Guide**: § Knowledge Note Creation (prompt-to-capture and classification pattern)
- **Project files**: `shannon/skills/project-documentation/templates/knowledge_note.md`, `knowledge_index.md`; `./docs/knowledge/` directory in deployed projects

---

## Plan

### Epics

*None yet. Candidate future Epics: automatic surfacing of relevant knowledge notes during work-item elaboration (currently the implementer has to remember to look), aggregate metrics over the knowledge base, search/discovery improvements as the corpus grows.*

### Dependencies

**Depends on**: FEAT-002 (Mandated Project Documentation) — knowledge notes extend mandated docs; FEAT-003 (Unified Work Item Model) — work items reference and produce knowledge notes

**Depended on by**: FEAT-003 specifically through spikes — a spike's durable artefact is a knowledge note

### Risks

- **Note proliferation without curation** — Without periodic review, the knowledge base may grow noisy. No canonical curation rhythm yet; relies on the directing party to prune. Worth a future workflow
- **Discovery latency** — Notes are indexed but not searchable beyond grep. As the corpus grows this may degrade; revisit before the index gets long

---

## Success Metrics

- **Capture rate** — Spikes produce knowledge notes 100% of the time (per business rule); other work items capture when a candidate emerges (subjective)
- **Reuse rate** — Knowledge notes get referenced by subsequent work items (qualitative — proxy for the "same investigation never happens twice" commitment)
- **Index hygiene** — knowledge_index.md stays in sync with `./docs/knowledge/` contents

---

## Activity Log

- **2026-05-19** — Vision Reference updated: Principle 4 renamed "Living Documentation" → "Adaptive Coherence" in Vision v2.3 (commit forthcoming). Maintenance update; no change to the Feature's content.
- **2026-05-18** — ELABORATED: Feature created retrospectively. Knowledge note template, index template, and the "Capturing Knowledge as the Project Runs" workflow were built during the Shannon v4 refactor and subsequent reviews (commits `6852b29` through `d4ccc03`). The knowledge base directory is empty as of this Feature's creation — infrastructure exists, no notes yet captured through Shannon.
