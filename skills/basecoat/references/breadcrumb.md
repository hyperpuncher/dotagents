# Breadcrumb

**Not a component.** Use `<ol>` with Tailwind utilities:

```html
<ol
  class="text-muted-foreground flex flex-wrap items-center gap-1.5 text-sm break-words sm:gap-2.5"
>
  <li class="inline-flex items-center gap-1.5">
    <a href="#" class="hover:text-foreground transition-colors">Home</a>
  </li>
  <li>
    <svg class="size-3.5"><!-- chevron-right --></svg>
  </li>
  <li class="inline-flex items-center gap-1.5">
    <a href="#" class="hover:text-foreground transition-colors">Components</a>
  </li>
  <li>
    <svg class="size-3.5"><!-- chevron-right --></svg>
  </li>
  <li class="inline-flex items-center gap-1.5">
    <span class="text-foreground font-normal">Breadcrumb</span>
  </li>
</ol>
```

**With dropdown:**
Use Dropdown Menu component for ellipsis menu between items.
