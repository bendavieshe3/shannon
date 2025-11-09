# /feature-review

Comprehensive health check for a feature.

## Usage

```
/feature-review FEAT-XXX
```

## What it does

1. **Load feature and context**:
   - Read ./docs/features/FEAT-XXX-*.md
   - Read related product_requirements.md section
   - Read related technical_design.md sections
   - Review all tasks (completed and active)

2. **Check feature health** (score 1-10):

   **Alignment (0-3 points)**:
   - product requirements ↔ Feature ↔ Implementation aligned? (3 pts)
   - Minor drift detected? (2 pts)
   - Major drift? (1 pt)
   - Severe misalignment? (0 pts)

   **Progress (0-3 points)**:
   - Phases completing on schedule? (3 pts)
   - Slightly behind? (2 pts)
   - Significantly behind? (1 pt)
   - Stalled? (0 pts)

   **Quality (0-2 points)**:
   - Tests passing, docs updated? (2 pts)
   - Some issues? (1 pt)
   - Major quality problems? (0 pts)

   **Documentation (0-2 points)**:
   - All mandated docs current and APPROVED? (2 pts)
   - Some DRAFT docs? (1 pt)
   - Docs out of date or missing? (0 pts)

3. **Identify issues**:
   - Active phase behind schedule?
   - Tasks stuck in REVIEW or IN_PROGRESS too long?
   - Documentation marked DRAFT needing approval?
   - Technical debt accumulating?
   - Knowledge notes missing for complex implementations?

4. **Check roadmap**:
   - Is ideal state still relevant?
   - Should roadmap be adjusted?
   - Are phases appropriately sized?
   - Any phases that should be deprioritized?

5. **Update feature file**:
   - Add to "Review History" section:
     ```
     ### [YYYY-MM-DD] - Feature Review

     **Health Score**: X/10

     **Issues Found**:
     - [Issue 1]
     - [Issue 2]

     **Actions Taken**:
     - [Action 1]
     - [Action 2]
     ```

6. **Create action items**:
   - For each issue, create task or update docs
   - Examples:
     * Approve DRAFT documents
     * Unblock stuck tasks
     * Update roadmap based on learnings
     * Address technical debt

7. **Provide recommendations**:
   - Specific actions to improve health score
   - Timeline adjustments if needed
   - Suggest running `/feature-alignment` if not recent

## Example

```
/feature-review FEAT-001
```

AI finds:
- Health Score: 8/10
- Issues:
  * Phase 2 behind schedule (target was 6/8 tasks, only 3/8)
  * technical_design.md has DRAFT status (needs approval)
  * TASK-046 has edge case bugs (needs revisit)
- Actions:
  * Adjusted Phase 2 timeline (+2 weeks)
  * Reopened TASK-046 to fix edge cases
  * Scheduled technical_design.md review
- Recommendations:
  * Approve technical_design.md this week
  * Focus on completing Phase 2 tasks

## Notes

- Run periodically for comprehensive health check
- Different from `/feature-alignment` (alignment is just one aspect)
- Includes progress, quality, documentation checks
- Creates actionable tasks to address issues
- Health score helps track feature quality over time
- Recommended: Run monthly or when feature feels "off track"
