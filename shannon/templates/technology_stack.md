# Technology Stack

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD or "Not yet reviewed"]
**Approved By**: [Name or "Not yet reviewed"]

---

**Project Name**: [Name of the product]

## Overview

<!--
Brief summary of the technology stack and overall technical approach.
1-2 paragraphs explaining the stack philosophy.
-->

[Describe the overall technology approach and key architectural decisions]

**Example**:
> This project uses a Python backend with FastAPI for its async capabilities and automatic API documentation. The frontend uses React with TypeScript for type safety. We prioritize simplicity and maintainability over cutting-edge features, choosing mature, well-documented technologies with strong community support.

---

## Languages

<!--
Programming languages used and rationale for each.
Include version ranges where important (but not specific versions - too volatile).
-->

### [Language Name] [Version Range if relevant]

**Purpose**: [What this language is used for in the project]

**Rationale**:
- [Reason 1: e.g., "Rich ecosystem for domain"]
- [Reason 2: e.g., "Team expertise"]
- [Reason 3: e.g., "Performance characteristics"]

**Trade-offs**:
- [Trade-off 1: e.g., "Slower than compiled languages"]
- [Trade-off 2: e.g., "Requires runtime environment"]

**Alignment**: [How this supports product_requirements.md goals]

**Example**:
> ### Python 3.11+
>
> **Purpose**: Primary backend language for API, business logic, and data processing
>
> **Rationale**:
> - Rich ecosystem for AI/ML capabilities (aligns with product vision)
> - Strong typing support via type hints (maintainability)
> - Excellent async support for real-time features
> - Team has deep Python expertise
>
> **Trade-offs**:
> - Performance lower than Go/Rust for CPU-intensive tasks
> - Requires runtime environment (not a single binary)
>
> **Alignment**: Supports rapid development of AI-powered features mentioned in product_requirements.md § "Intelligent Organization"

---

## Frameworks

<!--
Major frameworks (web, mobile, etc.) and rationale.
Focus on the "why" not the "how".
-->

### [Framework Name]

**Purpose**: [What problem this framework solves]

**Rationale**:
- [Reason 1]
- [Reason 2]
- [Reason 3]

**Trade-offs**:
- [Trade-off or limitation]

**Alignment**: [How this enables product requirements]

**Example**:
> ### FastAPI
>
> **Purpose**: Web framework for building RESTful and WebSocket APIs
>
> **Rationale**:
> - Built-in async support for real-time features
> - Automatic OpenAPI documentation
> - Type validation with Pydantic
> - Modern Python features (type hints)
>
> **Trade-offs**:
> - Newer than Flask/Django (smaller community)
> - Requires Python 3.7+
>
> **Alignment**: Real-time sync requirements in product_requirements.md § "Collaboration"

---

## Libraries

<!--
Key third-party libraries and their purpose.
Group by category if there are many.
Link to knowledge notes for detailed implementation guidance.
-->

### [Category Name, e.g., "Authentication"]

#### [Library Name]

**Purpose**: [What this library does]

**Rationale**: [Why chosen over alternatives]

**Related**: [Link to knowledge notes if detailed implementation exists]

**Example**:
> ### Authentication
>
> #### Authlib
>
> **Purpose**: OAuth 2.0 authentication implementation
>
> **Rationale**: Standards-compliant, actively maintained, supports PKCE flow
>
> **Related**: See knowledge/implementation-details/oauth-implementation.md for usage details

### [Another Category]

#### [Library Name]

**Purpose**: [What this library does]

**Rationale**: [Why chosen]

---

## Development Tools

<!--
Tools used during development (not runtime dependencies).
Includes: linters, formatters, testing tools, build tools, etc.
-->

### Code Quality

- **[Tool Name]**: [Purpose and why chosen]
- **[Tool Name]**: [Purpose and why chosen]

**Example**:
> ### Code Quality
>
> - **Ruff**: Fast Python linter and formatter (replaces multiple tools)
> - **mypy**: Static type checker for Python (catches type errors early)
> - **pytest**: Testing framework (simple, powerful, widely used)

### Build & Deployment

- **[Tool Name]**: [Purpose and why chosen]
- **[Tool Name]**: [Purpose and why chosen]

**Example**:
> ### Build & Deployment
>
> - **Docker**: Containerization for consistent environments
> - **GitHub Actions**: CI/CD pipeline (free for public repos, integrated with GitHub)

---

## Infrastructure & Services

<!--
OPTIONAL: Cloud services, databases, third-party APIs, etc.
Remove this section if not applicable.
-->

### Database

- **[Database Name]**: [Purpose and rationale]

**Example**:
> ### Database
>
> - **PostgreSQL 15+**: Primary relational database (ACID compliance, full-text search, JSON support)
> - **Redis 7+**: Caching and session management (fast, simple, reliable)

### Cloud Services (if applicable)

- **[Service Name]**: [Purpose and rationale]

**Example**:
> ### Cloud Services
>
> - **AWS S3**: File storage (scalable, cost-effective, industry standard)
> - **Cloudflare**: CDN and DDoS protection (free tier, easy setup)

---

## Technology Decision Log

<!--
OPTIONAL: Track major technology decisions and when they were made.
Useful for understanding the evolution of the stack.
Remove if not needed.
-->

| Date | Decision | Rationale | Status |
|------|----------|-----------|--------|
| [YYYY-MM-DD] | [Technology choice] | [Why] | Active / Deprecated |

**Example**:
> | Date | Decision | Rationale | Status |
> |------|----------|-----------|--------|
> | 2025-10-01 | Chose FastAPI over Flask | Need async support for WebSockets | Active |
> | 2025-09-15 | PostgreSQL over MongoDB | Structured data, need ACID compliance | Active |

---

## Known Limitations & Future Considerations

<!--
OPTIONAL: Document known limitations of current technology choices
and potential future changes.
-->

**Current Limitations**:
- [Limitation 1]
- [Limitation 2]

**Future Considerations**:
- [Potential technology change and why we might make it]

**Example**:
> **Current Limitations**:
> - Python performance may become bottleneck at high scale (>10K concurrent users)
> - SQLite local storage limits collaborative features
>
> **Future Considerations**:
> - May add Rust microservices for CPU-intensive operations
> - Could migrate to PostgreSQL for multi-user deployments

---

## Version History

<!--
Track significant changes to the technology stack.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial technology stack defined
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.1
> - Added Redis for session management
> - Deprecated MongoDB, migrated to PostgreSQL
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial technology stack defined
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
- Focus on **rationale** (why) not implementation details (how)
- **No specific version numbers** (use ranges like "3.11+" or "15+")
- Link to **knowledge notes** for detailed usage/configuration
- Always explain **trade-offs** (every choice has downsides)
- Show **alignment to product requirements** where relevant
- Detailed configuration goes in **development_design.md** or **knowledge notes**

**What Goes Here vs. Other Docs**:
- ✅ Languages, frameworks, libraries chosen and why
- ✅ Trade-offs and limitations of choices
- ✅ Alignment to product requirements
- ❌ How to install/configure tools (→ development_design.md)
- ❌ Code patterns/conventions (→ code_style_guide.md)
- ❌ Architecture decisions (→ technical_design.md)
- ❌ Detailed tool usage (→ knowledge notes)
