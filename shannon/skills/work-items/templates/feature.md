# FEAT-[XXX]: [Feature Name — a persistent capability]

## Metadata

- **Status**: DRAFT
- **Activity**: STABLE
- **Type**: Feature
- **Vision Reference**: § "[Section in vision.md this feature elaborates]"
- **Initial Implementation**: [Built through Shannon | Retrospective (predates Shannon) | Partial — see Activity Log]
<!-- Partial-completeness sub-block — emit ONLY when Initial Implementation is Partial.
     Place directly beneath the Initial Implementation line, inside this Metadata block:
       - **Met:** [aspirations already delivered]
       - **Remaining:** [aspirations still forward work through new Epics]
     This is the at-a-glance headline summary of the Partial state — no Activity Log dive
     required. It is DISTINCT from the inline *(met)* / *(partly met)* annotations that may
     decorate individual Ideal State bullets: the sub-block summarises the headline; the
     inline annotations decorate per-aspiration items in the Requirements section. -->
- **Created**: [YYYY-MM-DD]
- **Updated**: [YYYY-MM-DD]

> **Status** moves through the unified lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no epic in progress) or `ACTIVE` (an epic is being worked on). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work through new Epics.

> **Retrospective Features**: When Shannon is applied to an existing project, pre-existing capabilities are captured as Features starting in **ELABORATED + STABLE**. The Requirements section describes the capability as it exists (not aspirationally); the Activity Log records that initial implementation predates Shannon's adoption. The Plan section may be empty (no Epics yet) or may name the next Epic if further evolution is planned. See conceptual_design.md § Business Rules — *Retrospective Features*.

---

## Requirements

[Filled during elaboration. The "what" and "why" of this feature as a persistent capability of the product.]

### Overview

[One or two paragraphs: what this feature enables, who it serves, why it matters. Aspirational — what the product IS, not work to be done.]

### Ideal State

[The north star for this feature: what it looks like when fully mature. Bullet list of capabilities at full maturity. Reaching this is an ongoing journey across many epics.]

- [Capability]
- [Capability]
- [Capability]

### User Stories

[High-level stories grouped by theme. Detailed acceptance criteria live in the epics and tasks that elaborate this feature.]

#### [Theme]

**As a** [user type],
**I want** [capability],
**So that** [benefit].

#### [Theme]

**As a** [user type],
**I want** [capability],
**So that** [benefit].

### Context

[Links to relevant documents and a summary of what makes them relevant.]

- **Vision**: § [section]
- **Conceptual Design**: [entities or rules this feature touches]
- [Other documents]

---

## Plan

[Filled during planning. The feature's planning artefact is its list of epics that deliver it over time.]

### Epics

[Epics accumulate over the life of the feature. Each epic is a coherent unit of work delivering part of the ideal state.]

- [EPIC-XXX](../epics/EPIC-XXX-slug.md) — STATUS — [Epic Name]
- [EPIC-XXX](../epics/EPIC-XXX-slug.md) — STATUS — [Epic Name]

### Dependencies

[What this feature depends on, and what depends on it. Optional — only fill in when significant.]

**Depends on**: [Other features or external dependencies]

**Depended on by**: [Other features]

### Risks

[Known risks to delivering this feature and how they'll be mitigated.]

- [Risk — mitigation]

---

## Success Metrics

[How we'll know this feature is succeeding. Outcomes, not outputs.]

- [Metric — target]

---

## Activity Log

[Timestamped entries recording the history. Newest at the top.]

- **[YYYY-MM-DD HH:MM]** — DRAFT: Feature created
