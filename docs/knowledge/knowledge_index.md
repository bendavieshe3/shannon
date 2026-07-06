# Knowledge Index

## Research

- **[note-name].md** - [One-line description]

**Example**:
> - **oauth-vs-jwt-auth.md** - Authentication pattern comparison for SPAs
> - **session-storage-comparison.md** - Session storage strategies (Redis vs DB vs JWT)
> - **search-algorithms-comparison.md** - Full-text search: PostgreSQL vs Elasticsearch vs Typesense

## Implementation Details

- **[note-name].md** - [One-line description]

**Example**:
> - **oauth-implementation.md** - OAuth 2.0 + PKCE implementation with token refresh
> - **redis-session-config.md** - Redis session configuration and patterns
> - **search-indexing-strategy.md** - PostgreSQL full-text search with GIN indexes
> - **search-ranking-algorithm.md** - Custom search ranking (relevance + recency)

## Extensions

- **[meta-gap-routing-channel.md](./meta-gap-routing-channel.md)** - Extends: `development_guide.md` § "Testing Strategy → Pre-Commit Checklist" + § "Git Workflow → Push Cadence" - The meta-gap routing channel codified by EPIC-008 with EPIC-007 as contemporaneous sibling exercise; includes the section-boundary-uniqueness Edit-anchor technique

- **[note-name].md** - Extends: [doc-name] § [Section] - [Description]

**Example**:
> - **api-design-patterns.md** - Extends: technical_design.md § "API Design" - RESTful patterns and error handling
> - **database-migration-strategy.md** - Extends: technical_design.md § "Data Architecture" - Zero-downtime migrations
> - **idea-versioning-algorithm.md** - Extends: conceptual_design.md § "Versioning" - Conflict resolution algorithm
> - **detailed-persona-research.md** - Extends: product_requirements.md § "Personas" - Extended user interviews

## Supervisor Reports

- **[report-2026-07-05.md](../supervisor/report-2026-07-05.md)** - Type: *Supervisor Report* - First dogfood `/shannon-report` run (EPIC-009 / TASK-018); 3/3 checkers, 10 findings; top finding: the codified `knowledge_index.md` path mismatch.

---

## Notes

**Research**: General technology comparisons (not project-specific yet)

**Implementation Details**: How we actually implement things in this project

**Extensions**: Detailed elaborations of mandated document sections

**When to update**: Just add new notes to the appropriate section when created.
