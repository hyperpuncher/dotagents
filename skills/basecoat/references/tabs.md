# Tabs

```html
<div class="tabs">
  <nav role="tablist">
    <button role="tab" id="t1" aria-controls="p1" aria-selected="true">Tab 1</button>
    <button role="tab" id="t2" aria-controls="p2" aria-selected="false">Tab 2</button>
  </nav>
  <div role="tabpanel" id="p1" aria-labelledby="t1">...</div>
  <div role="tabpanel" id="p2" aria-labelledby="t2" hidden>...</div>
</div>
```
