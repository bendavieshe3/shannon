# /document-review

Review and approve DRAFT mandated documents.

## Usage

```
/document-review [document-name]
```

If document-name omitted, lists all DRAFT documents.

## What it does

1. **If no document specified**:
   - Scan ./docs/ for mandated documents
   - List all documents with Status: DRAFT
   - Show last reviewed date for each
   - Prompt: "Which document would you like to review?"

2. **Load document**:
   - Read ./docs/[document-name].md
   - Verify it's a mandated document
   - Check current status

3. **Interactive review**:
   - Display document section by section
   - For each section, ask: "Review this section?"
   - User can:
     * Approve section as-is
     * Request changes (AI makes edits)
     * Skip to next section

4. **Check completeness**:
   - All required sections filled in?
   - All [placeholders] replaced?
   - All examples removed?
   - References to other docs valid?
   - Version history updated?

5. **Verify cross-references**:
   - If product_requirements.md: Check feature references exist
   - If technical_design.md: Check knowledge note references exist
   - If code_style_guide.md: Ensure examples are consistent

6. **Update document status** (if approved):
   - Change Status from DRAFT → APPROVED
   - Set "Last Reviewed" to current date
   - Set "Approved By" to user name (or prompt for name)
   - Add entry to "Version History":
     ```
     ### [YYYY-MM-DD] - vX.X
     - [Changes made since last version]
     - Status: APPROVED ([YYYY-MM-DD])
     ```

7. **If changes needed**:
   - Make requested edits
   - Keep Status as DRAFT
   - Update "Last Reviewed" date
   - Add note in Version History about changes
   - Re-run `/document-review` when ready

8. **Provide summary**:
   - Document approved and ready to use
   - Or: Changes made, still DRAFT (review again when ready)
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
