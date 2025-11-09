# /feature-phase-start

Start active work on a feature phase.

## Usage

```
/feature-phase-start FEAT-XXX [phase-number]
```

If phase-number omitted, starts the next planned phase.

## What it does

1. **Load feature**:
   - Read ./docs/features/FEAT-XXX-*.md
   - Verify phase exists and is in 📋 Planned state
   - List tasks for this phase

2. **Update phase status**:
   - Change phase status from 📋 Planned → 🔄 Active
   - Add "Started" date to phase
   - Update task count: (0/X tasks)

3. **Update feature state**:
   - Change State from STABLE → ACTIVE
   - Update feature_index.md:
     ```
     - [FEAT-XXX](./path.md) - ACTIVE (Phase X/Y) - Feature Name #tags
     ```

4. **Show next actions**:
   - List tasks in TODO state for this phase
   - Suggest starting with `/task-ready TASK-XXX` for first task
   - Remind about workflow: TODO → READY → IN_PROGRESS → REVIEW → COMPLETED

5. **Confirm activation**:
   - Feature is now ACTIVE
   - Phase work has begun
   - Track progress as tasks complete

## Example

```
/feature-phase-start FEAT-001 2
```

Updates:
- Phase 2 status: 📋 Planned → 🔄 Active (0/8 tasks)
- Feature state: STABLE → ACTIVE
- feature_index.md: "ACTIVE (Phase 2/4)"

Shows next steps:
- Start with `/task-ready TASK-045` to plan first task

## Notes

- Feature moves to ACTIVE state
- Only one phase can be active at a time per feature
- Multiple features can have active phases simultaneously
- Work proceeds task by task through the phase
- Use `/feature-phase-complete` when all tasks done
