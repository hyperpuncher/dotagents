# Accordion

**Not a component.** Use styled `<details>` elements with vanilla JS:

```html
<section class="accordion">
  <details class="group border-b">
    <summary class="w-full">
      <h2 class="flex items-center justify-between py-4">
        Title
        <svg class="transition-transform group-open:rotate-180"><!-- chevron --></svg>
      </h2>
    </summary>
    <section class="pb-4">Content</section>
  </details>
</section>

<script>
  // Close others when one opens
  document.querySelectorAll(".accordion").forEach((acc) => {
    acc.addEventListener("click", (e) => {
      const summary = e.target.closest("summary");
      if (!summary) return;
      const details = summary.closest("details");
      acc.querySelectorAll("details").forEach((d) => {
        if (d !== details) d.removeAttribute("open");
      });
    });
  });
</script>
```
