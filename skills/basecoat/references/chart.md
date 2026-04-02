# Chart

**Not a component.** Use a charting library (Chart.js, D3, etc) with Basecoat styling for tooltips/legends.

Example with Chart.js:

```html
<canvas id="chart"></canvas>

<script>
  new Chart(document.getElementById("chart"), {
    type: "bar",
    data: {
      /* ... */
    },
    options: {
      plugins: {
        legend: { labels: { color: "hsl(var(--foreground))" } },
      },
    },
  });
</script>
```
