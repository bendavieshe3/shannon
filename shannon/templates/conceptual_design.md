# Conceptual Design

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD or "Not yet reviewed"]
**Approved By**: [Name or "Not yet reviewed"]

---

**Project Name**: [Name of the product]

## Overview

<!--
Brief summary of the domain model and core business concepts.
1-2 paragraphs explaining what this document covers.
-->

[Describe the conceptual domain model: the key entities, their relationships, and core business logic at a conceptual level]

**Example**:
> This document defines the domain model for IdeaFlow, describing the core concepts of Ideas, Collections, and Tags from a business perspective. It focuses on "what things are" and "how they relate," not on technical implementation details like database schemas or API endpoints.

---

## Domain Terminology

<!--
OPTIONAL: Define key terms used throughout the project.
Especially useful if domain has specialized vocabulary.
Remove if not needed.
-->

- **[Term]**: [Definition from business perspective]
- **[Term]**: [Definition from business perspective]

**Example**:
> - **Idea**: A captured thought, insight, or note from a user
> - **Collection**: A user-created grouping of related ideas (hierarchical)
> - **Tag**: A keyword or label that can be applied to ideas for cross-cutting organization
> - **Link**: A connection between two ideas showing relationship

---

## Core Concepts

<!--
The main entities/concepts in the domain model.
Each concept should have:
- Description of what it is
- Conceptual properties (not database columns)
- Business rules and constraints
- Relationships to other concepts
-->

### [Concept Name]

[1-2 sentence description of what this concept represents]

**Conceptual Properties**:
- **[Property]**: [Description - what it represents, not data type]
- **[Property]**: [Description]
- **[Property]**: [Description]

**Business Rules**:
- [Rule 1: e.g., "Ideas are immutable after creation (edits create new versions)"]
- [Rule 2: e.g., "Ideas can belong to multiple collections"]
- [Rule 3: e.g., "Deleted ideas are soft-deleted for 30 days"]

**Relationships**:
- [Relationship to other concept, e.g., "Belongs to one or more Collections"]
- [Relationship to other concept]

**Example**:
> ### Idea
>
> An idea is a user's captured thought, organized within collections and discoverable through tags and search.
>
> **Conceptual Properties**:
> - **Content**: The text of the idea (potentially rich text/markdown)
> - **Timestamps**: When created and last modified
> - **Organization**: Collections it belongs to
> - **Discoverability**: Tags and search metadata
> - **Relationships**: Links to other related ideas
>
> **Business Rules**:
> - Ideas are immutable after creation (edits create new versions)
> - Ideas can belong to multiple collections simultaneously
> - Deleted ideas are soft-deleted for 30 days (recoverable)
> - Ideas must have content (cannot be empty)
>
> **Relationships**:
> - Belongs to zero or more **Collections**
> - Has zero or more **Tags**
> - Links to zero or more other **Ideas**
> - Created by one **User**

### [Another Concept]

[Description]

**Conceptual Properties**:
- **[Property]**: [Description]

**Business Rules**:
- [Rule]

**Relationships**:
- [Relationship]

---

## Concept Relationships

<!--
Visual or textual representation of how concepts relate.
Helps see the big picture.
-->

```
[Concept A]
    ↓ (relationship description)
[Concept B]
    ↓ (relationship description)
[Concept C]
```

**Example**:
> ```
> User
>     ↓ (creates and owns)
> Ideas
>     ↓ (organized into)
> Collections
>     ↓ (can contain)
> Sub-Collections (hierarchical)
>
> Ideas
>     ↓ (tagged with)
> Tags (many-to-many)
>
> Ideas
>     ↓ (linked to)
> Other Ideas (many-to-many)
> ```

---

## Critical Business Logic

<!--
Key algorithms or business processes at a conceptual level.
Focus on "what" not "how".
Detailed implementation goes in knowledge notes.
-->

### [Business Process/Algorithm Name]

**Purpose**: [What this process achieves]

**Conceptual Flow**:
1. [Step 1 - conceptual description]
2. [Step 2 - conceptual description]
3. [Step 3 - conceptual description]

**Business Rules Applied**:
- [Rule from above concepts]
- [Rule from above concepts]

**Edge Cases**:
- [Edge case and how it's handled conceptually]

**Example**:
> ### Idea Versioning
>
> **Purpose**: Preserve edit history while maintaining idea immutability
>
> **Conceptual Flow**:
> 1. User edits an existing idea
> 2. System creates new version with updated content
> 3. New version becomes "current" version
> 4. Old version remains in history (accessible but not primary)
> 5. Relationships (collections, tags, links) transfer to new version
>
> **Business Rules Applied**:
> - Ideas are immutable (original never modified)
> - Ideas maintain identity across versions (same ID)
>
> **Edge Cases**:
> - If idea deleted before edit: Treat as new idea creation
> - If concurrent edits: Last write wins, first edit becomes history

---

## Constraints & Invariants

<!--
OPTIONAL: System-wide constraints that must always be true.
Remove if not needed.
-->

- [Invariant 1: e.g., "Every idea must have at least one owner"]
- [Invariant 2: e.g., "Collection hierarchies cannot form cycles"]
- [Invariant 3: e.g., "Tag names are case-insensitive and unique per user"]

**Example**:
> - Every idea must belong to at least one collection (inbox is default)
> - Collection hierarchies cannot form cycles (directed acyclic graph)
> - Tag names are case-insensitive and unique per user
> - Soft-deleted items are permanently deleted after 30 days

---

## Clarifying Entities

<!--
OPTIONAL: Intermediate entities that clarify relationships.
These often emerge during design to resolve many-to-many relationships
or to capture additional data about relationships.
-->

### [Entity Name]

**Purpose**: [Why this entity exists]

**Properties**:
- [Property 1]
- [Property 2]

**Example**:
> ### Idea-Collection Membership
>
> **Purpose**: Captures when an idea was added to a collection and by whom (resolves many-to-many)
>
> **Properties**:
> - Idea reference
> - Collection reference
> - Date added
> - Added by (user)
> - Pinned (boolean - is this idea pinned in this collection?)

---

## Evolution Notes

<!--
OPTIONAL: Track how the domain model has evolved.
Useful for understanding past decisions.
-->

**Changes from v1.0**:
- [What changed and why]

**Example**:
> **Changes from v1.0**:
> - Added "Link" concept (v1.1) - users requested explicit relationships between ideas
> - Removed "Notebook" concept (v1.2) - merged with Collections for simpler model
> - Added "Pin" property to Idea-Collection Membership (v1.3) - support prioritization

---

## Version History

<!--
Track significant changes to the conceptual design.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial conceptual design created
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.2
> - Added Link concept for idea relationships
> - Refined Collection hierarchy rules
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial conceptual design created
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
- Stay **conceptual** - avoid technical implementation details
- Use **terminology from product_requirements.md** (personas, user stories)
- Focus on **business rules** and **relationships**
- Describe **what** things are, not **how** they're implemented
- Link to **knowledge notes** for detailed algorithms
- **Properties are conceptual** (not database columns or API fields)

**What Goes Here vs. Other Docs**:
- ✅ Domain concepts, entities, relationships
- ✅ Business rules and constraints
- ✅ Conceptual properties (what they represent)
- ✅ Critical business logic (conceptual level)
- ❌ Database schemas (→ technical_design.md)
- ❌ API endpoints (→ technical_design.md)
- ❌ UI components (→ technical_design.md, ux_style_guide.md)
- ❌ Detailed algorithms (→ knowledge notes)
