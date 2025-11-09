# UX Style Guide

**Status**: DRAFT
**Last Reviewed**: 2025-11-09

---

**Project Name**: Shannon

## Overview

<!--
Brief summary of the UI/UX design philosophy.
1-2 paragraphs explaining the visual and interaction approach.
-->

[Describe the overall UX philosophy and design principles]

**Example**:
> IdeaFlow's interface prioritizes speed and clarity. The design is minimal and distraction-free, using a light color palette with focused accents. Every interaction is designed to be fast and intuitive, with keyboard shortcuts for power users and visual clarity for newcomers.

---

## Visual Design

### Color Palette

**Primary Colors**:
- **[Color Name]**: [Hex] - [Usage]
- **[Color Name]**: [Hex] - [Usage]

**Secondary Colors**:
- **[Color Name]**: [Hex] - [Usage]

**Semantic Colors**:
- **Success**: [Hex]
- **Warning**: [Hex]
- **Error**: [Hex]
- **Info**: [Hex]

**Neutral Colors**:
- **Background**: [Hex]
- **Surface**: [Hex]
- **Text Primary**: [Hex]
- **Text Secondary**: [Hex]
- **Border**: [Hex]

**Example**:
> **Primary Colors**:
> - **Blue**: #3B82F6 (blue-500) - Primary actions, links, focus states
> - **Violet**: #8B5CF6 (violet-500) - Secondary actions, tags
>
> **Semantic Colors**:
> - **Success**: #10B981 (green-500)
> - **Warning**: #F59E0B (amber-500)
> - **Error**: #EF4444 (red-500)
> - **Info**: #3B82F6 (blue-500)
>
> **Neutral Colors**:
> - **Background**: #F9FAFB (gray-50)
> - **Surface**: #FFFFFF (white)
> - **Text Primary**: #111827 (gray-900)
> - **Text Secondary**: #6B7280 (gray-500)
> - **Border**: #E5E7EB (gray-200)

### Typography

**Font Family**:
- **Primary**: [Font name and fallbacks]
- **Monospace**: [Font name and fallbacks] (for code)

**Type Scale**:
| Element | Size | Weight | Line Height | Usage |
|---------|------|--------|-------------|-------|
| [Element] | [Size] | [Weight] | [Height] | [Usage] |

**Example**:
> **Font Family**:
> - **Primary**: Inter, -apple-system, system-ui, sans-serif
> - **Monospace**: 'Fira Code', 'Courier New', monospace
>
> **Type Scale** (1.25 ratio - Major Third):
> | Element | Size | Weight | Line Height | Usage |
> |---------|------|--------|-------------|-------|
> | Display | 48px | 700 | 1.2 | Landing page headlines |
> | H1 | 36px | 700 | 1.2 | Page titles |
> | H2 | 30px | 600 | 1.3 | Section headers |
> | H3 | 24px | 600 | 1.3 | Subsection headers |
> | Body | 16px | 400 | 1.5 | Main content |
> | Small | 14px | 400 | 1.5 | Captions, helper text |
> | Tiny | 12px | 400 | 1.5 | Metadata, timestamps |

### Spacing

**Base Unit**: [Base spacing value]

**Scale**: [List spacing values]

**Usage**:
- [Spacing value]: [When to use]
- [Spacing value]: [When to use]

**Example**:
> **Base Unit**: 4px
>
> **Scale**: 4, 8, 12, 16, 24, 32, 48, 64, 96px
>
> **Usage**:
> - 4px: Tight spacing within components
> - 8px: Default spacing between related elements
> - 16px: Spacing between component sections
> - 24px: Spacing between unrelated elements
> - 32px: Section padding
> - 48px: Major section spacing
> - 64px: Page padding (desktop)

### Elevation & Shadows

| Level | Shadow | Usage |
|-------|--------|-------|
| [Level] | [CSS shadow value] | [When to use] |

**Example**:
> | Level | Shadow | Usage |
> |-------|--------|-------|
> | 0 | none | Flat elements (buttons, inline) |
> | 1 | 0 1px 3px rgba(0,0,0,0.1) | Cards, list items |
> | 2 | 0 4px 6px rgba(0,0,0,0.1) | Dropdowns, popovers |
> | 3 | 0 10px 15px rgba(0,0,0,0.1) | Modals, drawers |
> | 4 | 0 20px 25px rgba(0,0,0,0.15) | High-priority overlays |

### Border Radius

| Size | Value | Usage |
|------|-------|-------|
| [Size] | [Value] | [Usage] |

**Example**:
> | Size | Value | Usage |
> |------|-------|-------|
> | None | 0 | Tables, strict layouts |
> | Small | 4px | Buttons, inputs, small cards |
> | Medium | 8px | Cards, panels |
> | Large | 12px | Modals, large containers |
> | Full | 9999px | Pills, badges, avatars |

---

## Layout Patterns

### Standard Page Layout

[Describe the standard page structure]

**Example**:
> **Structure**:
> ```
> ┌─────────────────────────────────────┐
> │  Header (fixed, 64px)               │
> ├──────┬──────────────────────┬───────┤
> │ Nav  │  Main Content        │ Side  │
> │ 240px│  (fluid, max 1280px) │ 320px │
> │      │                      │       │
> └──────┴──────────────────────┴───────┘
> │  Footer (sticky, 48px)              │
> └─────────────────────────────────────┘
> ```
>
> **Specifications**:
> - **Header**: Fixed top, 64px height, white background, drop shadow
> - **Navigation**: Left sidebar, 240px width, collapsible on mobile
> - **Main Content**: Center-aligned, max-width 1280px, 24px padding
> - **Sidebar**: Right sidebar, 320px width, hidden on mobile/tablet
> - **Footer**: Sticky bottom, 48px height, gray background

### Responsive Breakpoints

| Breakpoint | Width | Layout Changes |
|------------|-------|----------------|
| [Name] | [Width] | [What changes] |

**Example**:
> | Breakpoint | Width | Layout Changes |
> |------------|-------|----------------|
> | Mobile | < 640px | Single column, hide nav/sidebar, hamburger menu |
> | Tablet | 640-1024px | Hide sidebar, nav becomes drawer |
> | Desktop | > 1024px | Full layout with nav + sidebar |
> | Wide | > 1440px | Larger max-width (1280px → 1440px) |

### Grid System

**Type**: [Grid type, e.g., 12-column]

**Gutter**: [Gutter size]

**Example**:
> **Type**: 12-column grid
>
> **Gutter**: 24px (12px on mobile)
>
> **Usage**:
> - Full width: 12 columns
> - Main content + sidebar: 8 + 4 columns
> - Two-column: 6 + 6 columns
> - Three-column: 4 + 4 + 4 columns

---

## Component Patterns

<!--
Define the style and behavior of common UI components.
Include visual specifications and interaction states.
-->

### Buttons

**Variants**:
- **[Variant]**: [Description and usage]

**States**: Default, Hover, Active, Disabled, Loading

**Specifications**:
| Variant | Background | Text | Border | Height | Padding |
|---------|------------|------|--------|--------|---------|
| [Variant] | [Color] | [Color] | [Style] | [px] | [px] |

**Example**:
> **Variants**:
> - **Primary**: High-emphasis actions (e.g., "Save", "Create")
> - **Secondary**: Medium-emphasis actions (e.g., "Cancel", "Edit")
> - **Tertiary**: Low-emphasis actions (e.g., "Learn More")
> - **Danger**: Destructive actions (e.g., "Delete")
>
> **States**: Default, Hover, Active, Disabled, Loading
>
> | Variant | Background | Text | Border | Height | Padding |
> |---------|------------|------|--------|--------|---------|
> | Primary | Blue-500 | White | None | 40px | 16px 24px |
> | Secondary | Transparent | Gray-700 | Gray-300 | 40px | 16px 24px |
> | Tertiary | Transparent | Blue-500 | None | 40px | 16px 24px |
> | Danger | Red-500 | White | None | 40px | 16px 24px |
>
> **Hover**: Darken background by 10%, transition 150ms
>
> **Disabled**: 50% opacity, no pointer events

### Input Fields

**Types**: Text, Email, Password, Textarea, Select, etc.

**Specifications**:
- **Height**: [Value]
- **Padding**: [Value]
- **Border**: [Style]
- **Focus State**: [Style]

**Example**:
> **Specifications**:
> - **Height**: 40px (single-line), auto (textarea)
> - **Padding**: 8px 12px
> - **Border**: 1px solid gray-300, radius 4px
> - **Focus State**: Blue-500 ring, 2px offset
> - **Error State**: Red-500 ring, error text below
> - **Disabled State**: Gray-100 background, 50% opacity

### Cards

**Specifications**:
- **Background**: [Color]
- **Border**: [Style]
- **Padding**: [Value]
- **Shadow**: [Level]

**Example**:
> **Specifications**:
> - **Background**: White
> - **Border**: 1px solid gray-200
> - **Padding**: 24px
> - **Border Radius**: 8px
> - **Shadow**: Level 1 (default), Level 2 (hover if interactive)
> - **Hover** (if interactive): Lift slightly, transition 200ms

### Modals

**Specifications**:
- **Backdrop**: [Style]
- **Container**: [Dimensions and style]
- **Animation**: [Type and duration]

**Example**:
> **Specifications**:
> - **Backdrop**: rgba(0,0,0,0.5), blur 4px
> - **Container**: Max 600px wide, 24px padding, white background, level 3 shadow
> - **Border Radius**: 12px
> - **Animation**: Fade in backdrop (200ms), slide up modal (300ms ease-out)
> - **Close**: X button top-right, ESC key, click backdrop

---

## Interaction Patterns

### Hover States

[Define how hover states work across the UI]

**Example**:
> - **Links**: Underline on hover
> - **Buttons**: Darken background 10%, cursor pointer
> - **Cards** (interactive): Lift with shadow (level 2)
> - **List Items**: Gray-50 background
> - **Transition**: 150ms ease-out (200ms for elevation)

### Focus States

[Define how focus indicators work]

**Example**:
> - **All Interactive Elements**: 2px blue-500 ring, 2px offset
> - **Skip Links**: Visible on focus for accessibility
> - **Remove Outline**: Never use `outline: none` without alternative
> - **Tab Order**: Logical order matching visual layout

### Loading States

[Define how loading is communicated]

**Example**:
> - **Buttons**: Spinner replaces text, button stays same size, disabled
> - **Inline**: Small spinner next to content
> - **Full Page**: Centered spinner with backdrop
> - **Skeleton**: Gray rectangles in content shape (for lists, cards)

### Error States

[Define how errors are shown]

**Example**:
> - **Inline Validation**: Red ring on input, error text below in red-600
> - **Form Errors**: Error banner at top of form, scroll to first error
> - **Toasts**: Red toast top-right, auto-dismiss after 5 seconds
> - **Icon**: Red circle with exclamation for error state

---

## Accessibility

### Requirements

- **[Requirement]**: [Description]
- **[Requirement]**: [Description]

**Example**:
> - **Color Contrast**: Minimum 4.5:1 for text, 3:1 for UI components
> - **Focus Indicators**: Visible on all interactive elements
> - **Keyboard Navigation**: All functionality accessible via keyboard
> - **Screen Readers**: Proper ARIA labels and roles
> - **Motion**: Respect prefers-reduced-motion
> - **Text Size**: Supports up to 200% zoom without horizontal scroll

### ARIA Patterns

[Common ARIA patterns used in the UI]

**Example**:
> - **Buttons**: `<button>` (not `<div role="button">`)
> - **Links**: `<a href>` with meaningful text (not "click here")
> - **Forms**: Labels associated with inputs (`<label for>` or wrapping)
> - **Modals**: `role="dialog"`, `aria-modal="true"`, focus trap
> - **Dropdowns**: `aria-expanded`, `aria-haspopup`

---

## Animation

### Principles

- **[Principle]**: [Description]

**Example**:
> - **Purposeful**: Animations communicate state changes, don't just decorate
> - **Fast**: Keep under 300ms for most animations
> - **Subtle**: Prefer ease-out, avoid bouncy/elastic (unless playful)
> - **Respectful**: Honor prefers-reduced-motion

### Standard Timings

| Action | Duration | Easing | Usage |
|--------|----------|--------|-------|
| [Action] | [ms] | [Easing] | [Usage] |

**Example**:
> | Action | Duration | Easing | Usage |
> |--------|----------|--------|-------|
> | Fade | 150ms | ease-out | Opacity changes |
> | Slide | 200ms | ease-out | Drawers, dropdowns |
> | Scale | 200ms | ease-out | Modals, tooltips |
> | Elevation | 200ms | ease-out | Shadow/lift changes |
> | Color | 150ms | ease-out | Background, text color |

---

## Icons

**Icon Set**: [Name and source]

**Size Scale**: [List sizes]

**Usage**:
- [Guideline]

**Example**:
> **Icon Set**: Heroicons (https://heroicons.com)
>
> **Size Scale**: 16px, 20px, 24px
>
> **Usage**:
> - 16px: Inline with text, tight spaces
> - 20px: Buttons, form inputs, list items
> - 24px: Headers, large buttons, empty states
> - Stroke width: 2px (outline style)
> - Color: Inherit from text color

---

## Version History

<!--
Track significant changes to the UX style guide.
Format: ### YYYY-MM-DD - v[version]
Always include status (DRAFT or APPROVED with date)
-->

### [YYYY-MM-DD] - v1.0
- Initial UX style guide created
- Status: DRAFT (pending review)

**Example**:
> ### 2025-10-21 - v1.1
> - Updated color palette (added violet)
> - Changed border radius scale
> - Added animation timing guidelines
> - Status: DRAFT (pending review)
>
> ### 2025-10-06 - v1.0
> - Initial UX style guide created
> - Status: APPROVED (2025-10-07)

---

## Notes for Using This Template

**During `/project-setup`**:
1. Replace all `[placeholders]` with actual content
2. Remove example blocks (marked with "**Example**:")
3. Remove this "Notes for Using This Template" section
4. Set Status to DRAFT
5. Update "Last Reviewed" to current date

**Key Reminders**:
- Be **specific** with values (exact colors, sizes, timings)
- Show **visual examples** where possible
- Document **all states** (default, hover, active, disabled, etc.)
- Define **responsive behavior** clearly
- Consider **accessibility** from the start
- Link to **component library** or design system if one exists

**What Goes Here vs. Other Docs**:
- ✅ Visual design (colors, typography, spacing)
- ✅ Layout patterns and responsive behavior
- ✅ Component specifications (buttons, forms, etc.)
- ✅ Interaction and animation guidelines
- ✅ Accessibility requirements
- ❌ Technical implementation (→ technical_design.md)
- ❌ Code patterns for UI (→ code_style_guide.md)
- ❌ User flows/wireframes (→ knowledge notes)
