# Toast

```html
<section id="toaster"></section>
```

```js
document.dispatchEvent(
  new CustomEvent("basecoat:toast", {
    detail: { config: { title: "Saved", description: "...", category: "success" } },
  }),
);
```

Categories: `success`, `error`, `warning`, `info`
