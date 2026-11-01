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
       - **Remaining:** [aspirations still forward work linked to this Feature]
     This is the at-a-glance headline summary of the Partial state — no Activity Log dive
     required. It is DISTINCT from the inline *(met)* / *(partly met)* annotations that may
     decorate individual Ideal State bullets: the sub-block summarises the headline; the
     inline annotations decorate per-aspiration items in the Requirements section. -->
- **Created**: [YYYY-MM-DD]
- **Updated**: [YYYY-MM-DD]

> **Status** moves through the human-governed Feature lifecycle: `DRAFT → ELABORATED → PLANNED → IMPLEMENTING ↔ IMPLEMENTED ↔ REVIEW → APPROVED`.
> **Activity** indicates current development state: `STABLE` (no active implementation) or `ACTIVE` (implementation in progress, with or without an Epic). Activity is descriptive state, orthogonal to Status.
> **Initial Implementation** records how the capability came to exist. *Built through Shannon* — full lifecycle through this framework. *Retrospective* — capability existed before Shannon was applied to the project; the Feature captures it after the fact. *Partial* — some of the capability is retrospective; the rest is forward work linked to this Feature.

> **Retrospective Features**: When Shannon is applied to an existing project, pre-existing capabilities are captured as Features starting in **ELABORATED + STABLE**. The Requirements section describes the capability as it exists (not aspirationally); the Activity Log records that initial implementation predates Shannon's adoption. The Plan may name the next delivery approach, with optional execution aids. See conceptual_design.md § Business Rules — *Retrospective Features*.

---

## Requirements

[Filled during elaboration. The "what" and "why" of this feature as a persistent capability of the product.]

### Overview

[One or two paragraphs: what this feature enables, who it serves, why it matters. Aspirational — what the product IS, not work to be done.]

### Ideal State

[The north star for this feature: what it looks like when fully mature. Bullet list of capabilities at full maturity. Implementation can be direct or use optional execution aids.]

- [Capability]
- [Capability]
- [Capability]

### Acceptance Criteria

[Observable Feature outcomes and constraints the human approves at Gate 1.]

- [ ] [Observable outcome]
- [ ] [Regression or constraint]

### User Stories

[Stories and acceptance criteria belong at Feature level; optional execution notes can add detail.]

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

[Approach, consequential trade-offs, dependencies and verification strategy for human Gate 2. Do not require a child hierarchy.]

### Approach

[Implementation direction and consequential choices; the agent owns routine execution details.]

### Optional Execution Aids

[Only add links when useful. Epics, Tasks and Spikes are optional and have no mandatory human gates.]

### Dependencies

[What this feature depends on, and what depends on it. Optional — only fill in when significant.]

**Depends on**: [Other features or external dependencies]

**Depended on by**: [Other features]

### Risks

[Known risks to delivering this feature and how they'll be mitigated.]

- [Risk — mitigation]

---

## Delivery Evidence

- **Changes**: [revision/diff and relevant Feature reference]
- **Checks**: [actual results and evidence, or not run]
- **Independent review**: [reviewer and verdict; cannot be the implementer]
- **Remaining work / next action**: [known gap or none]
- **Human acceptance**: [actual Gate 3 decision; pending until explicit]

## Success Metrics

[How we'll know this feature is succeeding. Outcomes, not outputs.]

- [Metric — target]

---

## Activity Log

[Timestamped entries recording the history. Newest at the top.]

- **[YYYY-MM-DD HH:MM]** — DRAFT: Feature created
