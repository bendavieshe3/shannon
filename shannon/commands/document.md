# /document

Create or update knowledge notes in the knowledge base.

## Usage

```
/document [note-type]
```

Note types: `research`, `implementation`, `extension`

## What it does

1. **Determine note type** (if not specified):
   - **research**: General technology comparison or evaluation (not project-specific yet)
   - **implementation**: Project-specific technical implementation details
   - **extension**: Elaboration of a mandated document section

2. **Gather note information**:
   - Note name (kebab-case, e.g., "oauth-vs-jwt-auth")
   - Topic/description
   - If extension: Which mandated doc and section does this extend?
   - If implementation: Related feature/task?

3. **Create knowledge note** from template:
   - Copy ./docs/knowledge/knowledge_note.md (deployed template)
   - Save to appropriate directory:
     * `./docs/knowledge/research/[name].md` (research)
     * `./docs/knowledge/implementation-details/[name].md` (implementation)
     * `./docs/knowledge/[doc-name]-extra/[name].md` (extension)

4. **Fill in metadata**:
   - Type: Research | Implementation Detail | [Doc]-Extra
   - Related To: [mandated doc section, feature, or task]
   - Tags: #tag1 #tag2 #FEAT-XXX #TASK-YYY
   - Created and Last Updated dates

5. **Gather content** based on type:

   **Research note**:
   - Topics covered
   - Comparison/evaluation of options
   - Findings and recommendation
   - Sources

   **Implementation note**:
   - Implementation approach
   - Code patterns and examples
   - Gotchas and solutions
   - Local considerations

   **Extension note**:
   - Detailed elaboration of mandated doc section
   - Information that doesn't fit in high-level doc
   - References back to mandated doc

6. **Update knowledge index**:
   - Add to ./docs/knowledge/knowledge_index.md in appropriate section:
     ```
     - **[name].md** - [One-line description]
     ```
     (For extensions, include "Extends: [doc] § [Section]")

7. **Update related documents**:
   - If extension, add reference in mandated doc:
     ```
     See: knowledge/[doc]-extra/[name].md
     ```
   - If related to feature/task, add to "Related Documentation" section

8. **Confirm creation**:
   - Show note location
   - Show cross-references added
   - Note is now available for AI to read during planning/implementation

## Example - Research Note

```
/document research
```

Prompts for:
- Name: "oauth-vs-jwt-auth"
- Description: "Authentication pattern comparison for SPAs"
- Topics: OAuth 2.0 vs JWT, security, token storage
- Creates: `./docs/knowledge/research/oauth-vs-jwt-auth.md`
- Adds to knowledge_index.md under "Research"

## Example - Implementation Note

```
/document implementation
```

Prompts for:
- Name: "oauth-implementation"
- Description: "OAuth 2.0 + PKCE implementation with token refresh"
- Related: FEAT-001, technical_design.md § "Authentication"
- Creates: `./docs/knowledge/implementation-details/oauth-implementation.md`
- Adds to knowledge_index.md under "Implementation Details"
- Adds reference in technical_design.md

## Example - Extension Note

```
/document extension
```

Prompts for:
- Name: "api-design-patterns"
- Extends: technical_design.md § "API Design"
- Description: "RESTful API design patterns and error handling"
- Creates: `./docs/knowledge/technical-design-extra/api-design-patterns.md`
- Adds to knowledge_index.md under "Technical Design Extensions"
- Adds reference in technical_design.md

## Notes

- Knowledge notes provide detailed information that doesn't fit in mandated docs
- Research notes help with decision-making during planning
- Implementation notes capture "how we actually did it"
- Extension notes elaborate mandated doc sections without bloating them
- AI reads these notes during `/task-ready` and `/feature-phase-plan`
- Bidirectional linking: notes link to docs, docs link to notes
