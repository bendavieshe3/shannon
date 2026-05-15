# Technical Design

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD]

---

**Project Name**: [Name of the product]

## System Architecture

[The major components, layers, and how they interact. Use an ASCII diagram if it helps. Stay at the architectural level — implementation belongs in code and knowledge notes.]

```
[Architectural diagram or textual description of major components]
```

### [Component]

- **Purpose**: [What this component is responsible for]
- **Technology**: [Reference technology_stack.md choice]
- **Responsibilities**: [Key concerns owned by this component]
- **Interfaces**: [How other components interact with it]

---

## Data Model

[How conceptual entities are persisted. Database schema shape, storage patterns, indexing strategy at a design level. Map conceptual entities to physical structures.]

| Conceptual Entity | Storage | Notes |
|---|---|---|
| [Entity from conceptual_design.md] | [Table / structure] | [Mapping notes] |

---

## API Design

[Style, conventions, and key endpoints or contracts. Not the full reference — the shape and patterns.]

- **Style**: [REST / GraphQL / RPC / message-based]
- **Versioning**: [How API versions are managed]
- **Key patterns**: [Pagination, filtering, error format, etc.]

---

## Key Algorithms

[Non-trivial logic that requires documentation. Search, ranking, sync, conflict resolution, etc. Conceptual flow, not code.]

### [Algorithm Name]

- **Purpose**: [What it accomplishes]
- **Approach**: [High-level approach]
- **Trade-offs**: [What this approach optimises for and what it sacrifices]

---

## Security Model

[Authentication, authorisation, and data protection approach. Threats considered, mitigations chosen. Detailed implementation lives in code and knowledge notes.]

- **Authentication**: [Approach]
- **Authorisation**: [Approach]
- **Data protection**: [Approach]

---

## Error Handling

[Strategy for failures, logging, and recovery. Where errors surface, how they propagate, what gets retried.]

---

## Performance Approach

[Caching, optimisation, and scaling strategies that shape the architecture. Concrete targets live in technology_stack.md.]

---

## Version History

### [YYYY-MM-DD] - v1.0

- Initial technical design created
- Status: DRAFT

---

## What Belongs Here (and What Doesn't)

✅ System architecture and component design
✅ Data model and storage decisions
✅ API design and contracts at the pattern level
✅ Key algorithms and their trade-offs
✅ Security, error handling, and performance approach

❌ Code or full implementations (→ codebase / knowledge notes)
❌ Deployment configuration (→ development_guide.md)
❌ User-facing behaviour (→ conceptual_design.md / ux_guide.md)
❌ Why technologies were chosen (→ technology_stack.md)
