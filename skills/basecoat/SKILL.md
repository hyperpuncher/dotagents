---
name: basecoat
description: Guide for Basecoat - a framework-agnostic, Tailwind CSS v4-first component library built with semantic HTML and vanilla JS. Think "shadcn/ui without a framework." Use when the user wants to build UI components, style forms, or create interactive elements (tabs, popovers, selects) without React/Vue/Svelte. Covers installation, theming, CSS-only and JS-enhanced components, accessibility, and troubleshooting.
---

# Basecoat UI

- Basecoat docs: https://basecoatui.com
- Package: `basecoat-css`

## Installation

### CDN (no build tool)

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

For per-component JS, include `basecoat.min.js` then component files like `tabs.min.js`, `select.min.js`, etc.

### NPM (Tailwind projects)

```bash
npm i basecoat-css
```

In your CSS:

```css
@import "tailwindcss";
@import "basecoat-css";
```

### ESM imports

```js
import "basecoat-css/all";
// or cherry-pick:
import "basecoat-css/tabs";
import "basecoat-css/select";
import "basecoat-css/popover";
import "basecoat-css/dropdown-menu";
import "basecoat-css/sidebar";
import "basecoat-css/toast";
```

## JavaScript initialization

- Auto‑initializes on `DOMContentLoaded`; observes DOM for new nodes
- Manual re‑init: `window.basecoat.init('<name>')` or `window.basecoat.initAll()`

## Theming

- Tailwind projects: override design tokens (e.g., `primary`, `muted-foreground`) in your theme
- CDN: add CSS overrides after the link tag

## Design tokens

Common semantic tokens: `background`, `foreground`, `primary`, `primary-foreground`, `secondary`, `secondary-foreground`, `accent`, `accent-foreground`, `muted`, `muted-foreground`, `card`, `card-foreground`, `popover`, `popover-foreground`, `destructive`, `ring`, `input`, `border`

## Components

### Alert

Alerts inform users about important events.

```html
<div role="alert" class="alert">{CONTENT}</div>
<!-- Destructive variant: -->
<div role="alert" class="alert alert-destructive">{CONTENT}</div>
```

### Avatar

User thumbnail with fallback.

```html
<div class="avatar"><img src="{image-url}" alt="{alt}" /></div>
```

### Badge

Status indicators and counts.

```html
<span class="badge">{TEXT}</span>
<span class="badge badge-outline">{TEXT}</span>
<span class="badge badge-destructive">{TEXT}</span>
```

### Button

```html
<button class="btn">{CONTENT}</button>
<!-- Styles: btn-primary, btn-secondary, btn-outline, btn-ghost, btn-link, btn-destructive -->
<!-- Sizes: btn-sm, btn-lg -->
<!-- Icon: btn-icon, btn-sm-icon, btn-lg-icon -->
<button class="btn btn-primary btn-sm" disabled>{CONTENT}</button>
```

Use `aria-pressed="true"` for toggle buttons.

### Button Group

```html
<div class="button-group" data-orientation="horizontal|vertical">
	<button class="btn">A</button>
	<hr role="separator" />
	<button class="btn">B</button>
</div>
```

### Card

```html
<article class="card">
	<header>
		<h2>{TITLE}</h2>
		<p>{SUBTITLE}</p>
	</header>
	<section>{CONTENT}</section>
	<footer>{ACTIONS}</footer>
</article>
```

### Checkbox (CSS)

```html
<input type="checkbox" class="input" />
```

### Radio Group (CSS)

```html
<label><input type="radio" class="input" name="{name}" /> {LABEL}</label>
```

### Switch (CSS)

```html
<input type="checkbox" role="switch" class="input" />
```

### Input

```html
<input type="text" class="input" placeholder="{Placeholder}" />
```

### Textarea

```html
<textarea class="textarea" rows="{n}"></textarea>
```

### Label

```html
<label class="label" for="{id}">{TEXT}</label>
```

### Select (JS)

Requires JS. Custom select with searchable popover and listbox.

```html
<div class="select">
	<button type="button" aria-expanded="false"><span>{LABEL}</span></button>
	<input type="hidden" name="{name}" value="{value}" />
	<section data-popover aria-hidden="true">
		<header><input type="text" placeholder="Filter" /></header>
		<div role="listbox">
			<div role="option" data-value="{value}" data-label="{label}">{label}</div>
		</div>
	</section>
</div>
```

Dispatches `change` on root with `detail.value`. Disabled options use `aria-disabled="true"`.

### Combobox (JS)

Typeahead component with similar structure to Select.

### Tabs (JS)

```html
<div class="tabs">
	<div role="tablist">
		<button role="tab" aria-controls="panel-1" aria-selected="true" tabindex="0">
			Tab 1
		</button>
		<button role="tab" aria-controls="panel-2" aria-selected="false" tabindex="-1">
			Tab 2
		</button>
	</div>
	<section id="panel-1" role="tabpanel">...</section>
	<section id="panel-2" role="tabpanel" hidden>...</section>
</div>
```

Arrow keys move focus; keep `aria-controls` and `aria-selected` accurate.

### Popover (JS)

```html
<div class="popover">
	<button type="button">{TRIGGER}</button>
	<section data-popover aria-hidden="true">{CONTENT}</section>
</div>
```

Toggling sets `aria-hidden` on content and `aria-expanded` on trigger.

### Dropdown Menu (JS)

```html
<div class="dropdown-menu">
	<button type="button">{TRIGGER}</button>
	<div role="menu">
		<button role="menuitem">{ITEM}</button>
	</div>
</div>
```

Uses `basecoat:popover` to coordinate with other popovers.

### Command (JS)

Command palette with search and results.

```html
<div class="command">
	<header><input type="text" placeholder="Search" /></header>
	<div role="menu">
		<button role="menuitem">{ITEM}</button>
	</div>
</div>
```

Wrapper variant: `command-dialog` for Command in a dialog.

### Dialog (CSS/Native)

Styled native `<dialog>` element. Use `.command-dialog` variant to wrap `.command`.

### Alert Dialog (CSS/Native)

Confirm/cancel flow using `<dialog>` semantics.

### Drawer (CSS/Native)

Off-canvas using `<dialog>`/popover.

### Toast (JS)

Global notifications container:

```html
<section id="toaster"></section>
```

Show a toast:

```js
document.dispatchEvent(
	new CustomEvent("basecoat:toast", {
		detail: {
			config: {
				title: "Saved",
				description: "Changes persisted",
				category: "success",
			},
		},
	}),
);
```

### Sidebar (JS)

```html
<nav class="sidebar">
	<!-- Collapsible items with aria-current="page" for active link -->
</nav>
```

### Breadcrumb (CSS)

```html
<nav class="breadcrumb">
	<ol>
		...
	</ol>
</nav>
```

### Pagination (CSS)

```html
<nav class="pagination">...</nav>
```

### Table (CSS)

```html
<table class="table">
	...
</table>
```

### Progress (CSS)

```html
<div class="progress">...</div>
```

### Slider (CSS)

```html
<input type="range" class="slider" />
```

### Spinner (CSS)

```html
<div class="spinner"></div>
```

### Skeleton (CSS)

```html
<div class="skeleton"></div>
```

### Kbd (CSS)

```html
<kbd class="kbd">⌘K</kbd>
```

### Item (CSS)

List rows with icons and actions.

```html
<div class="item">...</div>
```

### Empty State (CSS)

```html
<div class="empty">...</div>
```

### Field (CSS)

Wrapper for label, input, hint, error.

```html
<div class="field">
	<label class="label">...</label>
	<input class="input" />
	<span class="hint">...</span>
</div>
```

### Form (CSS)

Form layout and validation styling patterns.

### Input Group (CSS)

Grouped input patterns.

### Theme Switcher (JS-lite)

```html
<div class="theme-switcher">...</div>
```

## Events

| Event                  | Target         | Description                                   |
| ---------------------- | -------------- | --------------------------------------------- |
| `basecoat:initialized` | Component root | Emitted after a component initializes         |
| `basecoat:popover`     | Document       | Closes other popovers when one opens          |
| `basecoat:toast`       | Document       | Creates a toast with `{ detail: { config } }` |

## Accessibility

- Use semantic roles and ARIA attributes per component examples
- Keep `aria-*` for semantics and `data-*` for visual states
- Disabled items must use `disabled` or `aria-disabled="true"` to be filtered from interactions

## Common Pitfalls

- Do not invent class names; use documented classes only
- The package name is `basecoat-css` (not `basecoat` or `@basecoat/css`)
- Interactive components require specific roles/attributes
- Basecoat is framework-agnostic; don't add React/Radix dependencies

## Troubleshooting

If interactivity doesn't work:

1. Ensure the component's JS is loaded
2. Verify required roles/IDs match the examples
3. For dynamic content, call `window.basecoat.init('<name>')` or `initAll()` after insertion

## License

MIT (see LICENSE.md)
