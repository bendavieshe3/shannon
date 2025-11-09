# TASK-[XXX]: [Brief Task Description]

**ID**: TASK-[XXX]
**State**: TODO | READY | IN PROGRESS | REVIEW | COMPLETED
**Priority**: P0 (Critical) | P1 (High) | P2 (Medium) | P3 (Low)
**Tags**: #component #type #FEAT-XXX
**Created**: [YYYY-MM-DD]
**Updated**: [YYYY-MM-DD]

---

## Description

<!--
Clear, concise description of what needs to be done.
1-2 paragraphs explaining the task.
-->

[What needs to be done and why]

**Example**:
> Implement OAuth 2.0 authentication flow with PKCE for secure SPA login. This replaces the basic email/password authentication and provides better security for our single-page application. The implementation should support Google and GitHub as OAuth providers.

---

## Context

<!--
OPTIONAL: Additional context, background, or motivation.
Remove if description is sufficient.
-->

[Why this task exists, related history, or dependencies]

**Example**:
> This task is part of FEAT-001 Phase 2 (OAuth Integration). Basic email/password auth was implemented in Phase 1, but users have requested social login for convenience. OAuth with PKCE is the industry standard for SPA authentication and provides better security than storing passwords.

---

## Acceptance Criteria

<!--
Specific, testable criteria for completion.
Checkbox format (will be checked off during review).
-->

- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

**Example**:
> - [ ] User can log in with Google OAuth
> - [ ] User can log in with GitHub OAuth
> - [ ] OAuth flow implements PKCE for security
> - [ ] Access tokens stored securely (memory only)
> - [ ] Refresh tokens stored in httpOnly cookies
> - [ ] Token refresh works automatically on expiration
> - [ ] Error handling for expired/invalid tokens
> - [ ] Tests cover OAuth flow (90%+ coverage)
> - [ ] Documentation updated (API docs, user guide)

---

## Implementation Plan

<!--
Filled in during /task-ready (TODO → READY transition).
High-level approach, phases, technical decisions.
Not detailed code - that happens during implementation.
-->

### Approach

[High-level technical approach]

**Example**:
> Use Authlib library (from technology_stack.md) to handle OAuth protocol details. Implement PKCE flow as recommended in knowledge/research/oauth-vs-jwt-auth.md. Store refresh tokens in httpOnly cookies for XSS protection, access tokens in React context (memory) for performance.

### Pre-Read Documentation

<!--
Auto-populated during /task-ready with docs that were read.
-->

- [Document 1]
- [Document 2]

**Example**:
> - conceptual_design.md § "User"
> - technical_design.md § "Authentication"
> - code_style_guide.md (naming, docstrings)
> - development_design.md (testing requirements)
> - knowledge/research/oauth-vs-jwt-auth.md
> - knowledge/implementation-details/oauth-implementation.md

### Phases

<!--
OPTIONAL: Break implementation into phases if complex.
Remove if task can be done in one pass.
-->

**Phase 1**: [First phase description]
- [Sub-task 1]
- [Sub-task 2]

**Phase 2**: [Second phase description]
- [Sub-task 1]
- [Sub-task 2]

**Example**:
> **Phase 1**: Backend OAuth endpoints
> - Implement `/auth/oauth/start` (redirect to provider)
> - Implement `/auth/oauth/callback` (handle provider response)
> - Implement `/auth/refresh` (refresh access token)
> - Add OAuth models to database
> - Write tests for OAuth flows
>
> **Phase 2**: Frontend integration
> - Create OAuth button components
> - Implement OAuth redirect flow
> - Add token refresh interceptor
> - Handle error states (expired tokens, failed auth)
> - Update UI to show OAuth options
>
> **Phase 3**: Documentation & testing
> - Update API documentation
> - Update user guide
> - Add E2E tests for full flow
> - Test with actual OAuth providers (dev credentials)

### Key Decisions

<!--
OPTIONAL: Important technical decisions made during planning.
-->

- **[Decision]**: [Choice made and rationale]

**Example**:
> - **Token Storage**: httpOnly cookies for refresh, memory for access (security vs XSS)
> - **Session Backend**: Redis (fast, auto-expiry, from technical_design.md)
> - **Token Lifetime**: 30 min access, 30 day refresh (balance security vs UX)
> - **Providers**: Google + GitHub initially (most requested, easy to add more later)

---

## Implementation Notes

<!--
Filled in during /task-implement (READY → IN PROGRESS).
Track decisions, gotchas, changes from plan.
-->

### Changes from Plan

[Any deviations from the implementation plan and why]

**Example**:
> - Added token rotation on refresh (discovered security best practice during implementation)
> - Used Redis Pub/Sub for logout broadcast (needed for multi-instance deployment)
> - Simplified error handling based on code review feedback

### Gotchas Encountered

[Problems encountered and solutions]

**Example**:
> - CORS issue with credentials: Fixed by adding `credentials: 'include'` to fetch calls
> - Race condition on multiple 401s: Added mutex to prevent concurrent refresh attempts
> - OAuth state parameter validation: Must be cryptographically random (use secrets module)

### Documentation Updated

[Which documents were updated during implementation]

**Example**:
> - technical_design.md § "Authentication" - updated with PKCE approach (marked DRAFT)
> - knowledge/implementation-details/oauth-implementation.md - added token rotation section
> - API documentation - added OAuth endpoints

---

## Testing

<!--
How this task was tested.
Filled in during implementation.
-->

### Test Coverage

[Coverage metrics and what was tested]

**Example**:
> - Unit tests: 95% coverage (test_oauth_service.py, test_oauth_routes.py)
> - Integration tests: OAuth flow with mocked provider
> - E2E tests: Full OAuth flow with test Google account
> - Manual testing: GitHub OAuth with real credentials

### Test Commands

[Commands to run tests for this task]

**Example**:
> ```bash
> # Unit tests
> pytest tests/unit/test_oauth_service.py -v
>
> # Integration tests
> pytest tests/integration/test_oauth_flow.py -v
>
> # E2E tests
> pytest tests/e2e/test_oauth_e2e.py -v
> ```

---

## Review

<!--
Filled in during /task-review (IN PROGRESS → REVIEW).
Review notes, feedback, final verification.
-->

### Review Checklist

- [ ] Code follows code_style_guide.md
- [ ] Tests written and passing (per development_design.md)
- [ ] Documentation updated (technical_design.md aligned)
- [ ] Knowledge notes created/updated with learnings
- [ ] Acceptance criteria met
- [ ] No security issues or obvious bugs

### Review Notes

[Feedback from review, issues found, how they were addressed]

**Example**:
> - ✅ All acceptance criteria met
> - ✅ Code style compliant (ruff, mypy passing)
> - ✅ Tests passing (95% coverage)
> - ⚠️ Added TODO for token rotation logging (TASK-124 created)
> - ✅ technical_design.md updated and marked DRAFT for approval

---

## Related

<!--
Links to related features, tasks, documentation.
-->

- **Feature**: [FEAT-XXX]
- **Related Tasks**: [TASK-YYY], [TASK-ZZZ]
- **Blocks**: [TASK-AAA] (if this task blocks others)
- **Blocked By**: [TASK-BBB] (if blocked by other tasks)

**Example**:
> - **Feature**: FEAT-001 (Secures User Data)
> - **Related Tasks**: TASK-046 (OAuth error handling), TASK-047 (Session management)
> - **Blocks**: TASK-048 (Profile page requires auth)
> - **Blocked By**: None

---

## Timeline

<!--
OPTIONAL: Track time spent and milestones.
Remove if not tracking time.
-->

- **Created**: [YYYY-MM-DD]
- **Ready**: [YYYY-MM-DD] (TODO → READY)
- **Started**: [YYYY-MM-DD] (READY → IN PROGRESS)
- **Completed**: [YYYY-MM-DD] (REVIEW → COMPLETED)
- **Time Spent**: [Hours/days]

**Example**:
> - **Created**: 2025-10-10
> - **Ready**: 2025-10-12 (planned with AI)
> - **Started**: 2025-10-13
> - **Completed**: 2025-10-16
> - **Time Spent**: ~12 hours over 4 days

---

## Notes for Using This Template

**During `/task-create`** (TODO state):
1. Fill in ID, Description, Tags, Priority
2. State = TODO
3. Leave Implementation Plan empty (filled during /task-ready)

**During `/task-ready`** (TODO → READY):
1. AI fills Implementation Plan based on pre-read docs
2. May create knowledge notes for research
3. State = READY

**During `/task-implement`** (READY → IN PROGRESS):
1. Fill Implementation Notes as you work
2. Update Documentation Updated section
3. Fill Testing section
4. State = IN PROGRESS
5. When done: `/task-implement --complete` → State = REVIEW

**During `/task-review`** (REVIEW → COMPLETED):
1. Verify acceptance criteria
2. Fill Review section
3. If approved: State = COMPLETED, move to archive/
4. If changes needed: State = IN PROGRESS, address feedback

**Tags Convention**:
- **Component**: #frontend #backend #database #api
- **Type**: #feature #bug #refactor #docs #test
- **Feature**: #FEAT-XXX (if linked to feature)

**State Transitions**:
```
TODO → READY → IN PROGRESS → REVIEW → COMPLETED
  ↓                  ↓
(skip planning)  (go back if changes needed)
```
