---
name: basecoat
description: Guide for Basecoat - a Tailwind CSS v4-first component library using semantic HTML and vanilla JS. Think "shadcn/ui without a framework." Use when building UI components without React/Vue/Svelte.
---

# Basecoat

- Docs: https://basecoatui.com
- Package: `basecoat-css`

## Install

**CDN:**

```html
<link
	rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/basecoat-css@latest/dist/basecoat.cdn.min.css"
/>
<script
	src="https://cdn.jsdelivr.net/npm/basecoat-css@latest/dist/js/all.min.js"
	defer
></script>
```

**NPM:**

```bash
npm i basecoat-css
```

```css
@import "tailwindcss";
@import "basecoat-css";
```

**ESM:**

```js
import "basecoat-css/all";
// or: import "basecoat-css/tabs";
```

## JS Init

- Auto-init on `DOMContentLoaded`
- Manual: `window.basecoat.init('tabs')` or `window.basecoat.initAll()`

## Icons

Basecoat uses [Lucide icons](https://lucide.dev). Options:

1. **Copy SVG**: Visit [lucide.dev/icons](https://lucide.dev/icons), click any icon to copy SVG
2. **Install package**: `npm i lucide` - see [lucide.dev/guide/installation](https://lucide.dev/guide/installation)
3. **Framework packages**: [lucide.dev/packages](https://lucide.dev/packages) for React/Vue/Angular/etc

## Theming

Basecoat is fully compatible with [shadcn/ui themes](https://ui.shadcn.com/themes):

1. Go to [ui.shadcn.com/themes](https://ui.shadcn.com/themes) or [tweakcn.com](https://tweakcn.com)
2. Click "Copy code" and save to `theme.css`
3. Import after Basecoat:

```css
@import "tailwindcss";
@import "basecoat-css";
@import "./theme.css";
```

## Styling & Customization

**Override with Tailwind:**

```html
<button class="btn font-normal">Custom button</button>
```

**Override with custom CSS:**

```css
@import "tailwindcss";
@import "basecoat-css";
@import "./custom.css";
```

**Copy and modify source:**
Copy [basecoat.css](https://github.com/hunvreus/basecoat/blob/main/src/css/basecoat.css) into your project and customize directly.

## Tokens

Common design tokens: `background`, `foreground`, `primary`, `primary-foreground`, `secondary`, `secondary-foreground`, `accent`, `accent-foreground`, `muted`, `muted-foreground`, `card`, `card-foreground`, `popover`, `popover-foreground`, `destructive`, `ring`, `input`, `border`

## Components

### Layout & Structure

- [Accordion](references/accordion.md) - styled `<details>` element
- [Card](references/card.md) - container with header/content/footer
- [Dialog](references/dialog.md) - modal using native `<dialog>`
- [Drawer](references/dialog.md) - off-canvas dialog
- [Field](references/field.md) - form field with label/helper/error
- [Fieldset](references/field.md) - group related fields
- [Form](references/form.md) - form wrapper that styles children
- [Input Group](references/input-group.md) - input with icons/buttons

### Form Controls

- [Button](references/button.md) - button variants and sizes
- [Button Group](references/button.md) - grouped buttons
- [Checkbox](references/form.md) - checkbox input
- [Input](references/form.md) - text input
- [Label](references/form.md) - form label
- [Radio](references/form.md) - radio input
- [Select](references/select.md) - native and custom select
- [Switch](references/form.md) - toggle switch
- [Textarea](references/form.md) - multi-line input

### Navigation

- [Breadcrumb](references/breadcrumb.md) - navigation path
- [Pagination](references/navigation.md) - page navigation
- [Sidebar](references/navigation.md) - collapsible navigation
- [Table](references/navigation.md) - data table
- [Tabs](references/tabs.md) - tabbed interface

### Overlays

- [Alert Dialog](references/dialog.md) - critical confirmation dialog
- [Dropdown Menu](references/dropdown.md) - contextual menu
- [Popover](references/popover.md) - floating content panel
- [Tooltip](references/tooltip.md) - hover info popup

### Feedback

- [Alert](references/alert.md) - callout for user attention
- [Empty](references/misc.md) - empty state placeholder
- [Progress](references/misc.md) - progress bar
- [Skeleton](references/misc.md) - loading placeholder
- [Spinner](references/misc.md) - loading spinner
- [Toast](references/toast.md) - global notifications

### Command & Search

- [Command](references/command.md) - command palette
- [Combobox](references/command.md) - select with search

### Display

- [Avatar](references/avatar.md) - user image (Tailwind utilities)
- [Badge](references/badge.md) - status indicators
- [Carousel](references/carousel.md) - scrollable content
- [Chart](references/chart.md) - data visualization
- [Item](references/misc.md) - list row with icon
- [Kbd](references/misc.md) - keyboard key styling
- [Slider](references/misc.md) - range input
- [Theme Switcher](references/misc.md) - theme toggle

## Events

- `basecoat:initialized` - on component root after init
- `basecoat:popover` - on document when popover opens
- `basecoat:toast` - on document to show toast

## Rules

- Use documented classes only
- Package is `basecoat-css` (not `basecoat`)
- Interactive components need specific roles/attributes
- Framework-agnostic: no React/Radix deps
