# Field

Form field container with label, input, helper text, and error.

```html
<div role="group" class="field">
  <label for="id">Label</label>
  <input id="id" type="text" aria-describedby="help-id" />
  <p id="help-id">Helper text</p>
</div>
```

**Error state:**

```html
<div role="group" class="field">
  <label for="id">Label</label>
  <input id="id" type="text" aria-invalid="true" aria-describedby="error-id" />
  <p id="error-id" role="alert">Error message</p>
</div>
```

**Horizontal layout:**

```html
<div role="group" class="field" data-orientation="horizontal">
  <section>
    <label for="id">Label</label>
    <p>Description</p>
  </section>
  <input id="id" type="text" />
</div>
```

# Fieldset

Group related fields:

```html
<fieldset class="fieldset">
  <legend>Group Title</legend>
  <p>Description</p>

  <div role="group" class="field">...</div>
  <div role="group" class="field">...</div>
</fieldset>
```
