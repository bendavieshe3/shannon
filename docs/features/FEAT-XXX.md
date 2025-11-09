# FEAT-[XXX]: [Feature Name - Product Characteristic]

**ID**: FEAT-[XXX]
**State**: STABLE | ACTIVE
**Type**: Core Capability | Enhancement | Infrastructure
**product requirements Reference**: § "[Section Name from product_requirements.md]"
**First Implemented**: [YYYY-MM-DD or "Not yet implemented"]
**Last Reviewed**: [YYYY-MM-DD]

---

## Product Vision

<!--
What this feature represents from a product perspective.
Aspirational, describes what the product IS (not what you're building).
-->

[Describe what capability this feature provides to users, in product terms]

**Example**:
> Users need secure, frictionless authentication to protect their data while accessing IdeaFlow from any device. This feature ensures user accounts are protected with modern authentication standards while providing convenient social login options.

---

## Ideal State

<!--
What this feature looks like when fully mature.
This is the north star - may take years to achieve.
-->

[Describe the ultimate vision for this feature]

**Example**:
> - Users can log in with email/password, Google, GitHub, or other OAuth providers
> - Multi-factor authentication available for high-security users
> - Passwordless login via magic links or WebAuthn
> - Session management across devices with remote logout
> - Automatic session refresh with no user interruption
> - Enterprise SSO support (SAML) for business users

---

## User Stories

<!--
High-level user stories related to this feature.
More granular than product_requirements.md stories.
Evolved during implementation - stories can be added, refined, or removed.
-->

### [Story Category/Theme]

**As a** [user type],
**I want** [capability],
**So that** [benefit].

**Acceptance Criteria** (high-level):
- [Criterion 1]
- [Criterion 2]

**Example**:
> ### Secure Access
>
> **As a** user concerned about security,
> **I want** to log in with my Google account instead of creating another password,
> **So that** I don't have to manage yet another password and can leverage Google's security.
>
> **Acceptance Criteria**:
> - Can initiate Google login from app
> - App redirects to Google for authentication
> - Successfully logs in after Google approval
> - Session persists across browser sessions
>
> ### Multi-Device Access
>
> **As a** user who works across devices,
> **I want** my sessions to stay active but be able to log out from all devices,
> **So that** I can secure my account if I lose a device.
>
> **Acceptance Criteria**:
> - Can view active sessions
> - Can log out from current device
> - Can log out from all devices at once
> - Old sessions automatically expire after 30 days

---

## Roadmap

<!--
Phases that implement this feature over time.
Each phase brings the feature closer to the ideal state.
Phases accumulate - they don't get deleted when complete.
-->

### Phase 1: [Phase Name] ✅ | 🔄 | ⏸️ | 📋

**Status**: ✅ Completed | 🔄 Active | ⏸️ Paused | 📋 Planned

**Goal**: [What this phase achieves]

**Deliverables**:
- [Deliverable 1]
- [Deliverable 2]

**Tasks**:
- TASK-[XXX]: [Task description] [Status]
- TASK-[YYY]: [Task description] [Status]

**Completed**: [YYYY-MM-DD or blank if not completed]

**Example**:
> ### Phase 1: Basic Email/Password Auth ✅
>
> **Status**: ✅ Completed
>
> **Goal**: Minimum viable authentication - users can create accounts and log in
>
> **Deliverables**:
> - User registration with email/password
> - Login with email/password
> - Password hashing (bcrypt)
> - Basic session management
> - Logout functionality
>
> **Tasks**:
> - TASK-001: Create user model and database schema ✅
> - TASK-002: Implement registration endpoint ✅
> - TASK-003: Implement login endpoint ✅
> - TASK-004: Add password hashing ✅
> - TASK-005: Create session management ✅
> - TASK-006: Add logout endpoint ✅
> - TASK-007: Write tests for auth flow ✅
> - TASK-008: Create login UI ✅
>
> **Completed**: 2025-09-30
>
> ### Phase 2: OAuth Integration 🔄
>
> **Status**: 🔄 Active (3/8 tasks complete)
>
> **Goal**: Add social login for convenience and better security
>
> **Deliverables**:
> - Google OAuth login
> - GitHub OAuth login
> - OAuth with PKCE for SPA security
> - Token refresh mechanism
> - Error handling for OAuth flows
>
> **Tasks**:
> - TASK-045: Implement OAuth flow with PKCE ✅
> - TASK-046: Add OAuth error handling ✅
> - TASK-047: Create session management for OAuth ✅
> - TASK-048: Build OAuth UI components 🔄
> - TASK-049: Add Google provider integration 📋
> - TASK-050: Add GitHub provider integration 📋
> - TASK-051: Write E2E tests for OAuth 📋
> - TASK-052: Update documentation 📋
>
> **Started**: 2025-10-10
>
> ### Phase 3: Multi-Factor Authentication 📋
>
> **Status**: 📋 Planned (not started)
>
> **Goal**: Add MFA for users who need extra security
>
> **Deliverables**:
> - TOTP-based MFA (authenticator apps)
> - SMS-based MFA (optional)
> - Backup codes for account recovery
> - Per-device trust (remember this device)
>
> **Tasks**: (Will be created during /feature-phase-plan FEAT-001 3)

---

## Technical Approach

<!--
High-level technical implementation approach.
References technical_design.md for details.
May evolve as phases are implemented.
-->

[Technical approach for implementing this feature]

**From Documentation**:
- [Reference to technical_design.md sections]
- [Reference to knowledge notes]

**Example**:
> **Architecture**: Backend API handles authentication, frontend SPA manages session
>
> **Technology** (from technology_stack.md):
> - Authlib for OAuth implementation
> - bcrypt for password hashing
> - Redis for session storage
>
> **Security** (from technical_design.md § "Authentication"):
> - OAuth 2.0 with PKCE for SPAs
> - httpOnly cookies for refresh tokens
> - Memory-only storage for access tokens
> - 30-minute access token lifetime
> - 30-day refresh token lifetime
>
> **Related Documentation**:
> - technical_design.md § "Authentication"
> - knowledge/implementation-details/oauth-implementation.md
> - code_style_guide.md (for auth code patterns)

---

## Dependencies

<!--
OPTIONAL: What this feature depends on or what depends on it.
Remove if no significant dependencies.
-->

### This Feature Depends On:
- [Dependency 1]

### Dependent Features:
- [Feature that depends on this]

**Example**:
> ### This Feature Depends On:
> - Database infrastructure (users table)
> - Redis for session storage
> - Email service for password reset (Phase 4)
>
> ### Dependent Features:
> - FEAT-003 (Organizes User Ideas) - requires auth to associate ideas with users
> - FEAT-005 (Enables Collaboration) - requires auth for sharing
> - All features require this for user identification

---

## Success Metrics

<!--
OPTIONAL: How to measure if this feature is successful.
Remove if not tracking metrics.
-->

**Metrics**:
- [Metric 1]
- [Metric 2]

**Targets**:
- [Target for metric 1]
- [Target for metric 2]

**Example**:
> **Metrics**:
> - Registration conversion rate
> - Login success rate
> - OAuth vs email/password usage
> - Session duration
> - Account security incidents
>
> **Targets**:
> - 80%+ registration conversion (start → complete)
> - 98%+ login success rate
> - 60%+ users choose OAuth (convenience)
> - < 5% support tickets related to auth
> - Zero account breaches due to weak passwords

---

## Known Issues & Future Work

<!--
Track known limitations, tech debt, future improvements.
-->

### Current Limitations:
- [Limitation 1]

### Future Improvements (Not Yet Planned):
- [Possible future enhancement]

**Example**:
> ### Current Limitations:
> - No password reset flow yet (Phase 4)
> - No multi-factor authentication (Phase 3)
> - Sessions don't sync across devices (single logout doesn't affect other devices)
> - OAuth providers limited to Google and GitHub
>
> ### Future Improvements (Not Yet Planned):
> - WebAuthn/passkeys support
> - Enterprise SSO (SAML)
> - Biometric authentication on mobile
> - Social login with Apple, Microsoft, Twitter
> - Account merging (link OAuth accounts to email/password accounts)

---

## Alignment History

<!--
Track when alignment checks were performed and findings.
Updated during /feature-alignment runs.
-->

### [YYYY-MM-DD] - Alignment Check

**product requirements**: [Aligned | Drift Detected]
**User Stories**: [Aligned | Updated]
**Implementation**: [Aligned | Changes Needed]

**Actions Taken**: [What was updated]

**Example**:
> ### 2025-10-21 - Alignment Check
>
> **product requirements**: ✅ Aligned
> **User Stories**: ⚠️ Updated (added multi-device story based on user feedback)
> **Implementation**: ✅ Aligned
>
> **Actions Taken**:
> - Added "Multi-Device Access" user story
> - Created TASK-053 for session management UI
> - Updated Phase 3 to include device management
>
> ### 2025-10-05 - Alignment Check
>
> **product requirements**: ⚠️ Drift Detected
> **User Stories**: ✅ Aligned
> **Implementation**: ⚠️ Changes Needed
>
> **Actions Taken**:
> - product_requirements.md added MFA requirement (regulatory compliance)
> - Moved MFA from "Future Work" to Phase 3 (now planned)
> - Updated roadmap priorities
> - Created TASK-054, TASK-055 for MFA planning

---

## Review History

<!--
Track feature reviews performed via /feature-review.
-->

### [YYYY-MM-DD] - Feature Review

**Health Score**: [X/10]

**Issues Found**:
- [Issue 1]
- [Issue 2]

**Actions Taken**:
- [Action 1]

**Example**:
> ### 2025-10-21 - Feature Review
>
> **Health Score**: 8/10
>
> **Issues Found**:
> - Phase 2 behind schedule (3/8 tasks, target was 6/8 by now)
> - OAuth error handling has edge case bugs (TASK-046 needs revisit)
> - technical_design.md has DRAFT status (needs approval)
>
> **Actions Taken**:
> - Adjusted Phase 2 timeline (+2 weeks)
> - Reopened TASK-046 to fix edge cases
> - Scheduled technical_design.md review session
> - Added more tests to TASK-051

---

## Version History

<!--
Track major changes to the feature definition.
-->

### [YYYY-MM-DD] - v[version]
- [Change description]

**Example**:
> ### 2025-10-21 - v1.2
> - Added Phase 3 (MFA) to roadmap (was in "Future Work")
> - Updated user stories based on user feedback
> - Refined Phase 2 tasks
>
> ### 2025-10-10 - v1.1
> - Started Phase 2 (OAuth Integration)
> - Added technical approach section with references
>
> ### 2025-09-01 - v1.0
> - Initial feature created
> - Defined product vision and ideal state
> - Created Phase 1 plan

---

## Notes for Using This Template

**During `/feature-create`**:
1. Fill in ID, Name (aspirational - what product IS)
2. Fill Product Vision, Ideal State
3. Initial user stories
4. Create Phase 1 plan (or defer to `/feature-phase-plan`)
5. State = STABLE (no active work yet)

**During `/feature-phase-plan FEAT-XXX [phase]`**:
1. AI reads product_requirements.md, technical_design.md
2. AI creates phase plan with tasks
3. AI may research and create knowledge notes
4. Tasks created in TODO state

**During `/feature-phase-start FEAT-XXX [phase]`**:
1. State = ACTIVE (work begins)

**During `/feature-phase-complete FEAT-XXX [phase]`**:
1. Verify all tasks COMPLETED
2. Mark phase complete
3. Check alignment (product requirements ↔ feature ↔ implementation)
4. State = STABLE (or ACTIVE if starting next phase)

**During `/feature-alignment FEAT-XXX`**:
1. Check product_requirements still aligned
2. Update user stories if needed
3. Verify implementation matches stories
4. Create tasks for any gaps found

**During `/feature-review FEAT-XXX`**:
1. Comprehensive health check
2. Detect drift
3. Verify quality
4. Update roadmap if needed

**Feature Naming**:
- ✅ "Secures User Data" (what product IS)
- ✅ "Organizes User Ideas" (capability)
- ❌ "Build Authentication System" (project name)
- ❌ "OAuth Implementation" (technical task)

**State Transitions**:
```
STABLE ↔ ACTIVE
   ↓         ↓
 No work   Phase in progress
```
