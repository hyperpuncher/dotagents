# Dialog

```html
<dialog class="dialog" id="dlg" onclick="if(event.target===this)this.close()">
  <article>
    <header>
      <h2>Title</h2>
      <p>Desc</p>
    </header>
    <section><!-- content --></section>
    <footer>
      <button onclick="this.closest('dialog').close()">Close</button>
    </footer>
  </article>
</dialog>
```

Alert Dialog: Same but no close button, no backdrop click to close.

Drawer: Use `class="drawer"` instead.
