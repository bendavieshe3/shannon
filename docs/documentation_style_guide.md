# Documentation Style Guide

**Status**: DRAFT
**Last Reviewed**: 2025-11-09

---

**Project Name**: Shannon

## Overview

<!--
Brief summary of documentation writing standards.
This guide applies to USER-FACING documentation only.
-->

[Describe the documentation philosophy and who this guide is for]

**Example**:
> This guide defines writing standards for user-facing documentation including README files, user guides, API documentation, and tutorials. It does NOT apply to mandated documents (like technical_design.md) or knowledge base notes, which have their own formats.
>
> Our documentation aims to be clear, concise, and action-oriented, helping users accomplish tasks quickly without unnecessary complexity.

---

## Scope

### This Guide Applies To:
- [Document type 1]
- [Document type 2]
- [Document type 3]

### This Guide Does NOT Apply To:
- [Document type 1]
- [Document type 2]

**Example**:
> ### This Guide Applies To:
> - README.md files
> - User guides and tutorials
> - API documentation
> - How-to articles
> - Troubleshooting guides
> - Release notes
>
> ### This Guide Does NOT Apply To:
> - Mandated documents (product_requirements.md, technical_design.md, etc.)
> - Knowledge base notes
> - Code comments and docstrings (see code_style_guide.md)
> - Internal technical documentation

---

## Writing Style

### Voice & Tone

**Voice**: [Consistent personality characteristics]

**Tone**: [How tone varies by context]

**Example**:
> **Voice**: Friendly but professional, like a helpful colleague
>
> **Tone**:
> - **Tutorials**: Encouraging and supportive ("Great! Now let's...")
> - **Reference Docs**: Neutral and precise
> - **Error Messages**: Apologetic and solution-focused
> - **Release Notes**: Excited for features, matter-of-fact for fixes

### Person & Perspective

**Use**: [Which person to write in]

**Avoid**: [Which person to avoid]

**Example**:
> **Use**: Second person ("you/your") for user-facing docs
> - ✅ "You can create ideas by clicking..."
> - ✅ "Your data is stored locally..."
>
> **Avoid**:
> - ❌ Third person: "The user can create ideas..." (too formal)
> - ❌ First person plural: "We can create ideas..." (ambiguous)
> - ❌ Passive voice: "Ideas can be created..." (unclear who does it)

### Active vs. Passive Voice

**Preference**: [Which to use]

**Example**:
> **Preference**: Active voice (subject performs action)
>
> - ✅ Active: "Click the button to save your work"
> - ❌ Passive: "The button can be clicked to save your work"
> - ✅ Active: "The system deletes ideas after 30 days"
> - ❌ Passive: "Ideas are deleted after 30 days"
>
> **Exception**: Use passive when the actor is unknown or unimportant
> - ✅ "Your data is encrypted at rest" (who encrypts doesn't matter)

### Sentence Structure

**Guidelines**:
- [Guideline 1]
- [Guideline 2]
- [Guideline 3]

**Example**:
> - **Short sentences**: Aim for 15-20 words per sentence
> - **One idea per sentence**: Don't cram multiple concepts together
> - **Simple words**: Use "use" not "utilize", "help" not "facilitate"
> - **Concrete nouns**: Avoid abstract language
> - **Action verbs**: "Click", "Create", "Delete" (not "perform", "execute")

---

## Document Structure

### Every Document Should Include:

1. **[Section]**: [Purpose]
2. **[Section]**: [Purpose]
3. **[Section]**: [Purpose]

**Example**:
> 1. **One-line summary**: What this doc is about (first sentence)
> 2. **Purpose**: What the reader will learn or be able to do
> 3. **Prerequisites** (if any): What readers need before starting
> 4. **Main Content**: Step-by-step or reference material
> 5. **Examples**: Concrete examples demonstrating concepts
> 6. **Troubleshooting** (if applicable): Common problems and solutions
> 7. **Related Docs**: Links to related documentation

### Headings

**Hierarchy**: [How to use heading levels]

**Style**: [Heading formatting rules]

**Example**:
> **Hierarchy**:
> - H1: Document title (one per page)
> - H2: Major sections
> - H3: Subsections
> - H4: Rare, use only if truly necessary
>
> **Style**:
> - Use sentence case: "Getting started with ideas" (not "Getting Started With Ideas")
> - Be descriptive: "Create your first idea" (not "Next steps")
> - Front-load keywords: "Ideas: Create and organize" (not "Create and organize ideas")
> - Action-oriented for how-tos: "Install the app" (not "Installation")

---

## Code Examples

### Format

**Language Specification**: [Rule]

**Context**: [What to include]

**Example**:
> **Language Specification**: Always specify language in code blocks
>
> ````markdown
> ```python
> def create_idea(content: str) -> Idea:
>     return Idea(content=content)
> ```
> ````
>
> **Context**: Include enough context to be runnable
> - ✅ Show imports if needed
> - ✅ Show variable declarations
> - ✅ Use realistic values
> - ❌ Don't use `foo`, `bar` - use domain terms like `idea`, `collection`

### Explanation

**Approach**: [How to explain code]

**Example**:
> **Approach**: Explain before or after the code block, not in comments
>
> ✅ **Good**:
> > To create an idea, call `create_idea()` with the content:
> > ```python
> > idea = create_idea("Build a time machine")
> > ```
>
> ❌ **Bad**:
> > ```python
> > # Create an idea
> > idea = create_idea("Build a time machine")
> > ```
>
> **Exception**: Comments are OK for multi-step examples to separate sections

### Complete vs. Partial Examples

**When to Show Complete Code**: [Guideline]

**When Partial is OK**: [Guideline]

**Example**:
> **When to Show Complete Code**:
> - First example in a tutorial
> - Examples meant to be copy-pasted
> - Complex multi-step operations
>
> **When Partial is OK**:
> - Showing specific syntax or patterns
> - Reference documentation
> - Demonstrating variations ("You can also...")
>
> **Indicate Partial**: Use `...` or `# ...` to show omitted code
> ```python
> class IdeaRepository:
>     def __init__(self, db: Database):
>         ...  # Other initialization
>
>     def create(self, idea: Idea) -> Idea:
>         return self.db.save(idea)
> ```

---

## Formatting Conventions

### Text Formatting

| Element | Format | Example |
|---------|--------|---------|
| [Element] | [How to format] | [Example] |

**Example**:
> | Element | Format | Example |
> |---------|--------|---------|
> | Code (inline) | Backticks | Use `create_idea()` to create |
> | File paths | Backticks | Edit `config/settings.py` |
> | UI elements | Bold | Click **Save** button |
> | Key presses | Backticks + kbd | Press `Ctrl+S` to save |
> | Menu paths | Bold with → | Go to **File → Save As** |
> | Emphasis | Italic | This is *important* |
> | Strong emphasis | Bold | This is **critical** |
> | Commands | Code block | See below |

### Lists

**Numbered Lists**: [When to use]

**Bulleted Lists**: [When to use]

**Example**:
> **Numbered Lists**: Use for sequences, steps, or ordered items
> 1. First, install the app
> 2. Next, create an account
> 3. Finally, create your first idea
>
> **Bulleted Lists**: Use for unordered items
> - Fast search
> - Flexible organization
> - Local-first storage
>
> **Formatting**:
> - Capitalize first word
> - Use periods if items are complete sentences
> - No periods for fragments
> - Parallel structure (all verbs, all nouns, etc.)

### Links

**Style**: [How to format links]

**Example**:
> **Style**: Descriptive link text (not "click here")
>
> - ✅ "See the [API documentation](./api.md) for details"
> - ❌ "Click [here](./api.md) for API docs"
>
> **Types**:
> - External: Include full URL in markdown links
> - Internal: Use relative paths (`./docs/api.md`)
> - Anchors: Link to sections (`./api.md#authentication`)

### Tables

**When to Use**: [Guideline]

**Format**: [How to format]

**Example**:
> **When to Use**: For structured reference information (not long prose)
>
> **Format**:
> - Left-align text columns
> - Right-align number columns
> - Keep cell content short (use bullet points if needed)
> - Include header row
>
> | Endpoint | Method | Description |
> |----------|--------|-------------|
> | `/ideas` | GET | List all ideas |
> | `/ideas` | POST | Create new idea |
> | `/ideas/{id}` | DELETE | Delete idea |

---

## Special Elements

### Admonitions / Callouts

**Types**:
- **[Type]**: [When to use]

**Format**: [How to format them]

**Example**:
> **Types**:
> - **Note**: Additional information (not critical)
> - **Tip**: Helpful suggestions
> - **Warning**: Important caveats (could cause problems)
> - **Caution**: Potential data loss or security issues
>
> **Format**:
> ```markdown
> **Note**: Ideas are automatically saved to your inbox collection.
>
> **Warning**: Deleting a collection does not delete its ideas.
> ```

### Screenshots & Diagrams

**When to Include**: [Guideline]

**Format**: [Technical requirements]

**Example**:
> **When to Include**:
> - Complex UI workflows (show don't tell)
> - Architecture overviews
> - Visual concepts hard to describe in text
>
> **Format**:
> - PNG for screenshots (reduce size with ImageOptim)
> - SVG for diagrams (editable, scales well)
> - Alt text for accessibility
> - Caption below: `Figure 1: Creating a new idea`
> - Store in `./docs/images/` directory
>
> **Example**:
> ```markdown
> ![Creating a new idea](./images/create-idea.png)
> *Figure 1: The idea creation dialog*
> ```

### API Documentation

**Format**: [How to document APIs]

**Example**:
> **Format**: Consistent structure for each endpoint
>
> ```markdown
> ### POST /ideas
>
> Create a new idea.
>
> **Request Body**:
> ```json
> {
>   "content": "string (required)",
>   "tags": ["string"] (optional)
> }
> ```
>
> **Response** (201 Created):
> ```json
> {
>   "id": 123,
>   "content": "Build a time machine",
>   "tags": ["project"],
>   "created_at": "2025-10-21T10:30:00Z"
> }
> ```
>
> **Errors**:
> - `400`: Invalid request body
> - `401`: Unauthorized
> ```

---

## Examples

### Tutorial Example

**Structure**:
1. [Section]
2. [Section]

**Example**:
> **Structure**:
> 1. **Introduction**: What you'll build/learn
> 2. **Prerequisites**: What you need
> 3. **Step-by-step instructions**: Numbered, with code examples
> 4. **Expected outcome**: What success looks like
> 5. **Next steps**: Where to go from here
>
> **Sample**:
> ```markdown
> # Getting Started with Ideas
>
> Learn how to create and organize your first ideas in under 5 minutes.
>
> ## Prerequisites
> - IdeaFlow installed
> - Account created (see [Installation Guide](./install.md))
>
> ## Create Your First Idea
>
> 1. Click the **New Idea** button in the top-right corner
> 2. Type your idea: "Build a time machine"
> 3. Press `Ctrl+Enter` to save
>
> You should see your idea appear in the Inbox collection.
>
> ## Next Steps
> - Learn about [Collections](./collections.md)
> - Explore [Tags](./tags.md)
> ```

### Reference Example

**Structure**: [How to organize reference docs]

**Example**:
> **Structure**: Alphabetical or logical grouping
>
> ```markdown
> # API Reference
>
> ## Authentication
>
> All API requests require authentication via bearer token.
>
> ```
> Authorization: Bearer YOUR_TOKEN
> ```
>
> ## Endpoints
>
> ### Ideas
>
> - `GET /ideas` - List ideas
> - `POST /ideas` - Create idea
> - `GET /ideas/{id}` - Get idea
> - ...
> ```

---

## Common Pitfalls

### Avoid:
- [Pitfall 1]
- [Pitfall 2]

**Example**:
> - **Jargon without explanation**: Define technical terms on first use
> - **Assuming knowledge**: State prerequisites explicitly
> - **Vague words**: "Simply", "just", "easy" (what's easy for you might not be for others)
> - **Future tense**: "You will click..." → "Click..." (use imperative)
> - **Question headings**: "How do I create an idea?" → "Create an idea"
> - **Outdated examples**: Keep examples current with latest version
> - **Missing error cases**: Show what success AND failure look like

---

## Version History

<!--
Track significant changes to the documentation style guide.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial documentation style guide created
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.1
> - Added API documentation format
> - Updated code example guidelines
> - Added admonition types
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial documentation style guide created
> - Status: APPROVED (2025-10-07)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Set Status to DRAFT
5. Update "Last Reviewed" to current date

**Key Reminders**:
- This guide is for **USER-FACING docs** only
- Be **prescriptive** with examples
- Show **good and bad** examples
- Keep it **current** as documentation evolves
- Link to **external style guides** where relevant (e.g., Microsoft Manual of Style)

**What Goes Here vs. Other Docs**:
- ✅ User documentation writing standards
- ✅ Tone, voice, formatting for user-facing content
- ✅ Code example formatting (in docs)
- ✅ Tutorial and reference structures
- ❌ Code comment standards (→ code_style_guide.md)
- ❌ Internal technical doc formats (those have their own standards)
- ❌ Markdown technical details (assume basic markdown knowledge)
