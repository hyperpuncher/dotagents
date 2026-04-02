# Select

Native:

```html
<select class="select">
  <optgroup label="Group"><option>Item</option></optgroup>
</select>
```

Custom (JS):

```html
<div class="select">
  <button aria-haspopup="listbox"><span>Label</span></button>
  <input type="hidden" name="f" value="" />
  <div data-popover>
    <header><input type="text" placeholder="Search..." /></header>
    <div role="listbox">
      <div role="option" data-value="v">Label</div>
      <div role="group"><span role="heading">G</span>...</div>
    </div>
  </div>
</div>
```

Methods: `.value`, `.select(v)`, `.deselect(v)`, `.toggle(v)`, `.selectAll()`, `.selectNone()`
