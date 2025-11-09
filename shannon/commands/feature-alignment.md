# /feature-alignment

Check alignment between product requirements, feature, and implementation.

## Usage

```
/feature-alignment FEAT-XXX
```

## What it does

1. **Load feature and related docs**:
   - Read ./docs/features/FEAT-XXX-*.md
   - Read product_requirements.md (especially referenced section)
   - Read technical_design.md (relevant sections)
   - Review completed tasks for this feature

2. **Check product requirements alignment**:
   - Compare feature's "Product Vision" and "User Stories" to product_requirements.md
   - Questions to answer:
     * Do product requirements still describe this capability?
     * Have product requirements been updated with new requirements not in feature?
     * Are feature's user stories still relevant?
   - Document: ✅ Aligned | ⚠️ Drift Detected

3. **Check user story alignment**:
   - Review feature's user stories
   - Check if user stories reflect current product requirements
   - Check if completed implementation covers user stories
   - Identify gaps: stories without implementation, implementation without stories
   - Document: ✅ Aligned | ⚠️ Updated (if stories need updating)

4. **Check implementation alignment**:
   - Review completed task implementations
   - Check if technical_design.md describes what was built
   - Check if code matches described architecture
   - Identify drift: implementation without documentation, docs without implementation
   - Document: ✅ Aligned | ⚠️ Changes Needed

5. **Identify gaps and drift**:
   - List specific misalignments found:
     * product requirements changes not reflected in feature
     * Feature user stories not implemented
     * Implementation not documented
     * Documentation not implemented

6. **Create corrective tasks**:
   - For each gap, ask: "Should we create a task to address this?"
   - Create tasks to:
     * Update feature user stories
     * Implement missing capabilities
     * Update technical_design.md
     * Update product_requirements.md

7. **Update feature file**:
   - Add to "Alignment History" section:
     ```
     ### [YYYY-MM-DD] - Alignment Check

     **product requirements**: [Status]
     **User Stories**: [Status]
     **Implementation**: [Status]

     **Issues Found**:
     - [Issue 1]
     - [Issue 2]

     **Actions Taken**:
     - [Action 1: Created TASK-XXX]
     - [Action 2: Updated user stories]
     ```

8. **Provide summary**:
   - Overall alignment status
   - List of issues found
   - List of corrective tasks created
   - Recommendation: Run alignment check every 2-4 weeks

## Example

```
/feature-alignment FEAT-001
```

AI finds:
- product requirements added MFA requirement (regulatory compliance)
- Feature has no MFA in roadmap
- Creates TASK-054: "Plan MFA implementation"
- Moves MFA from "Future Work" to Phase 3 in roadmap
- Records alignment check in feature file

## Notes

- Run this periodically (every 2-4 weeks) for active features
- Catches drift early before it becomes major problem
- May create new tasks to address gaps
- May update feature roadmap based on findings
- This is how the system "heals" from drift
- Recommended: Run before starting a new phase
