# FEAT-002: Mandated Project Documentation

## Metadata

- **Status**: ELABORATED
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § Key Features — "Mandated Project Documentation"
- **Initial Implementation**: Retrospective (predates this Feature's creation)
- **Created**: 2026-05-18
- **Updated**: 2026-05-18

---

## Requirements

### Overview

Shannon provides six core documents — vision, technology stack, conceptual design, technical design, development guide, UX guide — that together describe a project at every relevant scope. Documents form an explicit authority graph where lower documents must align to and enable higher ones. The framework treats drift between layers as a defect and provides an alignment-check workflow that runs on every `/document-review`.

This is the foundational capability of Shannon: it makes AI-readable, human-reviewed documentation the spine of the project. Every other framework capability either consumes these documents (work items as context) or extends them (knowledge notes).

### Ideal State

- Every project using Shannon has all six mandated documents present and APPROVED
- Each document follows a defined Purpose/Scope template producing predictable structure
- The document authority graph is enforced — drift is caught by the alignment subagent
- DRAFT/APPROVED status makes "trusted context" explicit and machine-readable
- Re-approval cascades when an upstream document changes
- Templates ship inside the `project-documentation` skill so deploying Shannon brings the documentation framework with it

### User Stories

#### Establishing Project Context

**As a** directing party,
**I want** my project's vision, technology, domain, architecture, and conventions captured in six standard documents,
**So that** AI can use them as authoritative context without me having to re-explain things.

#### Maintaining Alignment

**As a** directing party,
**I want** the framework to catch when a lower document drifts from a higher one,
**So that** documentation stays coherent as the project evolves.

#### Reviewing Documents

**As a** directing party,
**I want** an explicit `/document-review` workflow with a four-category finding report,
**So that** I can approve documents efficiently and know what was checked.

### Context

- **Vision**: § Key Features ("Mandated Project Documentation")
- **Conceptual Design**: *Mandated Document* entity, *Document Alignment Direction* and *DRAFT Documents Are Not Authoritative* business rules, *Creating and Approving a Mandated Document* workflow
- **Technical Design**: § Document Alignment Check (algorithm, four-category schema)
- **Project files**: `shannon/skills/project-documentation/templates/*` (the six templates), `shannon/skills/project-documentation/skill.md`, `shannon/commands/document-create.md` and `document-review.md`

---

## Plan

### Epics

*None yet — the capability is established. Future Epics may extend it (e.g. richer alignment categories, automatic re-approval cascade triggers).*

### Dependencies

**Depends on**: None — this is the foundational feature.

**Depended on by**: All other features. Work items rely on mandated documents as authoritative context.

### Risks

- **Template ossification** — Templates may calcify as the framework matures. Periodic review against real projects' needs is the mitigation; no canonical schedule yet
- **Alignment subagent cost** — Running the alignment check on every `/document-review` consumes tokens. Acceptable today; revisit if cost becomes a constraint

---

## Success Metrics

- **Six-document completeness** — Projects using Shannon have all six mandated documents instantiated (vs zero/partial)
- **Approval rate** — Documents reach APPROVED status (not stuck in DRAFT indefinitely)
- **Alignment drift detection latency** — Drift surfaces during the next `/document-review` after upstream change, not weeks later (per Vision § Directional Targets)

---

## Activity Log

- **2026-05-18** — ELABORATED: Feature created retrospectively to capture the framework's existing Mandated Project Documentation capability. Six documents and the project-documentation skill were built during the Shannon v4 refactor (commits `6852b29` through `d4ccc03`). This Feature codifies the capability for future evolution.
