# Technical Design

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD or "Not yet reviewed"]
**Approved By**: [Name or "Not yet reviewed"]

---

**Project Name**: [Name of the product]

## Overview

<!--
High-level technical architecture and implementation strategy.
1-2 paragraphs explaining the system architecture.
-->

[Describe the overall system architecture, major components, and how they interact]

**Example**:
> IdeaFlow uses a layered architecture with FastAPI backend, React frontend, and PostgreSQL database. The system follows domain-driven design principles, with clear separation between API layer, domain layer, and persistence layer. Real-time sync uses WebSockets, while the frontend can operate offline with local storage.

---

## System Architecture

<!--
Major components and how they interact.
Keep at architectural level - detailed implementation in knowledge notes.
-->

### Component Overview

```
[Architectural diagram using ASCII or description]
```

**Example**:
> ```
> ┌─────────────────┐
> │  React Frontend │ (TypeScript, Local Storage)
> └────────┬────────┘
>          │ HTTP/WebSocket
> ┌────────▼────────┐
> │   API Layer     │ (FastAPI, REST + WebSocket)
> └────────┬────────┘
>          │
> ┌────────▼────────┐
> │  Domain Layer   │ (Business Logic, Events)
> └────────┬────────┘
>          │
> ┌────────▼────────┐
> │ Persistence     │ (PostgreSQL, Redis)
> └─────────────────┘
> ```

### [Component Name]

**Purpose**: [What this component is responsible for]

**Technology**: [From technology_stack.md]

**Key Responsibilities**:
- [Responsibility 1]
- [Responsibility 2]
- [Responsibility 3]

**Interfaces**: [How other components interact with this one]

**Related**: [Link to detailed knowledge notes if they exist]

**Example**:
> ### API Layer
>
> **Purpose**: Expose RESTful and WebSocket endpoints for frontend communication
>
> **Technology**: FastAPI (Python 3.11+)
>
> **Key Responsibilities**:
> - Request validation and serialization
> - Authentication/authorization
> - Route incoming requests to domain layer
> - WebSocket connection management for real-time updates
>
> **Interfaces**:
> - REST endpoints for CRUD operations
> - WebSocket endpoint for real-time idea sync
> - Exposes OpenAPI documentation at /docs
>
> **Related**: See knowledge/technical-design-extra/api-design-patterns.md

### [Another Component]

[Description following same structure]

---

## Data Architecture

<!--
How data is organized, stored, and accessed.
Map conceptual_design.md entities to technical implementation.
-->

### Persistence Approach

**Structured Data**: [Where/how structured data is stored]

**Unstructured Data**: [Where/how unstructured data is stored]

**Caching Strategy**: [What's cached and where]

**Example**:
> **Structured Data**: PostgreSQL for ideas, collections, tags, users
> - Uses JSONB columns for flexible metadata
> - Full-text search via PostgreSQL tsvector
>
> **Unstructured Data**: File attachments stored in local filesystem (dev) or S3 (prod)
>
> **Caching Strategy**: Redis for:
> - User sessions (30 min TTL)
> - Frequently accessed ideas (5 min TTL)
> - Search results (2 min TTL)

### Entity Mapping

| Conceptual Entity | Implementation | Notes |
|-------------------|----------------|-------|
| [Entity from conceptual_design.md] | [Database table / data structure] | [Any mapping notes] |

**Example**:
> | Conceptual Entity | Implementation | Notes |
> |-------------------|----------------|-------|
> | Idea | `ideas` table | content stored as TEXT, metadata as JSONB |
> | Collection | `collections` table | Hierarchy via parent_id (adjacency list) |
> | Tag | `tags` table | Case-insensitive unique index |
> | Idea-Collection | `idea_collections` table | Junction table with added_at, pinned fields |

---

## [Feature/Capability Area]

<!--
Organize by major feature areas from product_requirements.md.
Each section explains the technical approach for implementing that capability.
-->

### [Feature Area, e.g., "Authentication"]

**Approach**: [High-level technical approach]

**Components Involved**:
- [Component 1 and its role]
- [Component 2 and its role]

**Flow**:
1. [Step 1 of how this works technically]
2. [Step 2]
3. [Step 3]

**Key Decisions**:
- [Decision 1 and rationale]
- [Decision 2 and rationale]

**Related**:
- **Conceptual**: conceptual_design.md § [section]
- **Implementation**: [Link to knowledge note if detailed implementation exists]

**Example**:
> ### Authentication
>
> **Approach**: OAuth 2.0 with PKCE flow for secure, token-based authentication
>
> **Components Involved**:
> - API Layer: Handles OAuth flows, validates tokens
> - Domain Layer: User entity management
> - Redis: Session storage
>
> **Flow**:
> 1. User initiates OAuth flow via frontend
> 2. API redirects to OAuth provider (Google, GitHub)
> 3. Provider returns authorization code
> 4. API exchanges code for access token (with PKCE verifier)
> 5. Session created in Redis, session ID returned to frontend
> 6. Frontend includes session ID in subsequent requests
>
> **Key Decisions**:
> - PKCE flow for mobile/SPA security (no client secret needed)
> - Redis sessions vs JWT: Sessions for revocability
> - 30-minute session TTL with refresh capability
>
> **Related**:
> - **Conceptual**: conceptual_design.md § "User"
> - **Implementation**: knowledge/implementation-details/oauth-implementation.md

### [Another Feature Area]

[Description following same structure]

---

## Event System

<!--
OPTIONAL: If the system uses events for communication between components.
Remove if not applicable.
-->

### Event Types

- **[Event Category]**: [Description and when triggered]

**Example**:
> ### Event Types
>
> - **Domain Events**: Business logic events (IdeaCreated, CollectionModified)
> - **UI Events**: User interactions (SearchPerformed, FilterApplied)
> - **System Events**: Infrastructure events (CacheInvalidated, SyncCompleted)

### Event Flow

[Describe how events propagate through the system]

**Example**:
> 1. Domain layer publishes event after state change
> 2. Event bus (in-process) notifies subscribers
> 3. WebSocket manager broadcasts relevant events to connected clients
> 4. Frontend updates UI optimistically, confirms with server

---

## Configuration Approach

<!--
How the system is configured across environments.
-->

**Approach**: [Overall configuration strategy]

**Configuration Sources**:
- [Source 1: e.g., "Environment variables"]
- [Source 2: e.g., "Config files"]

**Key Configuration Items**:
- [Item 1 and what it controls]
- [Item 2 and what it controls]

**Example**:
> **Approach**: 12-factor app principles - environment-based configuration
>
> **Configuration Sources**:
> - Environment variables (primary, for secrets and env-specific settings)
> - Default values in code (for development)
>
> **Key Configuration Items**:
> - `DATABASE_URL`: PostgreSQL connection string
> - `REDIS_URL`: Redis connection string
> - `SECRET_KEY`: Session encryption key (never committed)
> - `OAUTH_*`: OAuth provider credentials
> - `DEBUG`: Enable debug mode (default: false)

---

## API Design

<!--
OPTIONAL: High-level API design approach.
Remove if not a significant part of the system.
-->

**Style**: [REST, GraphQL, gRPC, etc.]

**Versioning**: [How API versions are managed]

**Key Patterns**:
- [Pattern 1]
- [Pattern 2]

**Example**:
> **Style**: RESTful JSON API with OpenAPI 3.0 documentation
>
> **Versioning**: URL-based (`/api/v1/...`)
>
> **Key Patterns**:
> - Resource-based URLs (`/ideas/{id}`, `/collections/{id}`)
> - Standard HTTP verbs (GET, POST, PUT, DELETE)
> - Pagination via `?limit=` and `?offset=`
> - Filtering via query params (`?tag=work&collection=inbox`)
> - WebSocket at `/ws` for real-time updates
>
> **Related**: See knowledge/technical-design-extra/api-design-patterns.md for details

---

## Security Considerations

<!--
High-level security approach.
Detailed implementation in knowledge notes.
-->

**Authentication**: [How users are authenticated]

**Authorization**: [How permissions are enforced]

**Data Protection**: [How sensitive data is protected]

**Key Security Measures**:
- [Measure 1]
- [Measure 2]
- [Measure 3]

**Example**:
> **Authentication**: OAuth 2.0 with PKCE (no passwords stored)
>
> **Authorization**: Role-based (admin, user) checked at API layer
>
> **Data Protection**:
> - All data encrypted at rest (database encryption)
> - TLS for all network communication
> - Secrets stored in environment variables (never committed)
>
> **Key Security Measures**:
> - Rate limiting on API endpoints (100 req/min per user)
> - Input validation via Pydantic models
> - SQL injection prevention via parameterized queries (SQLAlchemy)
> - XSS prevention via React's built-in escaping
> - CSRF tokens for state-changing operations

---

## Performance Considerations

<!--
OPTIONAL: Key performance strategies.
Remove if not critical to the system.
-->

**Target Performance**:
- [Metric 1: e.g., "API response < 200ms p95"]
- [Metric 2: e.g., "Search results < 1 second"]

**Strategies**:
- [Strategy 1]
- [Strategy 2]

**Example**:
> **Target Performance**:
> - API response < 200ms (p95)
> - Search results < 500ms for 10K ideas
> - UI feels instant (<100ms perceived latency)
>
> **Strategies**:
> - Redis caching for frequent queries
> - PostgreSQL indexes on search columns (GIN for full-text)
> - Optimistic UI updates (don't wait for server confirmation)
> - Lazy loading for idea content (load list first, details on demand)
> - WebSocket for real-time sync (avoid polling)

---

## Deployment Architecture

<!--
OPTIONAL: How the system is deployed.
Remove if too early in the project.
-->

**Environments**:
- **[Environment]**: [Purpose and configuration]

**Deployment Strategy**: [How deployments work]

**Example**:
> **Environments**:
> - **Development**: Local machine, SQLite database, no Redis
> - **Staging**: Heroku, PostgreSQL addon, Redis addon
> - **Production**: AWS (ECS), RDS PostgreSQL, ElastiCache Redis
>
> **Deployment Strategy**:
> - Docker containers via GitHub Actions
> - Blue-green deployment (zero downtime)
> - Automated database migrations via Alembic
> - Rollback capability (keep last 3 versions)

---

## Technical Debt & Future Improvements

<!--
OPTIONAL: Known technical limitations and planned improvements.
Helps track what needs attention.
-->

**Current Limitations**:
- [Limitation 1]
- [Limitation 2]

**Planned Improvements**:
- [Improvement 1 and timeline]
- [Improvement 2 and timeline]

**Example**:
> **Current Limitations**:
> - Single server deployment (no horizontal scaling yet)
> - In-process event bus (doesn't work across instances)
> - No database read replicas (all queries hit primary)
>
> **Planned Improvements**:
> - Phase 3: Add Redis Pub/Sub for distributed events
> - Phase 4: Implement read replicas for search queries
> - Phase 5: Add CDN for static assets

---

## Version History

<!--
Track significant changes to the technical design.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial technical design created
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.2
> - Added WebSocket architecture for real-time sync
> - Updated authentication to use PKCE flow
> - Added Redis caching strategy
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial technical design created
> - Status: APPROVED (2025-10-07)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Remove optional sections if not needed
5. Set Status to DRAFT
6. Update "Last Reviewed" to current date

**Key Reminders**:
- Keep **high-level** - detailed code/config goes in knowledge notes
- Map to **conceptual_design.md** entities (show the mapping)
- Reference **technology_stack.md** (don't duplicate rationale)
- Link to **knowledge notes** for detailed implementation
- Organize by **feature areas** from product_requirements.md
- This document **evolves** during implementation (expect changes)

**What Goes Here vs. Other Docs**:
- ✅ System architecture and component design
- ✅ How conceptual entities map to implementation
- ✅ Technical approach for each feature area
- ✅ API design, data architecture, event systems
- ❌ Why technologies were chosen (→ technology_stack.md)
- ❌ Business logic and domain rules (→ conceptual_design.md)
- ❌ Code examples and detailed implementations (→ knowledge notes)
- ❌ Development setup and tools (→ development_design.md)
