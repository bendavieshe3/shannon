# Documentation Management System

## Overview

The documentation management system maintains structured, mandated documents that relate product requirements, technology stack, architecture, and implementation. By keeping documentation scoped and well-organized, information remains easy to consume and update at the right time.

A flexible knowledge base complements mandated documents by capturing research, implementation details, and other information that doesn't fit within the defined scopes. Integration with task, feature, and project management ensures documentation stays aligned with implementation.

## Core Philosophy

### Mandated Documents

**Well-Defined Scope**: Each mandated document has a specific scope that minimizes duplication while providing clear guidance on what belongs where.

**High-Level Focus**: Mandated documents contain high-level, generally applicable information. Detailed implementation specifics go in knowledge notes linked from the relevant document.

**Alignment to Activities**: Due to well-defined scopes, documents map naturally to project activities, enabling efficient AI assistance with appropriate context.

**Human Review Required**: Like tasks and features, mandated documents have DRAFT/APPROVED status with version history. DRAFT status triggers warnings when consumed by other activities.

### Knowledge Base

**Flexible Storage**: Information that doesn't fit mandated document scopes goes into the knowledge base as structured notes.

**Project-Specific Knowledge Allowed**: Unlike generic knowledge bases, this system allows project-specific knowledge that's too detailed for mandated docs but valuable for development.

**Research and Implementation Details**: Separate directories organize different knowledge types (research, implementation details, document extensions).

**Indexed for Discovery**: The knowledge index provides navigation, supplemented by type-specific indexes in parent documents.

## Mandated Documents

The following documents are required and have well-defined scopes. All are markdown files stored in `./docs/`.

### product_requirements.md

**Formerly**: prd.md or PRD
**Scope**: Product vision, high-level requirements, product pillars

**Contains**:
- Overall product vision and goals
- User personas
- High-level user stories (more granular stories in features)
- Product pillars (core principles)
- Idea stage information
- Cross-references to features implementing stories/pillars

**Does NOT contain**:
- Detailed technical decisions (→ technical_design.md)
- Specific implementation approaches (→ features, tasks)
- Technology choices (→ technology_stack.md)

**Example sections**:
```markdown
## Product Vision

[What the product aims to achieve, why it matters]

## Personas

### Primary User: Solo Developer
- Needs: [...]
- Pain points: [...]

## Product Pillars

1. **Simplicity**: [...]
2. **Traceability**: [...]

## High-Level User Stories

### Organization & Discovery
Users need to capture and find ideas effortlessly.

**Features**: FEAT-003 (Organizes User Ideas)
```

### technology_stack.md

**Scope**: Languages, frameworks, libraries, tools, and rationale

**Contains**:
- Programming languages
- Frameworks and libraries
- Development tools
- Rationale for each choice
- Alignment to project_requirements
- Known limitations or trade-offs

**Does NOT contain**:
- Specific version numbers (too volatile)
- Detailed configuration (→ development_design.md or knowledge notes)
- How to use tools (→ development_design.md or knowledge notes)

**Example sections**:
```markdown
## Languages

**Python 3.11+**
- Rationale: Rich ecosystem for AI/ML, strong typing support, team expertise
- Trade-offs: Performance vs. compiled languages

## Frameworks

**FastAPI**
- Rationale: Async support, automatic OpenAPI docs, type validation
- Alignment: Supports real-time features in project_requirements

## Libraries

**Authlib**
- Purpose: OAuth 2.0 authentication
- Rationale: Standards-compliant, actively maintained
- Related: See knowledge/implementation-details/oauth-implementation.md for details
```

### conceptual_design.md

**Scope**: Domain model, core concepts, critical business logic

**Contains**:
- Domain terminology (from project_requirements)
- Conceptual entities and relationships
- Core business rules and constraints
- Critical use case algorithms (conceptual level)
- Intermediate clarifying entities

**Does NOT contain**:
- Technical implementation (→ technical_design.md)
- Database schemas (→ technical_design.md)
- UI specifics (→ technical_design.md, ux_style_guide.md)

**Example sections**:
```markdown
## Core Concepts

### Idea
An idea is a user's captured thought, organized within collections.

**Properties** (conceptual):
- Content (text, potentially rich)
- Timestamp (creation, modification)
- Organization (belongs to collections)
- Discoverability (tags, search metadata)

**Business Rules**:
- Ideas are immutable after creation (edits create new versions)
- Ideas can belong to multiple collections
- Deleted ideas are soft-deleted for 30 days

### Collection
A collection organizes related ideas hierarchically.

**Relationships**:
- Collection → Ideas (many)
- Collection → Sub-collections (many, hierarchical)
```

### technical_design.md

**Scope**: System architecture, technical implementation strategy

**Contains**:
- System architecture (high-level components)
- Persistence approach (structured/unstructured data)
- Event system design (domain events, UI events)
- Configuration approach
- High-level UX design plan
- Major component families
- API design approach
- Integration points

**Does NOT contain**:
- Detailed implementation code (→ code, knowledge notes)
- Code examples (→ knowledge notes)
- Specific file paths (→ knowledge notes, tasks)

**Example sections**:
```markdown
## System Architecture

### Components

**API Layer** (FastAPI)
- RESTful endpoints for CRUD operations
- WebSocket endpoints for real-time updates
- See: knowledge/technical-design-extra/api-design-patterns.md

**Domain Layer**
- Business logic and domain models
- Maps to conceptual_design.md entities
- Event publishing for cross-component communication

**Persistence Layer**
- PostgreSQL for structured data (ideas, collections, users)
- Redis for caching and session management

## Configuration Approach

**Environment-based configuration**
- 12-factor app principles
- Secrets via environment variables (not committed)
- Default configs in code, overridable by env
```

### code_style_guide.md

**Scope**: Code style, linting rules, naming conventions, code comment standards

**Contains**:
- Language-specific style rules
- Naming conventions (variables, functions, classes, files)
- Code organization patterns
- Comment and docstring requirements
- General coding instructions (syntactic/semantic)
- Linting tool configurations

**Does NOT contain**:
- Architecture patterns (→ technical_design.md)
- Testing approaches (→ development_design.md)
- UX/UI style (→ ux_style_guide.md)

**Example sections**:
```markdown
## Python Style

**Follow PEP 8** with these modifications:
- Line length: 100 characters (not 79)
- Use double quotes for strings

## Naming Conventions

- **Variables**: snake_case
- **Functions**: snake_case, verb-noun (e.g., `get_user`, `create_idea`)
- **Classes**: PascalCase, noun (e.g., `IdeaRepository`, `AuthService`)
- **Constants**: UPPER_SNAKE_CASE

## Docstrings

Use Google-style docstrings:
```python
def create_idea(content: str, user_id: int) -> Idea:
    """Create a new idea for the user.

    Args:
        content: The idea content text
        user_id: The user creating the idea

    Returns:
        The created Idea instance

    Raises:
        ValueError: If content is empty
    """
```

## Code Comments

- **When**: Explain WHY, not WHAT (code shows what)
- **Complex logic**: Required for non-obvious algorithms
- **Business rules**: Reference conceptual_design.md or knowledge notes
```

### ux_style_guide.md

**Scope**: User interface style, layout patterns, visual design rules

**Contains**:
- Visual design rules (colors, typography, spacing)
- Layout patterns (header/footer, navigation, sidebars)
- Component style rules (buttons, forms, modals)
- Interaction patterns (hover states, animations)
- Accessibility requirements
- Responsive design approach

**Does NOT contain**:
- Technical implementation (→ technical_design.md)
- Code patterns (→ code_style_guide.md)
- UX flows/wireframes (→ knowledge notes or separate tool)

**Example sections**:
```markdown
## Visual Design

**Colors**
- Primary: #3B82F6 (blue-500)
- Secondary: #8B5CF6 (violet-500)
- Success: #10B981 (green-500)
- Error: #EF4444 (red-500)
- Background: #F9FAFB (gray-50)
- Text: #111827 (gray-900)

**Typography**
- Font family: Inter (sans-serif)
- Base size: 16px
- Scale: 1.25 (minor third)

**Spacing**
- Base unit: 4px
- Use multiples: 4, 8, 12, 16, 24, 32, 48, 64

## Layout Patterns

**Standard Page**
- Header: Fixed top, 64px height
- Navigation: Left sidebar, 240px width (collapsible on mobile)
- Content: Center, max-width 1280px, padding 24px
- Footer: Sticky bottom, 48px height

**Properties Panel**
- Always on right side
- 320px width
- Slide-in animation (300ms ease-out)
```

### documentation_style_guide.md

**Scope**: Documentation writing standards for user-facing docs

**Contains**:
- Writing style (tone, voice, person)
- Documentation structure patterns
- Markdown conventions
- Code example formatting
- Screenshot/diagram guidelines

**Does NOT apply to**:
- Mandated documents (this file, conceptual_design.md, etc.)
- Knowledge base notes
- Code comments/docstrings (→ code_style_guide.md)

**Applies to**:
- README.md
- User guides
- API documentation
- Tutorial/how-to content

**Example sections**:
```markdown
## Writing Style

**Tone**: Friendly but professional
**Voice**: Active voice preferred
**Person**: Second person (you/your) for user docs

**Examples**:
- ✅ "You can create ideas by clicking the + button"
- ❌ "Ideas can be created by clicking the + button" (passive)
- ❌ "The user can create ideas..." (third person)

## Structure

**Every doc includes**:
1. One-sentence summary
2. What it does / why it matters
3. How to use (step-by-step)
4. Examples
5. Troubleshooting (if applicable)

## Code Examples

**Use triple backticks with language**:
```python
# Good: Language specified, realistic example
def get_ideas(user_id: int) -> list[Idea]:
    return db.query(Idea).filter_by(user_id=user_id).all()
```

**Include context**: Show imports, explain variables
```

### development_design.md

**Scope**: Development tooling, processes, testing approaches

**Contains**:
- Version control approach (branching strategy, commit conventions)
- Testing approaches (unit, integration, E2E strategies)
- CI/CD configuration (which tools, what runs when)
- Code quality tools (linting, coverage, security scanning)
- Development environment setup
- Common development tasks and workflows
- Deployment process

**Does NOT contain**:
- Code style rules (→ code_style_guide.md)
- Architecture (→ technical_design.md)
- Specific tool usage details (→ knowledge notes)

**Example sections**:
```markdown
## Version Control

**Branching Strategy**: Trunk-based development
- Main branch: `master`
- Feature branches: Short-lived, merge within 2 days
- No long-lived development branches

**Commit Conventions**:
- Conventional Commits format
- Scope optional: `feat(auth): add OAuth support`
- Breaking changes: Include `BREAKING CHANGE:` in footer

## Testing Approach

**Test Pyramid**:
- Unit tests: 70% (fast, isolated, extensive)
- Integration tests: 20% (DB, API, services together)
- E2E tests: 10% (critical user flows only)

**Coverage Requirements**:
- Minimum: 80% overall
- New code: 90% coverage required
- Run: `pytest --cov=src --cov-report=term-missing`

**CI Pipeline** (GitHub Actions):
1. Lint (ruff, mypy)
2. Unit tests (pytest)
3. Integration tests (pytest with Docker compose)
4. Security scan (bandit)
5. Coverage report

## Development Environment

**Prerequisites**:
- Python 3.11+
- PostgreSQL 15+
- Redis 7+

**Setup**:
```bash
python -m venv venv
source venv/bin/activate
pip install -r requirements-dev.txt
cp .env.example .env  # Edit with local config
```

**Common Tasks**:
- Run tests: `pytest`
- Run server: `uvicorn src.main:app --reload`
- Format code: `ruff format .`
- Type check: `mypy src/`
```

## Mandated Document Status and Review

### Status Field

Each mandated document has a status at the top:

```markdown
# Technical Design

**Status**: DRAFT | APPROVED
**Last Reviewed**: YYYY-MM-DD
**Approved By**: [Name or "Not yet reviewed"]
```

**DRAFT Status**:
- Document has unreviewed AI-generated content
- Triggers warnings when consumed by other activities
- Use `/document-review` to interactively approve

**APPROVED Status**:
- Human has reviewed and approved content
- Safe to consume in task/feature planning
- New AI changes mark status back to DRAFT

### Version History

Each document maintains a version history at the bottom:

```markdown
## Version History

### 2025-10-06 - v1.2
- Added OAuth authentication approach
- Updated API design patterns
- Status: DRAFT (pending review)

### 2025-09-15 - v1.1
- Expanded persistence layer design
- Added caching strategy
- Status: APPROVED (2025-09-16)

### 2025-09-01 - v1.0
- Initial technical design
- Status: APPROVED (2025-09-02)
```

## Knowledge Base Structure

### Directory Organization

```
./docs/knowledge/
├── knowledge_index.md           # Master index (MOC)
├── research/                    # General research, not project-specific initially
│   ├── oauth-vs-jwt-auth.md
│   └── search-algorithms-comparison.md
├── implementation-details/      # Project-specific implementation details
│   ├── oauth-implementation.md
│   └── search-indexing-strategy.md
├── project-requirements-extra/  # Extends product_requirements.md
│   └── detailed-persona-research.md
├── technical-design-extra/      # Extends technical_design.md
│   ├── api-design-patterns.md
│   └── database-migration-strategy.md
└── conceptual-design-extra/     # Extends conceptual_design.md
    └── idea-versioning-algorithm.md
```

### Knowledge Note Structure

```markdown
# [Title]

**Type**: Research | Implementation Detail | [Document Type]-Extra
**Related To**: [Mandated doc section, feature, or task]
**Tags**: #tag1 #tag2 #FEAT-XXX #TASK-YYY (if applicable)
**Created**: YYYY-MM-DD
**Last Updated**: YYYY-MM-DD

## Topics Covered

- Topic 1
- Topic 2
- Topic 3

## Main Content

[Primary knowledge content - detailed information that doesn't fit in mandated docs]

## Local Considerations

[Environment-specific notes, differences from general sources, project-specific adaptations]

## Related Documentation

- **Mandated Doc**: technical_design.md § "Authentication"
- **Feature**: FEAT-001 (Secures User Data)
- **Tasks**: TASK-045, TASK-046

## Sources

- [URL or description]
- [Conversation date/context]
- [Local experimentation results]

## Notes

[Additional context, decisions made, lessons learned]
```

### Knowledge Index (knowledge_index.md)

```markdown
# Knowledge Index

**Last Updated**: YYYY-MM-DD
**Total Notes**: 15

## Research (5 notes)

- **oauth-vs-jwt-auth.md** - Authentication pattern comparison
  - Tags: #authentication #security
  - Created: 2025-09-15

- **search-algorithms-comparison.md** - Search algorithm evaluation
  - Tags: #search #performance
  - Created: 2025-10-01

## Implementation Details (7 notes)

- **oauth-implementation.md** - OAuth 2.0 implementation with PKCE
  - Tags: #authentication #FEAT-001
  - Related: technical_design.md § "Authentication"
  - Created: 2025-09-20

- **search-indexing-strategy.md** - Full-text search with PostgreSQL
  - Tags: #search #database #FEAT-003
  - Related: technical_design.md § "Search System"
  - Created: 2025-10-05

## Technical Design Extensions (2 notes)

- **api-design-patterns.md** - RESTful API design patterns and conventions
  - Extends: technical_design.md
  - Created: 2025-09-10

## Project Requirements Extensions (1 note)

- **detailed-persona-research.md** - Extended persona interviews and insights
  - Extends: product_requirements.md
  - Created: 2025-09-05
```

### Indexing in Parent Documents

For knowledge notes that extend mandated documents, reference them in the parent:

```markdown
# Technical Design

## Authentication

[High-level authentication approach...]

**Detailed Implementation**: See knowledge/implementation-details/oauth-implementation.md

## Search System

[High-level search approach...]

**Design Patterns**: See knowledge/technical-design-extra/search-indexing-strategy.md
```

## Templates

Shannon provides templates for all document types. During `/project-setup`, templates are deployed to appropriate locations:

### Mandated Documents (deployed to ./docs/)
- product_requirements.md, technology_stack.md, conceptual_design.md, technical_design.md
- code_style_guide.md, ux_style_guide.md, documentation_style_guide.md, development_design.md

### Working Templates (deployed to home directories for reuse)
- `./docs/tasks/TASK-XXX.md` - Task template (used by `/task-create`)
- `./docs/features/FEAT-XXX.md` - Feature template (used by `/feature-create`)
- `./docs/knowledge/knowledge_note.md` - Knowledge note template (used by `/document`)
- Index files: task_index.md, feature_index.md, knowledge_index.md

### Project Guidance
- CLAUDE.md - Deployed to project root with AI guidance

**Template Customization**: Once deployed, templates in home directories (TASK-XXX.md, FEAT-XXX.md, knowledge_note.md) can be customized per-project. For example, add a security checklist to TASK-XXX.md, and all future tasks will include it.

Templates contain:
- Section structure with descriptive comments
- Example content (removed during instantiation for mandated docs)
- Placeholder text for required fields
- Status/metadata fields

## Traceability

### Document Relationships

```
product_requirements.md (product vision, user stories)
  ↓ (aligns)
technology_stack.md (enables product vision)
  ↓ (describes)
conceptual_design.md (domain model using product terminology)
  ↓ (maps to)
technical_design.md (technical implementation of concepts)
  ↓ (consumed by)
Features (requirements from product_requirements, implementation from technical_design)
  ↓ (broken into)
Tasks (implementation from technical_design, following style guides)
  ↓ (creates)
Implementation (code, tests, docs)
```

### Integration Points

**technology_stack**:
- Must align with product_requirements (enable features)
- Can be challenged by features (suspect tech choice discovered)

**conceptual_design**:
- Uses terminology from product_requirements
- Consumed by technical_design

**technical_design**:
- Maps to conceptual_design entities
- Consumed by feature implementation sections
- Consumed by task implementation plans

**style_guides**:
- Consumed by task implementation
- Checked during task review

### Knowledge Note Links

**Tasks/Features → Knowledge**:
```markdown
# TASK-045: Implement OAuth Flow

## Implementation Notes

Research: See knowledge/research/oauth-vs-jwt-auth.md
Implementation: See knowledge/implementation-details/oauth-implementation.md
```

**Mandated Docs → Knowledge**:
```markdown
# Technical Design

## Authentication

[High-level approach]

**Details**: See knowledge/implementation-details/oauth-implementation.md
```

**Knowledge → Tasks/Features** (in knowledge note metadata):
```markdown
**Related To**: TASK-045, FEAT-001
```

## Integration with Task/Feature/Project System

### During Project Setup (`/project-setup`)

**Process**:
1. Instantiate mandated documents from templates
2. Pre-populate with available information:
   - From conversation context
   - From command arguments
   - From existing project files
3. Initialize knowledge base structure (directories, index)
4. Extract information that doesn't fit mandated doc scopes → knowledge notes
5. Mark all documents as DRAFT
6. Prompt user to run `/project-elaborate`

### During Project Elaboration (`/project-elaborate`)

**Purpose**: Progressive elaboration of mandated documents

**Process**:
1. Respect human review status (don't overwrite APPROVED without marking DRAFT)
2. Prioritize documents in order:
   - Documentation useful for current conversation
   - Documentation that unblocks immediate future work
   - Missing documentation (project_requirements → technology_stack → conceptual_design → technical_design → style guides)
3. Ask clarifying questions to expand content
4. Iterate (no document completed in one sitting)
5. Mark AI additions as DRAFT
6. Prompt user to run `/document-review` when sections are substantial

**Example**:
```bash
/project-elaborate

# AI: "I notice technical_design.md is missing the Search System section.
#      You mentioned search in the product requirements. Let's elaborate.
#
#      Questions:
#      1. What types of search do users need? (full-text, filters, facets?)
#      2. Search scope: Just idea content or also titles, tags, metadata?
#      3. Performance target: Max search response time?
#      4. Search ranking: Relevance, date, custom?"

# User provides answers...

# AI updates technical_design.md with Search System section
# AI marks status: DRAFT
# AI: "Search System section added. Run /document-review technical_design
#      when ready to approve."
```

### During Feature Planning

**`/feature-create`, `/feature-elaborate`**:
- Update product_requirements.md with minimal cross-references
- Feature links to product_requirements.md sections
- product_requirements.md lists implementing features

**Example**:
```markdown
# Product Requirements

## Organization & Discovery

Users need to capture and find ideas effortlessly.

**Features**: FEAT-003 (Organizes User Ideas)
```

**`/feature-phase-plan`**:
- Reads technical_design.md for planned implementation approach
- Outlines technical plan in feature document (drawn from technical_design)
- May trigger research if technical_design lacks needed info

**`/feature-phase-complete`**:
- Updates technical_design.md with actual implementation (if different from plan)
- Marks technical_design as DRAFT if changed
- May create knowledge notes for implementation details

### During Task Lifecycle

**`/task-ready`** (Planning):
1. Pre-reads:
   - Feature document (if linked)
   - conceptual_design.md (domain model)
   - technical_design.md (implementation approach)
   - Related knowledge notes (from feature or manual links)
2. Determines if additional research needed
3. If research needed:
   - Performs research (web, codebase analysis)
   - Creates knowledge note in research/ or implementation-details/
   - May update technical_design.md if decision made
4. Documents implementation plan in task (drawn from above sources)
5. Task references knowledge notes for detailed context

**`/task-implement`** (Implementation):
1. Pre-reads:
   - Task implementation plan
   - Related knowledge notes
   - development_design.md (testing, CI/CD process)
   - Relevant style guides (code_style_guide, ux_style_guide, documentation_style_guide)
2. Follows implementation plan
3. Updates documentation as required:
   - Code comments (per code_style_guide)
   - User docs (per documentation_style_guide)
   - Updates technical_design.md if implementation differs from plan
   - Creates knowledge notes for complex implementation details
4. Records rationales and lessons learned in task

**`/task-review`** (Completion):
1. Checks implementation against:
   - Task implementation plan
   - Style guides
   - development_design.md requirements (tests, coverage, CI)
2. Verifies documentation updated:
   - Code comments appropriate
   - User docs reflect new features
   - technical_design.md aligned with actual implementation
3. May create knowledge notes capturing lessons learned

### During Feature Alignment (`/feature-alignment`)

**Drift Detection**:
- product_requirements changed but feature didn't → Update feature or technical_design
- Implementation drifted from product_requirements → Multiple paths:

**Path 1: Requirements changed** (product direction evolved):
1. Update product_requirements.md
2. Check technology_stack.md still relevant
3. Check conceptual_design.md still aligned
4. Identify cascading changes to features
5. Create tasks to bring implementation into alignment
6. Update technical_design.md if architecture changes

**Path 2: Implementation drifted** (product_requirements unchanged):
1. Check conceptual_design.md aligns with product_requirements
2. Check features align with conceptual_design
3. Check technical_design.md aligns with features
4. Create tasks to fix drift in implementation
5. May create knowledge notes explaining why drift occurred

## Commands

### `/document [$topic]`

Document a topic by updating mandated documents and/or creating knowledge notes.

**Purpose**: Primary documentation command - handles research + documentation

**Parameters**:
- `$topic`: Topic to document (optional)
  - Topic name: "OAuth authentication", "search indexing"
  - URL: Fetch and process content
  - File path: Read and document file
  - Empty: Document recent conversation, decisions, lessons learned

**Process**:

1. **Determine Current Date**: Get current date (knowledge freshness critical)

2. **Gather Context**:
   - Read topic from: code, tasks, conversation, URL, file, system info
   - Explicit goal: Improve and guide future development work

3. **Check Existing Documentation**:
   - Read knowledge_index.md
   - Check relevant mandated documents
   - Determine if topic exists or needs creation

4. **Analyze Mandated Document Fit**:
   - For each mandated doc section, assess if topic fits scope
   - Examples:
     - Change in persistence approach → technical_design.md § "Persistence"
     - AI fails to invoke Python venv → development_design.md § "Development Environment"
     - New authentication pattern → technical_design.md § "Authentication" (high-level) + knowledge note (details)

5. **Gather Information** (if needed):
   - Web search (topic name with local context: OS, project language)
   - Fetch URL content
   - Read file
   - Review conversation history
   - Gather system info via CLI

6. **Update Mandated Documents**:
   - Add high-level, generally applicable information only
   - Reference detailed knowledge notes where appropriate
   - Mark document status as DRAFT
   - Update version history
   - Prompt user to run `/document-review` when substantial

7. **Create/Update Knowledge Notes**:
   - Detailed implementation specifics → implementation-details/
   - Research/comparison → research/
   - Extensions of mandated docs → {doc-type}-extra/
   - Follow knowledge note structure template
   - Include metadata: type, related docs/features/tasks, tags, dates

8. **Handle Conflicts** (for research):
   - Prioritize: vendor docs > corroborated sources > random blogs
   - For local knowledge: trust user/environment over general sources
   - When uncertain: record both versions noting conflict

9. **Manage File Size**:
   - Split notes exceeding 500 lines or 10 subtopics
   - Example: "MCP" → "MCP (General)", "MCP (Available Services)"

10. **Update Indexes**:
    - Add/update entry in knowledge_index.md
    - If {doc-type}-extra note, add reference in parent mandated doc
    - Update task/feature docs if they reference the topic

**Examples**:

```bash
# Document recent conversation learnings
/document
# AI: "I'll document the OAuth implementation decisions we just discussed.
#      - High-level approach → technical_design.md § Authentication
#      - PKCE flow details → knowledge/implementation-details/oauth-implementation.md
#      - Updated indexes
#      Run /document-review technical_design to approve changes."

# Research and document a topic
/document "PostgreSQL full-text search vs Elasticsearch"
# AI performs web research, creates knowledge/research/search-comparison.md
# AI may update technical_design.md if decision made

# Document URL content
/document "https://fastapi.tiangolo.com/advanced/websockets/"
# AI fetches content, creates knowledge note, may update technical_design.md

# Document specific file
/document "./src/auth/oauth.py"
# AI reads implementation, may create knowledge note explaining complex logic
# May update technical_design.md if implementation reveals new patterns
```

**Scope Guidelines**:
- **Include in mandated docs**: High-level approach, decisions, rationale, architecture
- **Include in knowledge notes**: Detailed implementation, code examples, research, troubleshooting
- **Exclude**: Temporary debugging notes, personal todos (use tasks instead)

### `/document-review [$doc_type]`

Interactively review and approve mandated document.

**Purpose**: Human-in-the-loop approval of AI-generated documentation

**Parameters**:
- `$doc_type`: Which mandated document to review
  - `project_requirements` or `pr`
  - `technology_stack` or `tech`
  - `conceptual_design` or `concept`
  - `technical_design` or `design`
  - `code_style_guide` or `code`
  - `ux_style_guide` or `ux`
  - `documentation_style_guide` or `docs`
  - `development_design` or `dev`
  - `all`: Review all DRAFT documents

**Process**:

1. **Check Status**:
   - If APPROVED: Ask if user wants to review anyway
   - If DRAFT: Proceed with review

2. **Show Recent Changes**:
   - Display version history
   - Highlight sections changed since last approval
   - Show AI-generated content clearly marked

3. **Section-by-Section Review**:
   - For each section with changes:
     - Display section content
     - Ask: Approve, Edit, Skip, or Reject?
   - **Approve**: Keep as-is
   - **Edit**: Allow user to modify (or open in editor)
   - **Skip**: Review later
   - **Reject**: Remove changes, revert to previous version

4. **Overall Assessment**:
   - Summary of approved/edited/rejected sections
   - Ask: Mark entire document as APPROVED?

5. **Update Document**:
   - If approved: Status → APPROVED
   - If partially approved: Status → DRAFT (note which sections approved)
   - Update "Last Reviewed" date
   - Update "Approved By" field
   - Add version history entry

6. **Cascade Check**:
   - If major changes approved: Suggest checking dependent docs
   - Example: project_requirements approved with changes → Suggest reviewing features for alignment

**Example**:

```bash
/document-review technical_design

# AI: "Reviewing technical_design.md (Status: DRAFT)
#
#      Recent changes (since last approval on 2025-09-15):
#      - Added § Authentication (OAuth 2.0 approach)
#      - Updated § API Design (WebSocket endpoints)
#      - Added § Search System (PostgreSQL full-text search)
#
#      Review § Authentication?
#
#      [Shows section content]
#
#      Actions: [A]pprove, [E]dit, [S]kip, [R]eject?"

# User: A

# AI: "Section approved. Review § API Design?
#      [...]"

# After all sections reviewed:

# AI: "Review complete:
#      - Approved: 3 sections
#      - Edited: 0 sections
#      - Skipped: 0 sections
#      - Rejected: 0 sections
#
#      Mark entire document as APPROVED? [y/n]"

# User: y

# AI: "technical_design.md marked APPROVED.
#      Last Reviewed: 2025-10-06
#      Approved By: User
#
#      Note: product_requirements.md references this document.
#      Consider reviewing for alignment if needed."
```

### `/document-lookup [$topic]`

Search across mandated documents and knowledge base for topic.

**Purpose**: Quick discovery of existing documentation

**Parameters**:
- `$topic`: Topic to search for

**Process**:

1. **Search Mandated Documents**:
   - Grep for topic across all mandated docs
   - Show matching sections with context
   - Rank by relevance (exact match > section header > body text)

2. **Search Knowledge Index**:
   - Check knowledge_index.md for topic
   - Find related knowledge notes

3. **Search Knowledge Notes**:
   - Grep across knowledge/ directory
   - Show matching notes with topics covered

4. **Show Related Items**:
   - Features tagged with topic
   - Tasks tagged with topic
   - Related knowledge notes (via tags)

5. **Present Results**:
   - Grouped by source (mandated docs, knowledge notes, features, tasks)
   - Show file:line references for easy navigation
   - Highlight key excerpts

**Example**:

```bash
/document-lookup "authentication"

# Results:
#
# Mandated Documents (3 matches):
#
# 1. product_requirements.md:42
#    § User Authentication
#    "Users need secure authentication to protect their data..."
#
# 2. technology_stack.md:78
#    § Libraries > Authlib
#    "OAuth 2.0 authentication library..."
#
# 3. technical_design.md:156
#    § Authentication
#    "OAuth 2.0 with PKCE flow for security..."
#    See: knowledge/implementation-details/oauth-implementation.md
#
# Knowledge Notes (2 matches):
#
# 4. knowledge/research/oauth-vs-jwt-auth.md
#    Topics: OAuth 2.0, JWT, authentication patterns
#    Created: 2025-09-15
#
# 5. knowledge/implementation-details/oauth-implementation.md
#    Topics: OAuth 2.0, PKCE, token refresh, error handling
#    Related: FEAT-001, TASK-045, TASK-046
#    Created: 2025-09-20
#
# Features (1 match):
#
# 6. FEAT-001: Secures User Data
#    Phase 2: OAuth Integration (active)
#
# Tasks (2 matches):
#
# 7. TASK-045: Implement OAuth flow [COMPLETED]
# 8. TASK-046: Add OAuth error handling [IN PROGRESS]
```

**Note**: Can be implemented as simple command wrapper around grep + file reads, or as agent-based search for more sophisticated ranking.

## Workflow Examples

### Example 1: New Project Setup

```bash
# Initialize project with documentation structure
/project-setup "IdeaFlow - Personal knowledge management app"

# AI:
# - Creates mandated documents from templates
# - Pre-populates product_requirements.md with "knowledge management" context
# - Initializes knowledge base structure
# - All docs marked DRAFT
#
# Created:
# - ./docs/product_requirements.md (DRAFT)
# - ./docs/technology_stack.md (DRAFT)
# - ./docs/conceptual_design.md (DRAFT)
# - ./docs/technical_design.md (DRAFT)
# - ./docs/code_style_guide.md (DRAFT)
# - ./docs/ux_style_guide.md (DRAFT)
# - ./docs/documentation_style_guide.md (DRAFT)
# - ./docs/development_design.md (DRAFT)
# - ./docs/knowledge/ (structure initialized)
#
# Next: Run /project-elaborate to expand documentation

# Progressive elaboration
/project-elaborate

# AI: "Let's start with product_requirements.md.
#
#      What are the core user needs for IdeaFlow?"

# User describes needs...

# AI updates product_requirements.md with product vision, personas, user stories
# AI: "Great! Let's move to technology_stack.md.
#
#      What's your preferred backend language?"

# User: "Python with FastAPI"

# AI updates technology_stack.md
# AI: "Now let's sketch the conceptual_design.md.
#
#      What are the core concepts in your domain model?"

# User: "Ideas and Collections"

# AI updates conceptual_design.md with entities
# AI: "Excellent progress! Remaining docs can be elaborated as needed.
#
#      Run /document-review project_requirements when ready to approve."

# Review and approve
/document-review project_requirements

# AI walks through sections, user approves
# Status: DRAFT → APPROVED
```

### Example 2: Feature Phase Planning with Documentation

```bash
# Plan Phase 1 for authentication feature
/feature-phase-plan FEAT-001 1

# AI pre-reads:
# - product_requirements.md § User Authentication
# - conceptual_design.md (no auth concepts yet)
# - technical_design.md (no auth section yet)
#
# AI: "I need to research authentication approaches for Phase 1 planning.
#      Running /document 'OAuth 2.0 vs JWT authentication'..."

# AI performs web research
# AI creates knowledge/research/oauth-vs-jwt-auth.md
#
# AI: "Based on research, I recommend OAuth 2.0 for your use case.
#
#      Questions:
#      1. Social login providers? (Google, GitHub, etc.)
#      2. Session management approach?
#      3. Token refresh strategy?"

# User answers questions...

# AI updates:
# - technology_stack.md: Adds Authlib library with rationale
# - technical_design.md: Adds § Authentication with OAuth 2.0 approach
# - Both marked DRAFT
#
# AI creates Phase 1 tasks:
# - TASK-045: Implement OAuth flow
# - TASK-046: Add OAuth error handling
# - TASK-047: Create user session management
# - [...]
#
# AI: "Phase 1 planned. Documents updated (DRAFT).
#      Run /document-review to approve changes before starting phase."

# Review technical design changes
/document-review technical_design

# User approves § Authentication section
# Status remains DRAFT (other sections not reviewed)
```

### Example 3: Task Implementation with Documentation

```bash
# Prepare task for implementation
/task-ready TASK-045

# AI pre-reads:
# - FEAT-001 feature document
# - conceptual_design.md (domain model)
# - technical_design.md § Authentication
# - knowledge/research/oauth-vs-jwt-auth.md
#
# AI: "I need implementation details for OAuth with PKCE.
#      Researching best practices..."

# AI researches, creates knowledge/implementation-details/oauth-implementation.md
# AI builds implementation plan in task (referencing knowledge notes)
# Task: TODO → READY

# Implement task
/task-implement TASK-045

# AI pre-reads:
# - Task implementation plan
# - knowledge/implementation-details/oauth-implementation.md
# - development_design.md (testing requirements)
# - code_style_guide.md
#
# AI implements OAuth flow following code_style_guide
# AI writes tests (per development_design.md requirements)
# AI adds docstrings (per code_style_guide.md)
#
# During implementation, AI discovers token refresh complexity
# AI: "Token refresh logic is complex. Documenting details..."
# AI updates knowledge/implementation-details/oauth-implementation.md
# AI references in code comments

/task-implement TASK-045 --complete

# Task: IN PROGRESS → REVIEW

# Review task
/task-review TASK-045

# AI checks:
# - Code follows code_style_guide ✅
# - Tests written and passing (per development_design.md) ✅
# - Docstrings present ✅
# - OAuth implementation matches technical_design.md ✅
# - Knowledge notes updated with lessons learned ✅
#
# AI: "Implementation looks good. Minor note: Consider documenting
#      the token refresh error handling pattern for future tasks.
#
#      Approve? [y/n]"

# User: y

/task-review TASK-045 --approve

# Task: REVIEW → COMPLETED (archived)
```

### Example 4: Documenting Recent Work

```bash
# After completing several OAuth tasks, document lessons learned
/document

# AI analyzes recent conversation and completed tasks
# AI: "I'll document the OAuth implementation learnings:
#
#      From conversation and TASK-045, TASK-046, TASK-047:
#      - OAuth token refresh strategy (technical decision)
#      - Error handling patterns discovered
#      - PKCE flow security considerations
#
#      Updating:
#      - technical_design.md § Authentication (token refresh approach)
#      - knowledge/implementation-details/oauth-implementation.md (error patterns)
#
#      [Updates documents]
#
#      Summary:
#      - technical_design.md updated (marked DRAFT)
#      - oauth-implementation.md updated with error handling section
#      - knowledge_index.md updated
#
#      Run /document-review technical_design to approve changes."
```

### Example 5: Feature Alignment with Documentation Drift

```bash
# Check alignment after implementing Phase 2
/feature-alignment FEAT-001

# AI detects drift:
# - technical_design.md § Authentication mentions "JWT for API tokens"
# - Implementation actually uses "OAuth access tokens" (no separate JWT)
# - product_requirements.md unchanged
#
# AI: "Drift detected between technical_design.md and implementation.
#
#      technical_design.md says: 'JWT tokens for API access'
#      Actual implementation: OAuth access tokens (no JWT)
#
#      Options:
#      1. Update technical_design.md to match implementation (implementation is correct)
#      2. Update implementation to match technical_design.md (JWT tokens were intended)
#      3. Mark as acceptable drift (both approaches valid)
#
#      Which option? [1/2/3]"

# User: 1

# AI updates technical_design.md § Authentication
# AI marks technical_design.md as DRAFT
# AI adds version history entry explaining drift correction
#
# AI: "technical_design.md updated to match implementation.
#      Run /document-review technical_design to approve changes."
```

## Best Practices

### Mandated Documents

1. **High-level only** - Detailed implementation goes in knowledge notes
2. **Link to knowledge** - Reference notes for details instead of bloating docs
3. **Keep scopes clear** - If unsure where info goes, use `/document` to decide
4. **Review regularly** - Run `/document-review` after significant changes
5. **Version history** - Always update when making changes
6. **Status discipline** - DRAFT for unreviewed, APPROVED only after human review

### Knowledge Base

1. **Specific and focused** - One note per topic, split if >500 lines
2. **Rich metadata** - Always include tags, related docs, dates
3. **Link bidirectionally** - Mandated docs → knowledge, knowledge → tasks/features
4. **Update existing notes** - Don't create duplicates
5. **Index maintenance** - Keep knowledge_index.md current

### Documentation Workflow

1. **Document as you go** - Don't wait until end of phase
2. **Use `/document` liberally** - After decisions, after task completion, after learning
3. **Pre-read before implementing** - Tasks should reference relevant docs
4. **Review after completion** - `/task-review` checks docs updated
5. **Trust the warnings** - DRAFT status warnings mean "review this"

## Troubleshooting

**"Where should this information go?"**

Use `/document $topic` - AI will analyze and suggest correct location.

**"Mandated doc is too long"**

Move detailed implementation to knowledge notes, keep only high-level approach in mandated doc.

**"Can't find documentation for topic"**

```bash
/document-lookup "topic"
# Searches mandated docs + knowledge base
```

**"Documentation out of sync with implementation"**

Run `/feature-alignment FEAT-XXX` to detect and fix drift. Or use `/document` to update based on current implementation.

**"Forgot to update docs during task"**

`/task-review` will catch missing documentation updates. Or run `/document` after task completion to capture lessons learned.

**"Too many DRAFT documents"**

Run `/document-review all` to batch-review all DRAFT docs. Approve sections that are stable, defer detailed review of others.

**"Knowledge base is growing too large"**

- Split large notes (>500 lines) into subtopics
- Archive outdated research (create archive/ directory)
- Remove duplicate information (consolidate similar notes)

**"Not sure if I need to update documentation"**

Ask:
- Does this change affect how future work should be done? → Yes, document
- Is this a one-time fix or a pattern to reuse? → Pattern, document
- Will I forget this decision in 2 weeks? → Probably, document

## Integration Summary

The documentation system integrates seamlessly with task/feature/project management:

- **/project-setup**: Instantiates mandated docs, initializes knowledge base
- **/project-elaborate**: Progressively expands mandated docs
- **/feature-create**, **/feature-elaborate**: Updates product_requirements.md
- **/feature-phase-plan**: Reads technical_design.md, may create knowledge notes
- **/feature-phase-complete**: Updates technical_design.md with actual implementation
- **/feature-alignment**: Detects drift between docs and implementation
- **/task-ready**: Pre-reads docs and knowledge, may research and document
- **/task-implement**: Follows docs, updates as needed during implementation
- **/task-review**: Verifies documentation updated correctly
- **/document**: Primary command for updating docs and knowledge base
- **/document-review**: Human approval of AI-generated documentation
- **/document-lookup**: Search across all documentation

**Result**: Documentation stays aligned with product vision, architecture, and implementation throughout the entire development lifecycle.
