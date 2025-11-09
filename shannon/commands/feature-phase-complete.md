# /feature-phase-complete

Complete a feature phase after all tasks are done.

## Usage

```
/feature-phase-complete FEAT-XXX [phase-number]
```

If phase-number omitted, completes the currently active phase.

## What it does

1. **Load feature**:
   - Read ./docs/features/FEAT-XXX-*.md
   - Verify phase is in 🔄 Active state
   - Check all tasks for this phase

2. **Verify completion**:
   - Ensure ALL phase tasks are COMPLETED
   - If any tasks not completed, list them and abort
   - Prompt: "Not all tasks are complete. Complete these first: TASK-XXX, TASK-YYY"

3. **Check alignment** (mini alignment check):
   - Review product_requirements.md section referenced by feature
   - Check if feature's user stories still match product requirements
   - Check if implementation matches user stories
   - Note any drift detected

4. **Update phase status**:
   - Change phase status from 🔄 Active → ✅ Completed
   - Update task count: (X/X tasks) - all completed
   - Add "Completed" date to phase

5. **Update feature state**:
   - If no next phase planned: ACTIVE → STABLE
   - If next phase exists: remains ACTIVE or ask if starting next phase
   - Update feature_index.md accordingly

6. **Record completion**:
   - Add to alignment history in feature file:
     ```
     ### [YYYY-MM-DD] - Phase X Completion Check

     **product requirements**: ✅ Aligned / ⚠️ Drift Detected
     **User Stories**: ✅ Aligned / ⚠️ Updated
     **Implementation**: ✅ Aligned / ⚠️ Changes Needed

     **Actions Taken**: [What was done]
     ```

7. **Suggest next steps**:
   - If drift detected: Suggest updating docs
   - If next phase planned: "Start Phase X with `/feature-phase-start FEAT-XXX X`"
   - If no next phase: "Feature is now STABLE. Plan next phase with `/feature-phase-plan`"

## Example

```
/feature-phase-complete FEAT-001 2
```

AI will:
- Verify all 8 tasks for Phase 2 are COMPLETED
- Check product_requirements.md § "User Authentication" alignment
- Mark Phase 2 as ✅ Completed
- Update feature state based on next phase
- Record alignment check

## Notes

- All tasks must be COMPLETED before phase can complete
- Includes mini alignment check (full alignment is `/feature-alignment`)
- Feature returns to STABLE if no next phase active
- Can immediately start next phase if planned
- Phase completion is milestone for progress tracking
