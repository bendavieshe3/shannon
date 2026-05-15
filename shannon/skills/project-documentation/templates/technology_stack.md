# Technology Stack

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD]

---

**Project Name**: [Name of the product]

## Architecture Overview

[High-level system structure and data flow. One or two paragraphs. Not implementation — just the shape of the system: what major pieces exist and how they talk to each other.]

---

## Core Technologies

[Languages, frameworks, and runtimes the product is built on. For each, capture purpose, rationale, and trade-offs. Use version ranges (e.g. "3.11+") rather than pinned versions — pins belong in lockfiles.]

### [Language / Framework / Runtime]

- **Purpose**: [What this is used for]
- **Rationale**: [Why chosen over alternatives, what it enables]
- **Trade-offs**: [Known limitations or downsides]
- **Aligns to**: [Vision § Section or principle this supports]

---

## Data Layer

[Database, ORM, and persistence strategy. Why this storage shape fits the domain.]

- **[Technology]** — [Purpose and rationale]

---

## External Integrations

[Third-party services, APIs, and SDKs the product depends on. Capture purpose and the integration boundary, not the contract details.]

- **[Service]** — [What it provides; why this one]

---

## Development Tooling

[Package manager, linting, testing, formatting, build tooling. What the team reaches for, not how to configure it.]

- **[Tool]** — [Role]

---

## Infrastructure

[Hosting, CI/CD, source control, observability. The platforms the product runs and ships on.]

- **[Platform]** — [Role and rationale]

---

## Key Dependencies

[Significant production and development packages whose presence shapes design decisions. Not an exhaustive lockfile dump — only the ones architects need to know about.]

### Production

- **[Package]** — [Purpose]

### Development

- **[Package]** — [Purpose]

---

## Security Considerations

[Data handling, secrets management, authentication approach at the stack level. Detailed security design belongs in technical_design.md; this section captures stack-level commitments.]

---

## Performance Targets

[Measurable benchmarks the stack must support. Concurrency, latency, throughput, storage. Used as input to technical_design.md decisions.]

- [Target — rationale]

---

## Future Considerations

[Known directions without commitment. Where the stack might evolve, what would trigger a change, what should not be foreclosed by current choices.]

---

## Version History

### [YYYY-MM-DD] - v1.0

- Initial technology stack defined
- Status: DRAFT

---

## What Belongs Here (and What Doesn't)

✅ Languages, frameworks, libraries chosen and why
✅ Trade-offs and limitations
✅ Stack-level performance and security targets
✅ Alignment to vision

❌ Implementation details, code snippets, configs (→ development_guide.md / knowledge notes)
❌ Step-by-step setup instructions (→ development_guide.md)
❌ API endpoints or schemas (→ technical_design.md)
❌ Decision changelog (this document tracks current state, not history)
