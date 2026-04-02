# Input Group

**Not a component.** Use relative/absolute positioning with Tailwind:

```html
<div class="relative">
  <input type="text" class="input pl-9" placeholder="Search..." />
  <div class="absolute left-3 top-1/2 -translate-y-1/2 pointer-events-none">
    <svg><!-- icon --></svg>
  </div>
</div>
```

**With button:**

```html
<div class="relative">
  <input type="text" class="input pr-9" placeholder="..." />
  <button class="absolute right-1.5 top-1/2 -translate-y-1/2 btn-icon-ghost size-6">
    <svg><!-- icon --></svg>
  </button>
</div>
```

**With text:**

```html
<div class="relative">
  <input type="text" class="input pl-7" placeholder="0.00" />
  <div class="absolute left-3 top-1/2 -translate-y-1/2 text-muted-foreground">$</div>
</div>
```
