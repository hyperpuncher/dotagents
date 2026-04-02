# Alert

```html
<div class="alert">
  <svg><!-- icon --></svg>
  <h2>Success! Your changes have been saved</h2>
  <section>This is an alert with icon, title and description.</section>
</div>
```

**Destructive:**

```html
<div class="alert-destructive">
  <svg><!-- icon --></svg>
  <h2>Something went wrong!</h2>
  <section>
    <p>Your session has expired.</p>
    <ul class="list-inside list-disc text-sm">
      <li>Check your card details</li>
    </ul>
  </section>
</div>
```

**Structure:**

- `<div class="alert">` or `<div class="alert-destructive">` - container
- `<svg>` (optional) - icon
- `<h2>` - title
- `<section>` (optional) - description
