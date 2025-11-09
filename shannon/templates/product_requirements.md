# Product Requirements Document

**Status**: DRAFT
**Last Reviewed**: [Current date in YYYY-MM-DD format]

---

Product Name: [Name of the product]

## Product Vision

<!--
What the product aims to achieve and why it matters.
- Focus on the value proposition and overall goals
- Keep it concise (2-4 paragraphs)
- Avoid technical implementation details
-->

[Describe the product vision: what problem does this solve, who is it for, and why does it matter?]

**Example**:
> IdeaFlow helps solo developers and knowledge workers capture, organize, and rediscover their ideas effortlessly. Unlike traditional note-taking apps, IdeaFlow emphasizes fluid organization and serendipitous rediscovery, ensuring valuable insights never get lost.

---

## Personas

<!--
Describe the primary users of this product.
- Include 1-3 key personas
- Focus on needs, pain points, and goals
- Reference these personas throughout the document
-->

### [Persona Name]: [Role/Description]

**Background**:
- [Relevant context about this user]
- [Their typical environment/workflow]

**Needs**:
- [Key need 1]
- [Key need 2]
- [Key need 3]

**Pain Points** (with current solutions):
- [Pain point 1]
- [Pain point 2]
- [Pain point 3]

**Goals**:
- [Goal 1]
- [Goal 2]

**Example**:
> ### Primary User: Solo Developer
>
> **Background**:
> - Works on multiple projects simultaneously
> - Frequently context-switches between tasks
> - Values simple, focused tools over complex systems
>
> **Needs**:
> - Quick idea capture without breaking flow
> - Organization that adapts to how they think
> - Fast retrieval when context-switching
>
> **Pain Points**:
> - Markdown files get lost in directory trees
> - Tags become inconsistent over time
> - No good way to rediscover related ideas
>
> **Goals**:
> - Never lose a valuable insight
> - Spend less time organizing, more time creating
> - Build a personal knowledge base that grows with them

---

## Product Pillars

<!--
Core principles that guide product decisions.
- Typically 3-6 pillars
- These are enduring values, not features
- Reference when making design trade-offs
-->

### 1. **[Pillar Name]**
[Description of this principle and why it matters]

### 2. **[Pillar Name]**
[Description of this principle and why it matters]

### 3. **[Pillar Name]**
[Description of this principle and why it matters]

**Example**:
> ### 1. **Simplicity**
> The interface should be intuitive enough for first-time users while powerful enough for daily use. Every feature must justify its complexity.
>
> ### 2. **Traceability**
> Clear connections from user needs → features → implementation. Nothing gets built without understanding why.
>
> ### 3. **Privacy First**
> User data stays local by default. Cloud sync is optional and encrypted. Users own their data.

---

## High-Level User Stories

<!--
Section-based user stories (not numbered requirements).
- Organize by capability area or user journey
- Keep stories high-level (detailed stories go in features)
- Cross-reference implementing features
- Update as features are created
-->

### [Capability Area 1]

[Describe the user need in this area]

**Features**: [Leave empty initially, will be populated as features are created]

**Example**:
> ### Organization & Discovery
>
> Users need to capture ideas instantly and organize them effortlessly. The system should adapt to how users think, not force them into rigid hierarchies.
>
> **Features**: FEAT-003 (Organizes User Ideas), FEAT-005 (Enables Fluid Organization)

### [Capability Area 2]

[Describe the user need in this area]

**Features**: [Leave empty initially]

### [Capability Area 3]

[Describe the user need in this area]

**Features**: [Leave empty initially]

---

## Scope & Constraints

<!--
OPTIONAL: Include if there are important constraints or explicit non-goals.
Remove this section if not needed.
-->

### In Scope
- [What this product WILL do]
- [Key capabilities included]

### Out of Scope (for now)
- [What this product will NOT do]
- [Features explicitly deferred]

### Constraints
- [Technical constraints, if any]
- [Business constraints, if any]
- [Timeline constraints, if any]

**Example**:
> ### In Scope
> - Local-first idea capture and organization
> - Fast full-text search
> - Flexible tagging and collections
>
> ### Out of Scope (for now)
> - Real-time collaboration (future consideration)
> - Mobile apps (v2.0+)
> - Third-party integrations
>
> ### Constraints
> - Must work offline
> - Must be fast enough for 10,000+ ideas
> - Must use open formats (Markdown, JSON)

---

## Success Metrics

<!--
OPTIONAL: How will we know this product is successful?
Remove this section if not needed for your project.
-->

- [Metric 1: e.g., "User can capture idea in <5 seconds"]
- [Metric 2: e.g., "95% of users find what they're looking for"]
- [Metric 3: e.g., "Daily active usage after 30 days"]

**Example**:
> - User can capture an idea in under 5 seconds
> - Users successfully find specific ideas 90%+ of the time
> - Users continue using the product 3+ months after initial adoption

---

## Version History

<!--
Track significant changes to this document.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial product requirements created
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.1
> - Added "Collaboration" capability area
> - Refined Solo Developer persona
> - Updated success metrics
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial product requirements created
> - Status: APPROVED (2025-10-07)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Customize sections as needed (add/remove based on project)
5. Set Status to DRAFT
6. Update "Last Reviewed" to current date

**Key Reminders**:
- This is a **living document** - update as product understanding evolves
- Keep it **high-level** - detailed technical decisions go in technical_design.md
- **Section names** become feature references (e.g., § "Organization & Discovery")
- **No numbered requirements** - sections provide enough structure
- Update **Features** field as features are created via `/feature-create`
- Run `/document-review product_requirements` to mark APPROVED after human review

**What Goes Here vs. Other Docs**:
- ✅ Product vision, user needs, why we're building this
- ✅ User personas and pain points
- ✅ High-level capabilities needed
- ❌ Technical architecture (→ technical_design.md)
- ❌ Technology choices (→ technology_stack.md)
- ❌ Domain model details (→ conceptual_design.md)
- ❌ Specific implementation approaches (→ features, tasks)
