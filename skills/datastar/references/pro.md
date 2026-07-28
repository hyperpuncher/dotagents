# datastar pro

Datastar Pro is commercially licensed. Confirm that the project or organization has a valid license before using it. Do not redistribute the Pro source or bundles. Download version-matched bundles from the signed-in Pro download page and host them inside the licensed application.

The full bundle is typically imported from a project-owned path:

```html
<script type="module" src="/bundles/datastar-pro.js"></script>
```

The Pro bundle contains core Datastar plus Pro plugins. Do not load mismatched core and Pro versions together. The Pro bundler can produce a smaller custom bundle containing only selected plugins.

## attributes

### animation

`data-animate` animates numeric element attributes, including values with matching units. It reacts when expression dependencies change.

```html
<svg data-signals:radius="20" viewBox="0 0 200 200">
	<circle
		cx="100"
		cy="100"
		r="20"
		data-animate:r__duration.500ms__ease.outcubic="$radius"
	></circle>
</svg>
```

It supports keyed and object forms. Available modifiers include `__duration`, `__delay`, `__ease`, `__loop`, and `__pingpong`. Both ends must use the same suffix, such as `px`, `%`, or no suffix. Start with documented easing names from the project's version; common names include `linear`, `inquad`, `outquad`, `inoutquad`, `incubic`, `outcubic`, `inoutcubic`, `insine`, `outsine`, `inoutsine`, `inelastic`, `outelastic`, `inoutelastic`, `inback`, `outback`, `inoutback`, `inbounce`, `outbounce`, and `inoutbounce`.

### validation and media

```html
<form data-signals="{password: '', confirmation: ''}">
	<input type="password" data-bind:password />
	<input
		type="password"
		data-bind:confirmation
		data-custom-validity="$password === $confirmation ? '' : 'passwords must match'"
	/>
	<button type="submit">save</button>
</form>
```

`data-custom-validity` passes its string result to the browser's custom validity mechanism. An empty string means valid.

```html
<div
	data-match-media:is-dark="'prefers-color-scheme: dark'"
	data-computed:theme="$isDark ? 'dark' : 'light'"
></div>
```

`data-match-media:name` creates and maintains a boolean signal. It supports the normal signal-name `__case` modifier.

### animation frame and resize

```html
<div data-on-raf__throttle.16ms="$frames++"></div>
<div data-on-resize__debounce.200ms="$width = el.clientWidth"></div>
```

- `data-on-raf` runs every animation frame and supports `__throttle`.
- `data-on-resize` runs when dimensions change and supports `__debounce` and `__throttle`.
- timing tags support `.500ms` and `.1s`; debounce/throttle edge tags match core event modifiers.

### persistence

```html
<div data-persist="{include: /^preferences\./, exclude: /token$/}"></div>
<div data-persist:checkout__session="{include: /^cart\./}"></div>
```

`data-persist` stores matching signals in local storage under `datastar` by default. Add a key after `:` for a custom storage key. `__session` uses session storage. Never persist secrets or authoritative security state.

### query strings and URLs

```html
<div
	data-signals="{search: '', page: 1}"
	data-query-string__filter__history="{include: /^(search|page)$/}"
></div>
```

`data-query-string` synchronizes matching signals with URL query parameters. `__filter` omits empty values; `__history` pushes history entries and restores values on `popstate`.

```html
<div data-replace-url="`/products?page=${$page}`"></div>
```

`data-replace-url` replaces the current URL without a reload. Prefer normal links for page/resource navigation; use this only when URL synchronization is the intended behavior.

### scrolling and transitions

```html
<section data-scroll-into-view__smooth__vcenter__focus tabindex="-1"></section>
<div data-view-transition="$transitionName"></div>
```

`data-scroll-into-view` modifiers:

- behavior: `__smooth`, `__instant`, `__auto`
- horizontal: `__hstart`, `__hcenter`, `__hend`, `__hnearest`
- vertical: `__vstart`, `__vcenter`, `__vend`, `__vnearest`
- `__focus` focuses after scrolling

`data-view-transition` reactively sets `view-transition-name`. View transitions only work in supporting browsers. Patch actions and events can also request view transitions.

## actions

### clipboard

```html
<button type="button" data-on:click="@clipboard($shareUrl)">copy link</button>
<button type="button" data-on:click="@clipboard('SGVsbG8=', true)">
	copy decoded text
</button>
```

`@clipboard(text, isBase64 = false)` writes text to the clipboard. Base64 is useful when safely embedding text containing quotes or code in an HTML attribute.

### fit

```html
<div data-computed:opacity="@fit($x, 0, window.innerWidth, 0, 1, true)"></div>
```

`@fit(value, oldMin, oldMax, newMin, newMax, shouldClamp = false, shouldRound = false)` maps a number between ranges.

### internationalization

```html
<span data-text="@intl('number', $total, {style: 'currency', currency: 'USD'})"></span>
<time data-text="@intl('datetime', new Date($createdAt), {dateStyle: 'medium'})"></time>
```

`@intl(type, value, options?, locale?)` supports `datetime`, `number`, `pluralRules`, `relativeTime`, `list`, and `displayNames`. Options map to the corresponding browser `Intl` formatter.

## tools

- **bundler:** creates custom bundles and attribute aliases. Prefer the normal `data-*` names unless a legacy conflict cannot be isolated with `data-ignore`.
- **Datastar Inspector:** inspect and filter signals, signal patches, persisted storage, and SSE events while debugging.
- **Stellar CSS:** optional no-build design system based on CSS variables; it is separate from Datastar's reactivity model.
- **Rocket:** Pro's typed web-component API. See [Rocket](rocket.md).
