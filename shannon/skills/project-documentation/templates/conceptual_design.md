# Conceptual Design

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD]

---

**Project Name**: [Name of the product]

## Glossary

[Definitions of domain terms used throughout the project. The shared language. Add terms here as they emerge in vision, features, and conversations.]

- **[Term]** — [Definition from the business perspective, not the implementation]
- **[Term]** — [Definition from the business perspective, not the implementation]

---

## Domain Model

[The core entities, their conceptual attributes, and their relationships. Each entity is described from a business perspective — properties are concepts, not columns. No types, no nullability, no IDs.]

### [Entity Name]

[One or two sentences describing what this entity represents in the domain.]

**Attributes**:

- **[Attribute]** — [What it represents in the domain]
- **[Attribute]** — [What it represents in the domain]

**Relationships**:

- [Description of relationship to other entities, e.g. "Belongs to one or more Collections"]

### [Entity Name]

[As above.]

---

## Business Rules

[Invariants and constraints that govern the domain. Rules that must always hold true regardless of how the system is implemented.]

- [Rule — what it ensures and why]
- [Rule — what it ensures and why]

---

## Key Workflows

[How entities interact to accomplish user goals. Conceptual flows, not sequence diagrams or API call traces.]

### [Workflow Name]

**Goal**: [User outcome this workflow achieves]

**Flow**:

1. [Conceptual step]
2. [Conceptual step]
3. [Conceptual step]

**Rules applied**: [References to business rules from above]

---

## Bounded Contexts

[Logical boundaries between different parts of the system, if the domain is large enough to need them. Each context has its own model and language. For smaller systems, omit this section.]

### [Context Name]

[What this context covers, what its entities are, what crosses the boundary.]

---

## Version History

### [YYYY-MM-DD] - v1.0

- Initial conceptual design created
- Status: DRAFT

---

## What Belongs Here (and What Doesn't)

✅ Domain entities, attributes, relationships
✅ Business rules and invariants
✅ User-goal workflows at a conceptual level
✅ Shared language and glossary
✅ Bounded contexts (if applicable)

❌ Database schemas, ER diagrams, columns (→ technical_design.md)
❌ Classes, code, types (→ technical_design.md / code)
❌ API endpoints or payloads (→ technical_design.md)
❌ UI screens or interactions (→ ux_guide.md)
❌ Detailed algorithms (→ technical_design.md or knowledge notes)
