# /task-ready

Plan a task and transition from TODO to READY state.

## Usage

```
/task-ready TASK-XXX
```

## What it does

1. **Read task file**:
   - Load ./docs/tasks/TASK-XXX-*.md
   - Verify current state is TODO
   - Review description and acceptance criteria

2. **Pre-read relevant documentation**:
   - conceptual_design.md (if domain concepts involved)
   - technical_design.md (architecture and technical approach)
   - code_style_guide.md (coding standards)
   - development_design.md (testing requirements, workflows)
   - Related knowledge notes (if referenced in docs)
   - List what was read in "Pre-Read Documentation" section

3. **Create implementation plan**:
   - Ask clarifying questions if needed
   - Determine high-level technical approach
   - Identify phases if complex (break into steps)
   - Document key decisions with rationale
   - Note any research needed
   - Fill in "Implementation Plan" section:
     * Approach (high-level technical approach)
     * Phases (if applicable)
     * Key Decisions (important choices and why)

4. **Research if needed**:
   - If technical unknowns exist, create research note in ./docs/knowledge/research/
   - Add to knowledge_index.md
   - Reference in implementation plan

5. **Update task**:
   - Fill "Implementation Plan" section
   - List "Pre-Read Documentation"
   - Change State from TODO → READY
   - Update "Updated" date

6. **Update task index**:
   - Change state in ./docs/tasks/task_index.md:
     ```
     - [TASK-XXX](./path.md) - READY - Description #tags
     ```

7. **Confirm readiness**:
   - Show implementation plan summary
   - Task is now ready for `/task-implement TASK-XXX`

## Example

```
/task-ready TASK-049
```

AI will:
- Read conceptual_design.md § "User", technical_design.md § "Authentication"
- Read knowledge/implementation-details/oauth-implementation.md
- Create implementation plan:
  * Phase 1: Backend endpoints
  * Phase 2: Frontend integration
  * Phase 3: Testing
- Key decision: Use httpOnly cookies for refresh tokens (security)
- Update state to READY

## Notes

- This is the planning gate (Gate 2)
- Human should review the plan before proceeding to implementation
- May create knowledge notes during planning
- Implementation plan is high-level, not detailed code
- AI reads docs to understand context (not redundant with human knowledge)
