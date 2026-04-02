# Kbd

**Not a component.** Use `<kbd>` element:

```html
<kbd>/</kbd> <kbd class="bg-muted px-2 py-0.5 rounded">⌘K</kbd>
```

# Progress

**Not a component.** HTML composition:

```html
<div class="bg-primary/20 relative h-2 w-full overflow-hidden rounded-full">
  <div class="bg-primary h-full" style="width: 60%"></div>
</div>
```

# Skeleton

**Not a component.** Use `animate-pulse`:

```html
<div class="bg-accent animate-pulse rounded-md h-4 w-[200px]"></div>
<div class="bg-accent animate-pulse size-10 rounded-full"></div>
```

# Slider

**Not a component.** Native range input with CSS:

```html
<input type="range" class="w-full accent-primary" />
```

With JS for custom styling:

```js
const slider = document.querySelector('input[type="range"]');
const updateSlider = (el) => {
  const min = parseFloat(el.min || 0);
  const max = parseFloat(el.max || 100);
  const value = parseFloat(el.value);
  const percent = ((value - min) / (max - min)) * 100;
  el.style.setProperty("--slider-value", `${percent}%`);
};
slider.addEventListener("input", (e) => updateSlider(e.target));
```

# Spinner

**Not a component.** Use Lucide `loader-circle` icon with `animate-spin`:

```html
<!-- Basic -->
<svg class="size-4 animate-spin" role="status" aria-label="Loading">...</svg>

<!-- Sizes: size-3, size-4, size-6, size-8 -->
<svg class="size-6 animate-spin text-primary" role="status" aria-label="Loading">...</svg>

<!-- In button -->
<button class="btn-sm" disabled>
  <svg class="animate-spin size-4" role="status">...</svg>
  Loading...
</button>
```

# Empty

**Not a component.** HTML composition pattern:

```html
<div class="flex flex-col items-center justify-center gap-6 rounded-lg border-dashed p-12">
  <header class="flex max-w-sm flex-col items-center gap-3">
    <div class="bg-muted flex size-12 items-center justify-center rounded-lg">
      <svg><!-- icon --></svg>
    </div>
    <h3 class="text-lg font-semibold">No Projects Yet</h3>
    <p class="text-muted-foreground text-sm">Get started by creating your first project.</p>
  </header>
  <section class="flex gap-2">
    <button class="btn">Create Project</button>
    <button class="btn-outline">Import</button>
  </section>
</div>
```

# Item

**Not a component.** Use `<article>` or `<a>` with flex layout:

```html
<article class="group flex items-center border rounded-md p-4 gap-4">
  <div class="flex size-8 items-center justify-center rounded bg-muted">
    <svg class="size-4"><!-- icon --></svg>
  </div>
  <div class="flex-1 flex flex-col gap-1">
    <h3 class="text-sm font-medium">Title</h3>
    <p class="text-muted-foreground text-sm">Description</p>
  </div>
  <button class="btn-sm-outline">Action</button>
</article>
```

Variants: `border-transparent bg-muted/50` (muted), `border` (outline)

# Theme Switcher

**Not a component.** Use `data-theme` attributes:

```html
<button data-theme="light">Light</button>
<button data-theme="dark">Dark</button>
<button data-theme="system">System</button>
```

Requires custom JS to toggle class on `<html>` element.
