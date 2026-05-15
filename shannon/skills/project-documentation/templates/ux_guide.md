# UX Guide

**Status**: DRAFT
**Last Reviewed**: [YYYY-MM-DD]

---

**Project Name**: [Name of the product]

## Design Principles

[Core UX philosophy aligned to vision principles. The values that resolve trade-offs when two designs feel equally reasonable.]

### 1. **[Principle]**

[What this principle means, and how it shapes design choices.]

### 2. **[Principle]**

[What this principle means, and how it shapes design choices.]

---

## Colour System

[Palette, semantic colours, and accessibility commitments. Define roles, not just hex values.]

### Brand

- **[Name]** — `#XXXXXX` — [Where this colour is used]

### Semantic

- **Success** — `#XXXXXX`
- **Warning** — `#XXXXXX`
- **Error** — `#XXXXXX`
- **Info** — `#XXXXXX`

### Neutral

- **Background** — `#XXXXXX`
- **Surface** — `#XXXXXX`
- **Text primary** — `#XXXXXX`
- **Text secondary** — `#XXXXXX`
- **Border** — `#XXXXXX`

### Contrast

[Minimum contrast ratios committed to (e.g. WCAG AA 4.5:1 for body, 3:1 for large text and UI components).]

---

## Typography

[Font families, sizes, hierarchy, and line-height rules. Use semantic names (Body, H1, Caption), not pixel grids.]

- **Primary font** — [Family, fallback stack]
- **Monospace** — [Family, fallback stack]

### Scale

| Role | Size | Weight | Line-height |
|---|---|---|---|
| H1 | | | |
| H2 | | | |
| Body | | | |
| Caption | | | |

---

## Layout Patterns

[Page structures, spacing scale, grid, and responsive behaviour. The rules that make screens feel consistent without dictating every screen.]

### Spacing Scale

- [Token — size — typical use]

### Breakpoints

- [Name — width — when to switch layout]

### Common Layouts

- [Pattern — when to reach for it]

---

## Component Library

[Standard UI elements and their usage. One entry per component with purpose, key states, and rules about when to use it.]

### [Component]

- **Purpose**: [Role in the interface]
- **States**: [Default, hover, focus, disabled, loading, error]
- **Use when**: [The cases this component fits]
- **Avoid when**: [Cases that need a different component]

---

## Interaction Patterns

[Common behaviours, feedback, and state transitions. The shared vocabulary for how the product responds.]

- **Feedback** — [How the UI acknowledges user actions]
- **Loading** — [How loading states are shown]
- **Errors** — [How errors are surfaced]
- **Empty states** — [How empty data is presented]
- **Destructive actions** — [Confirmation and recovery patterns]

---

## Accessibility

[Standards and requirements. What must be true of every screen we ship.]

- **WCAG level**: [AA / AAA — what we commit to]
- **Keyboard**: [Every interactive element reachable and operable via keyboard]
- **Screen readers**: [Semantic markup, ARIA where necessary]
- **Motion**: [Respect `prefers-reduced-motion`]
- **Colour**: [Never the sole signal for meaning]

---

## Version History

### [YYYY-MM-DD] - v1.0

- Initial UX guide created
- Status: DRAFT

---

## What Belongs Here (and What Doesn't)

✅ Design principles aligned to vision
✅ Colour, typography, spacing, components, interaction patterns
✅ Accessibility commitments

❌ Wireframes or mockups (those live in design tools)
❌ Implementation code (→ codebase)
❌ User research findings (→ inputs to vision)
❌ Screen-by-screen specifications (→ feature/epic/task docs)
