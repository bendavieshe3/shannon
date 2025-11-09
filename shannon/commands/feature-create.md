# /feature-create

Create a new feature in the feature tracking system.

## Usage

```
/feature-create
```

## What it does

1. **Gather feature information**:
   - Feature name (aspirational - what the product IS, not what you're building)
     * ✅ "Secures User Data" (capability)
     * ❌ "Build Authentication System" (project task)
   - Type: Core Capability | Enhancement | Infrastructure
   - product requirements reference (which section does this implement?)
   - Tags (#core, #backend, #frontend, etc.)

2. **Generate feature ID**:
   - Read ./docs/features/feature_index.md to find highest FEAT-XXX
   - Generate next ID (e.g., if highest is FEAT-005, create FEAT-006)

3. **Create feature file** from template:
   - Copy ./docs/features/FEAT-XXX.md (deployed template)
   - Save as ./docs/features/FEAT-{XXX}-{slug}.md
   - Fill in:
     * ID, Feature Name, Type, product requirements Reference
     * State = STABLE (no active work yet)
     * Created and Last Reviewed dates

4. **Gather product vision**:
   - Ask: "What capability does this provide to users?"
   - Fill "Product Vision" section (aspirational, product-focused)

5. **Define ideal state**:
   - Ask: "What does this feature look like when fully mature?"
   - Fill "Ideal State" section (north star, may take years)

6. **Initial user stories**:
   - Ask: "What are the high-level user stories for this feature?"
   - Add to "User Stories" section
   - Use format: "As a [user], I want [capability], So that [benefit]"

7. **Update feature index**:
   - Add to ./docs/features/feature_index.md:
     ```
     - [FEAT-XXX](./FEAT-XXX-slug.md) - STABLE - Feature Name #tags
     ```

8. **Update product requirements**:
   - If feature implements a product requirements section, add feature reference:
     ```
     **Features**: FEAT-XXX, FEAT-YYY
     ```

9. **Confirm creation**:
   - Show feature ID and location
   - State is STABLE (no active work)
   - Next step: Use `/feature-phase-plan FEAT-XXX 1` to plan Phase 1

## Example

```
/feature-create
```

Prompts for:
- Name: "Secures User Data"
- Type: Core Capability
- product requirements ref: § "User Authentication"
- Tags: #core #backend
- Vision: "Users need secure authentication to protect their data"
- Ideal state: Email/password, OAuth, MFA, WebAuthn, enterprise SSO
- User stories: Secure login, multi-device access, etc.

Creates: `./docs/features/FEAT-001-secures-user-data.md`

## Notes

- Features are persistent (they describe what the product IS)
- Features cycle between STABLE ↔ ACTIVE as phases are worked on
- Start with STABLE state (no phases planned yet)
- Use `/feature-phase-plan` to plan Phase 1
- Features can have multiple phases over time (Phase 1, 2, 3, ...)
