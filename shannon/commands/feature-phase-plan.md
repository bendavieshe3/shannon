# /feature-phase-plan

Plan a new phase for a feature.

## Usage

```
/feature-phase-plan FEAT-XXX [phase-number]
```

If phase-number omitted, plans the next phase.

## What it does

1. **Load feature**:
   - Read ./docs/features/FEAT-XXX-*.md
   - Check current roadmap to determine next phase number
   - Review product vision, ideal state, and user stories

2. **Pre-read documentation**:
   - product_requirements.md (especially the referenced section)
   - technical_design.md (architecture and approach)
   - conceptual_design.md (domain model)
   - Existing knowledge notes related to this feature

3. **Define phase goal**:
   - Ask: "What should this phase achieve?"
   - Consider moving toward ideal state incrementally
   - Phase should be achievable in reasonable time (weeks, not months)

4. **Identify deliverables**:
   - Ask: "What are the concrete deliverables?"
   - List specific capabilities to be added
   - Keep focused (better to have multiple small phases than one giant phase)

5. **Create task breakdown**:
   - Break phase into specific tasks
   - For each task:
     * Create with `/task-create`
     * Add to feature's phase task list
     * Tasks start in TODO state
   - Typically 5-15 tasks per phase

6. **Research if needed**:
   - If technical unknowns exist, create research notes
   - Add to ./docs/knowledge/research/
   - Update knowledge_index.md

7. **Update feature roadmap**:
   - Add new phase to "Roadmap" section:
     ```
     ### Phase X: [Phase Name] 📋

     **Status**: 📋 Planned

     **Goal**: [What this achieves]

     **Deliverables**:
     - [Deliverable 1]
     - [Deliverable 2]

     **Tasks**:
     - TASK-XXX: [Description] 📋
     - TASK-YYY: [Description] 📋
     ```

8. **Confirm phase plan**:
   - Show phase summary
   - List created tasks
   - Feature remains in STABLE state until `/feature-phase-start`

## Example

```
/feature-phase-plan FEAT-001 2
```

AI will:
- Read product_requirements.md § "User Authentication"
- Read technical_design.md § "Authentication"
- Read knowledge/research/oauth-vs-jwt-auth.md
- Define Phase 2: "OAuth Integration"
- Goal: Add social login for convenience and better security
- Deliverables: Google OAuth, GitHub OAuth, PKCE flow, token refresh
- Create 8 tasks (TASK-045 through TASK-052)
- Add phase to feature roadmap

## Notes

- This is part of Gate 1 (planning with documentation context)
- AI reads docs to create informed plan
- May create knowledge notes during planning
- Tasks are created but stay in TODO state
- Use `/feature-phase-start` to begin work on the phase
- Phases can be planned ahead of time (Phase 2, 3, 4...)
