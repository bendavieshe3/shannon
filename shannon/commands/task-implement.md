# /task-implement

Implement a task or mark implementation as complete.

## Usage

```
/task-implement TASK-XXX           # Start implementing
/task-implement TASK-XXX --complete # Mark implementation done
```

## What it does (without --complete)

1. **Load task**:
   - Read ./docs/tasks/TASK-XXX-*.md
   - Verify state is READY (if not, suggest `/task-ready` first)
   - Review implementation plan and acceptance criteria

2. **Update state**:
   - Change State from READY → IN_PROGRESS
   - Update task_index.md state
   - Set "Updated" date

3. **Begin implementation**:
   - Follow implementation plan phases
   - Follow code_style_guide.md for code formatting, naming, docstrings
   - Follow ux_style_guide.md for UI components (if applicable)
   - Follow development_design.md for testing requirements
   - Write code, tests, and documentation

4. **Track progress**:
   - Check off acceptance criteria as completed
   - Add notes to "Implementation Notes" section:
     * Changes from Plan (if any deviations)
     * Gotchas Encountered (problems and solutions)
     * Documentation Updated (which docs changed)

5. **Update documentation as you go**:
   - If implementation differs from technical_design.md, update it (mark DRAFT)
   - Add detailed patterns to knowledge notes
   - Update knowledge_index.md if new notes created

6. **Follow development workflow**:
   - Commit regularly with descriptive messages
   - Run tests frequently
   - Run linters before committing (per development_design.md)

## What it does (with --complete)

1. **Verify completion**:
   - Check all acceptance criteria are met
   - Ensure tests are written and passing
   - Verify documentation updated

2. **Fill testing section**:
   - Document test coverage
   - List test commands to run
   - Note any manual testing performed

3. **Update state**:
   - Change State from IN_PROGRESS → REVIEW
   - Update task_index.md state
   - Set "Updated" date

4. **Prompt for review**:
   - Remind user to run `/task-review TASK-XXX` next
   - Implementation is done but needs approval

## Example

Start implementing:
```
/task-implement TASK-049
```

Mark as complete:
```
/task-implement TASK-049 --complete
```

## Notes

- Follow style guides strictly (code_style_guide.md, ux_style_guide.md)
- Run tests frequently during implementation
- Update technical_design.md if approach changes (mark DRAFT)
- Create knowledge notes for complex patterns
- Implementation Notes track what actually happened (deviations, gotchas)
- Don't mark --complete until all acceptance criteria are met
