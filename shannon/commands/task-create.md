# /task-create

Create a new task in the task tracking system.

## What it does

1. **Gather task information**:
   - Task description (clear, concise)
   - Priority (P0-Critical, P1-High, P2-Medium, P3-Low)
   - Tags (#frontend, #backend, #bug, #feature, etc.)
   - Related feature (FEAT-XXX) if applicable

2. **Generate task ID**:
   - Read ./docs/tasks/task_index.md to find highest TASK-XXX
   - Generate next ID (e.g., if highest is TASK-045, create TASK-046)

3. **Create task file** from template:
   - Copy ./docs/tasks/TASK-XXX.md (deployed template)
   - Save as ./docs/tasks/TASK-{XXX}-{slug}.md
   - Fill in:
     * ID, Description, Priority, Tags, Created date
     * State = TODO
     * Leave Implementation Plan empty (filled during /task-ready)

4. **Gather acceptance criteria**:
   - Ask user: "What are the specific acceptance criteria?"
   - Add as checkbox list in Acceptance Criteria section
   - Ensure criteria are specific and testable

5. **Update task index**:
   - Add entry to ./docs/tasks/task_index.md:
     ```
     - [TASK-XXX](./TASK-XXX-slug.md) - TODO - Description #tags
     ```

6. **If linked to feature**:
   - Add task to feature's current phase task list
   - Update feature file in ./docs/features/

7. **Confirm creation**:
   - Show task ID and location
   - Next step: Run `/task-ready TASK-XXX` to plan the implementation

## Example usage

```
/task-create
```

You'll be prompted for:
- Description: "Add Google OAuth provider"
- Priority: P0
- Tags: #backend #FEAT-001
- Acceptance criteria:
  - [ ] Google OAuth flow works
  - [ ] Tokens stored securely
  - [ ] Tests written (90%+ coverage)

Creates: `./docs/tasks/TASK-049-add-google-oauth.md`

## Notes

- Tasks start in TODO state
- Use `/task-ready` to plan the task (TODO → READY)
- Tasks can be orphans (not linked to features) - that's OK!
- Keep descriptions concise (detailed implementation goes in the task file)
