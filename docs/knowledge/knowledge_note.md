# [Title]

**Type**: Research | Implementation Detail | [Document-Type]-Extra
**Related To**: [Mandated doc section, feature, or task reference]
**Tags**: #tag1 #tag2 #FEAT-XXX #TASK-YYY (if applicable)
**Created**: [YYYY-MM-DD]
**Last Updated**: [YYYY-MM-DD]

---

## Topics Covered

<!--
List the main topics/questions this note addresses.
Helps with discovery and understanding scope.
-->

- [Topic 1]
- [Topic 2]
- [Topic 3]

**Example**:
> - OAuth 2.0 vs JWT authentication patterns
> - Security considerations for SPA authentication
> - Token storage strategies (localStorage vs httpOnly cookies)
> - Refresh token rotation

---

## Summary

<!--
OPTIONAL: 2-3 sentence high-level summary.
Remove if note is short enough to not need it.
-->

[Brief summary of key findings or implementation approach]

**Example**:
> OAuth 2.0 with PKCE provides better security for SPAs than traditional OAuth or JWT-only approaches. This note compares the approaches, recommends OAuth with PKCE for our use case, and documents the implementation strategy including token refresh and error handling.

---

## Main Content

<!--
The primary knowledge content.
Structure depends on note type:
- Research: Comparison, findings, recommendation
- Implementation Detail: Technical approach, code patterns, gotchas
- Doc-Extra: Extended information that doesn't fit mandated doc scope
-->

[Detailed information, organized by subsections as needed]

**Research Note Example**:
> ### OAuth 2.0 with PKCE
>
> **What it is**: OAuth 2.0 with Proof Key for Code Exchange, designed for public clients (SPAs, mobile)
>
> **How it works**:
> 1. Client generates code verifier (random string)
> 2. Client creates code challenge (hash of verifier)
> 3. Authorization request includes challenge
> 4. Auth server returns authorization code
> 5. Token request includes original verifier
> 6. Server validates verifier matches challenge
>
> **Pros**:
> - No client secret needed (safe for SPAs)
> - Protects against authorization code interception
> - Industry standard for modern SPAs
>
> **Cons**:
> - More complex than simple JWT
> - Requires token storage (session management)
>
> ### JWT (Stateless Tokens)
>
> **What it is**: Self-contained tokens with user info and signature
>
> [... similar structure for JWT]
>
> ### Comparison
>
> | Feature | OAuth + PKCE | JWT Only |
> |---------|-------------|----------|
> | Security | Excellent | Good (if done right) |
> | Revocability | Yes (server sessions) | No (stateless) |
> | Complexity | Medium | Low |
> | Standards | OAuth 2.0 spec | Ad-hoc |
>
> ### Recommendation
>
> **Use OAuth 2.0 with PKCE** for our SPA because:
> - Need revocability (logout, ban user, etc.)
> - Security is critical (user data)
> - Worth the complexity for long-term maintainability

**Implementation Detail Example**:
> ### Token Storage Strategy
>
> **Chosen Approach**: httpOnly cookies for refresh token, memory for access token
>
> **Implementation**:
> ```python
> # Backend: Set httpOnly cookie with refresh token
> response.set_cookie(
>     key="refresh_token",
>     value=refresh_token,
>     httponly=True,
>     secure=True,  # HTTPS only
>     samesite="lax",
>     max_age=30 * 24 * 60 * 60  # 30 days
> )
> ```
>
> **Frontend**: Store access token in memory only
> ```typescript
> // Never localStorage - XSS vulnerable
> // Store in React state or context
> const [accessToken, setAccessToken] = useState<string | null>(null);
> ```
>
> **Token Refresh Flow**:
> 1. Access token expires (30 min lifetime)
> 2. API call fails with 401
> 3. Frontend calls `/auth/refresh` (sends httpOnly cookie automatically)
> 4. Backend validates refresh token, issues new access token
> 5. Frontend retries original request with new token
>
> ### Error Handling Patterns
>
> **Expired Access Token**:
> ```typescript
> async function apiCall(endpoint: string) {
>   try {
>     return await fetch(endpoint, {
>       headers: { Authorization: `Bearer ${accessToken}` }
>     });
>   } catch (error) {
>     if (error.status === 401) {
>       // Try refresh
>       const newToken = await refreshAccessToken();
>       setAccessToken(newToken);
>       // Retry original request
>       return await fetch(endpoint, {
>         headers: { Authorization: `Bearer ${newToken}` }
>       });
>     }
>     throw error;
>   }
> }
> ```
>
> **Expired Refresh Token**:
> - Redirect to login
> - Clear any stored tokens
> - Show "Session expired" message
>
> ### Gotchas
>
> - **CORS**: Refresh endpoint must accept credentials (`credentials: 'include'`)
> - **Race Conditions**: Multiple 401s can cause multiple refresh attempts - use mutex/lock
> - **Token Rotation**: Consider rotating refresh token on each use for security

---

## Local Considerations

<!--
OPTIONAL: Project-specific notes, environment-specific details.
How this general knowledge applies specifically to your project.
Remove if not applicable.
-->

[Project-specific adaptations or notes]

**Example**:
> ### Our Specific Choices
>
> - **Session backend**: Redis (for fast access, auto-expiry)
> - **Access token lifetime**: 30 minutes (balance security vs. UX)
> - **Refresh token lifetime**: 30 days (re-login after 1 month inactive)
> - **OAuth providers**: Google and GitHub (most requested by users)
>
> ### Deviations from Standard
>
> - Using Redis sessions instead of pure JWT (need revocability)
> - Shorter access token lifetime than typical (30 min vs 1 hour) - more secure

---

## Related Documentation

<!--
Links to mandated docs, features, tasks, or other knowledge notes.
Bidirectional linking helps with navigation.
-->

- **Mandated Docs**: [Which mandated docs reference this or are referenced by this]
- **Features**: [Related feature IDs]
- **Tasks**: [Related task IDs]
- **Knowledge Notes**: [Related knowledge notes]

**Example**:
> - **Mandated Docs**:
>   - technical_design.md § "Authentication"
>   - technology_stack.md § "Libraries > Authlib"
> - **Features**: FEAT-001 (Secures User Data)
> - **Tasks**: TASK-045 (Implement OAuth flow), TASK-046 (Add error handling)
> - **Knowledge Notes**:
>   - knowledge/research/session-storage-comparison.md
>   - knowledge/implementation-details/redis-session-config.md

---

## Sources

<!--
Where this information came from.
Important for research notes to evaluate reliability.
-->

- [Source 1: URL, doc, conversation, etc.]
- [Source 2]
- [Source 3]

**Example**:
> - OAuth 2.0 RFC: https://datatracker.ietf.org/doc/html/rfc6749
> - PKCE RFC: https://datatracker.ietf.org/doc/html/rfc7636
> - OWASP SPA Security: https://cheatsheetseries.owasp.org/cheatsheets/...
> - Authlib documentation: https://docs.authlib.org/
> - Internal discussion with team on 2025-10-15
> - Local testing results (see benchmarks in code)

---

## Change Log

<!--
OPTIONAL: Track significant updates to this note.
Remove if note is simple/stable.
-->

- **[YYYY-MM-DD]**: [What changed]
- **[YYYY-MM-DD]**: [What changed]

**Example**:
> - **2025-10-21**: Added token rotation strategy
> - **2025-10-15**: Updated error handling patterns based on TASK-046 implementation
> - **2025-10-06**: Initial note created

---

## Notes for Using This Template

**During `/document` or manual creation**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Remove optional sections if not needed
5. Choose appropriate Type (Research, Implementation Detail, or Doc-Extra)
6. Add to knowledge_index.md after creating

**Note Types**:
- **Research**: Comparisons, evaluations, decisions (not yet project-specific)
- **Implementation Detail**: Specific technical approaches, code patterns (project-specific)
- **[Doc]-Extra**: Extensions of mandated documents (e.g., technical-design-extra)

**Good Knowledge Notes**:
- Focused on one topic
- Include enough context to understand without reading other docs
- Show code examples where relevant
- Explain "why" not just "what"
- Include sources for research
- Link bidirectionally (from note to docs, from docs to note)

**What Goes in Knowledge Notes**:
- ✅ Detailed technical implementation
- ✅ Code examples and patterns
- ✅ Research and comparisons
- ✅ Troubleshooting guides
- ✅ Design decisions with rationale
- ❌ High-level architecture (→ technical_design.md)
- ❌ Product requirements (→ product_requirements.md)
