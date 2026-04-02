# Avatar

**Not a component.** Use `<img>` with Tailwind utilities:

```html
<img class="size-8 shrink-0 object-cover rounded-full" alt="@username" src="..." />
```

**Sizes:** `size-8`, `size-10`, `size-12`

**Shapes:**

- `rounded-full` - circle
- `rounded-lg` - rounded square

**Avatar group:**

```html
<div
  class="flex -space-x-2 [&_img]:ring-background [&_img]:ring-2 [&_img]:grayscale [&_img]:size-8 [&_img]:shrink-0 [&_img]:object-cover [&_img]:rounded-full"
>
  <img alt="@user1" src="..." />
  <img alt="@user2" src="..." />
  <img alt="@user3" src="..." />
</div>
```
