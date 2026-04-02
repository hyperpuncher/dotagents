# Command

```html
<div class="command">
  <header><input type="text" role="combobox" placeholder="Search..." /></header>
  <div role="menu">
    <div role="group" aria-labelledby="g1">
      <span role="heading" id="g1">Group</span>
      <div role="menuitem" data-keywords="search"><svg></svg><span>Item</span><kbd>⌘K</kbd></div>
    </div>
  </div>
</div>
```

Dialog: `<dialog class="command-dialog">` wraps `.command`

Attrs: `data-filter`, `data-keywords`, `data-force`, `aria-disabled`

Combobox: Same as Select with search header.
