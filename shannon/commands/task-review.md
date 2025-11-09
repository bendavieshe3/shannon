# /task-review

Review a completed task and approve it (or send back for changes).

## Usage

```
/task-review TASK-XXX [--approve]
```

## What it does

1. **Load task**:
   - Read ./docs/tasks/TASK-XXX-*.md
   - Verify state is REVIEW
   - Review implementation notes and testing section

2. **Perform review checklist**:
   - [ ] Code follows code_style_guide.md
   - [ ] Tests written and passing (per development_design.md)
   - [ ] Documentation updated (technical_design.md aligned)
   - [ ] Knowledge notes created/updated with learnings
   - [ ] All acceptance criteria met
   - [ ] No security issues or obvious bugs

3. **Check documentation alignment**:
   - If technical_design.md was marked DRAFT, review changes
   - Ensure mandated docs are consistent
   - Verify knowledge_index.md updated if notes created

4. **Fill review section**:
   - Check off review checklist items
   - Add review notes (feedback, issues found)
   - Document how issues were addressed

5. **If --approve flag provided**:
   - Change State from REVIEW → COMPLETED
   - Update task_index.md state
   - Move task file to ./docs/tasks/archive/
   - Update task_index.md path to ./archive/TASK-XXX-*.md
   - Set "Updated" and "Completed" dates
   - If linked to feature, update feature phase progress

6. **If issues found (no --approve)**:
   - Change State from REVIEW → IN_PROGRESS
   - Add review notes explaining what needs fixing
   - Task goes back to implementation

7. **Confirm completion**:
   - Show summary of what was accomplished
   - Task is now complete and archived

## Example

Review without approving:
```
/task-review TASK-049
```
AI performs review, fills checklist, adds notes.

Approve after review:
```
/task-review TASK-049 --approve
```
AI marks as COMPLETED and archives.

## Notes

- This is Gate 3 (completion approval)
- Human should review the AI's assessment before approving
- Tasks can go back to IN_PROGRESS if issues found
- Completed tasks move to ./archive/ directory
- Recent completed tasks (last ~20) stay in task_index.md for reference
- This completes the task lifecycle: TODO → READY → IN_PROGRESS → REVIEW → COMPLETED
