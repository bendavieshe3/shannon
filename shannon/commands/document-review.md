# /document-review

Review and approve DRAFT mandated documents.

## Usage

```
/document-review [document-name]
```

If document-name omitted, lists all DRAFT documents.

## What it does

1. **Check git status (before)**:
   - Run `git status` to check for uncommitted changes
   - If changes exist:
     * Show summary of changed files
     * Prompt: "You have uncommitted changes. Would you like to commit them before reviewing documentation? [y/n]"
     * If yes: Allow user to commit implementation work
     * If no: Continue with review

2. **Load documentation style guide**:
   - Read ./docs/documentation_style_guide.md
   - Note status (DRAFT or APPROVED)
   - Use approved guidelines for review (if APPROVED)
   - Warn if DRAFT: "documentation_style_guide.md is DRAFT - using as provisional guidance"

3. **If no document specified**:
   - Scan ./docs/ for mandated documents
   - List all documents with Status: DRAFT
   - Show last reviewed date for each
   - Prompt: "Which document would you like to review?"

4. **Load document**:
   - Read ./docs/[document-name].md
   - Verify it's a mandated document
   - Check current status

5. **Interactive review**:
   - Display document section by section
   - For each section, ask: "Review this section?"
   - User can:
     * Approve section as-is
     * Request changes (AI makes edits)
     * Skip to next section

6. **Check completeness**:
   - All required sections filled in?
   - All [placeholders] replaced?
   - All examples removed?
   - References to other docs valid?
   - Version history updated?

7. **Verify cross-references**:
   - If product_requirements.md: Check feature references exist
   - If technical_design.md: Check knowledge note references exist
   - If code_style_guide.md: Ensure examples are consistent

8. **Check style guide compliance** (if documentation_style_guide.md is APPROVED):
   - Verify writing style (voice, tone, person, active voice)
   - Check document structure (headings, sections)
   - Verify formatting conventions (text, lists, links, tables)
   - Check code examples (if applicable)
   - Verify special elements (admonitions, screenshots, diagrams)
   - Note any deviations from style guide

9. **Update document status** (if approved):
   - Change Status from DRAFT → APPROVED
   - Set "Last Reviewed" to current date (YYYY-MM-DD format)
   - Set "Approved By" to user name (or prompt for name)
   - Add entry to "Version History":
     ```
     ### [YYYY-MM-DD] - vX.X
     - [Changes made since last version]
     - Status: APPROVED ([YYYY-MM-DD])
     ```

10. **If changes needed**:
   - Make requested edits
   - Keep Status as DRAFT
   - Update "Last Reviewed" date
   - Add note in Version History about changes
   - Re-run `/document-review` when ready

11. **Check git status (after)**:
   - Run `git status` to check for changes from review
   - If document was modified during review:
     * Show summary of changes made
     * Prompt: "Review made changes to documentation. Would you like to commit these changes? [y/n]"
     * If yes: Guide user through commit (with descriptive message)
     * If no: Remind user to commit later

12. **Provide summary**:
   - Document approved and ready to use
   - Or: Changes made, still DRAFT (review again when ready)
   - Style guide compliance status (if checked)
   - List other DRAFT documents remaining

## Example

```
/document-review
```

Shows:
- product_requirements.md - DRAFT (last reviewed: 2025-10-15)
- technical_design.md - DRAFT (last reviewed: never)
- code_style_guide.md - APPROVED (2025-10-10)
- ...

User selects: technical_design.md

AI walks through each section, user approves or requests changes.

After approval:
- Status: DRAFT → APPROVED
- Last Reviewed: 2025-11-08
- Approved By: [User Name]

## Example - Review Specific Document

```
/document-review product_requirements.md
```

AI loads product_requirements.md and walks through review.

## Notes

- This is Gate 1 (document approval before use)
- Documents should be reviewed by human before marking APPROVED
- DRAFT documents can still be read by AI, but indicates "not final"
- Approved documents provide trusted context for planning
- Re-review when significant changes made (bump version, mark DRAFT again)
- Recommended: Review new documents within 1-2 days of creation
- Interactive review allows section-by-section approval
- Git status checks ensure clean separation between implementation and documentation work
- Style guide compliance ensures documentation quality and consistency
- If documentation_style_guide.md is DRAFT, style checks are advisory only
