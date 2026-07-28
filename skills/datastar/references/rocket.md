# rocket

Rocket is Datastar Pro's beta API for typed, reactive web components. Import it from the licensed, project-hosted Pro bundle:

```js
import { createCodec, publishRocketManifests, rocket } from "/bundles/datastar-pro.js";
```

Check the project's pinned version because the API is beta.

## component anatomy

```js
rocket("app-stepper", {
	mode: "light",
	props: ({ number, string }) => ({
		start: number.min(0),
		step: number.min(1).default(1),
		label: string.trim.default("count"),
	}),
	setup: ({ $$, props }) => {
		$$.count = props.start;
	},
	render: ({ html, props: { label, step } }) => html`
		<section>
			<h3>${label}</h3>
			<button
				type="button"
				data-on:click="$$count -= ${step}"
				data-attr:disabled="$$count <= 0"
			>
				-
			</button>
			<output data-text="$$count"></output>
			<button type="button" data-on:click="$$count += ${step}">+</button>
		</section>
	`,
});
```

```html
<app-stepper start="5" step="2" label="inventory"></app-stepper>
```

The tag must contain a hyphen. Re-registering an existing tag is ignored.

## definition fields

- `mode`: `'light'`, `'open'` (default shadow DOM), or `'closed'`.
- `props(codecs)`: typed public attributes/properties.
- `setup(context)`: runs once per connected instance before initial Datastar apply; create local state and non-DOM behavior here.
- `onFirstRender(context)`: runs once after initial render/apply and ref population; use for refs, measurement, focus, and DOM-dependent integrations.
- `render(context, ...args)`: returns `html`/`svg` output, nodes, primitives, iterables, or nothing.
- `renderOnPropChange`: boolean or predicate controlling prop-triggered rerenders; defaults to true and same-turn updates are coalesced.
- `manifest`: manual slot and event metadata.

Use light DOM for page styling and layout participation, open shadow DOM for encapsulation plus debugging, and closed shadow DOM only for intentionally sealed internals. CSS custom properties cross shadow boundaries and are the preferred theming API.

## props and codecs

Use props for the component's public API. JavaScript camel-case prop names map to kebab-case attributes. Rocket creates host property accessors and reflects property writes back to attributes.

Built-in codecs:

| codec              | value             | useful members                                                                                                           |
| ------------------ | ----------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `string`           | string            | `.trim`, `.upper`, `.lower`, `.kebab`, `.camel`, `.snake`, `.pascal`, `.title`, `.prefix()`, `.suffix()`, `.maxLength()` |
| `number`           | number            | `.min()`, `.max()`, `.clamp()`, `.step()`, `.round`, `.ceil()`, `.floor()`, `.fit()`                                     |
| `bool`             | boolean           | empty boolean attributes decode to true                                                                                  |
| `date`             | `Date`            | invalid input falls back to a valid date                                                                                 |
| `json`             | structured JSON   | clones structured values                                                                                                 |
| `js`               | structured value  | accepts JavaScript-like literals                                                                                         |
| `bin`              | `Uint8Array`      | base64 attribute encoding                                                                                                |
| `array(codec)`     | homogeneous array | every item uses the nested codec                                                                                         |
| `array(a, b, ...)` | tuple             | each position uses its codec                                                                                             |
| `object(shape)`    | typed object      | nested codecs per property                                                                                               |
| `oneOf(...)`       | constrained union | literals, codecs, or both                                                                                                |

All codecs support `.default(value)`. Use factories for mutable or per-instance defaults:

```js
props: ({ array, json, number, object, oneOf, string }) => ({
	theme: oneOf("light", "dark", "system").default("system"),
	progress: number.clamp(0, 100).step(5),
	tags: array(string.trim.lower),
	profile: object({
		name: string.trim.default("anonymous"),
		age: number.min(0),
	}),
	options: json.default(() => ({})),
});
```

Use `createCodec({decode, encode})` for domain-specific types. A codec must accept unknown input, normalize it, and encode a value to an attribute string. If decoding throws, Rocket warns and uses the codec's default.

## local state and setup

`$$` exposes instance-local signals:

```js
setup: ({ $$, cleanup }) => {
	$$.count = 0;
	$$.double = () => $$.count * 2;

	const timer = setInterval(() => $$.count++, 1000);
	cleanup(() => clearInterval(timer));
};
```

Rendered expressions use `$$count` and `$$double`. Rocket rewrites them to an instance-specific path under `$._rocket`; never write that internal path yourself.

Setup context includes:

- `props`: current normalized props
- `$$`: local signals; assigning a function creates a local computed signal
- `$`: global Datastar signal root
- `effect(fn)`: reactive side effects
- `actions`: global Datastar action registry
- `action(name, fn)`: component-local action callable as `@name()`
- `observeProps(fn, ...names)`: react to decoded prop changes
- `apply(root, merge?)`: activate Datastar on inserted DOM
- `cleanup(fn)`: disconnect cleanup
- `render(overrides, ...args)`: force a coarse render
- `host`: custom element instance
- `overrideProp(...)`, `defineHostProp(...)`: customize the host API

Prefer direct expressions for simple local updates. Register a local action when markup needs a named imperative operation:

```js
setup: ({ $$, action }) => {
	$$.copied = false
	action('markCopied', () => {
		$$.copied = true
	})
},
render: ({ html }) => html`
	<button data-on:click="@markCopied()" data-text="$$copied ? 'copied' : 'copy'"></button>
`,
```

Use `observeProps` for prop changes and `effect` for reactive local/global signals. Forced `render()` is for coarse structural updates, not high-frequency state.

## refs and host APIs

Refs do not exist during `setup`. Access them in `onFirstRender`:

```js
rocket("app-input", {
	props: ({ string }) => ({ value: string.default("") }),
	render: ({ html, props: { value } }) => html`
		<input data-ref:input value="${value}" />
	`,
	onFirstRender: ({ overrideProp, refs }) => {
		overrideProp(
			"value",
			(getDefault) => refs.input?.value ?? getDefault(),
			(value, setDefault) => {
				const next = String(value ?? "");
				if (refs.input) refs.input.value = next;
				setDefault(next);
			},
		);
	},
});
```

Use normal props first. `overrideProp` is for native-like wrappers whose property must reflect a live inner control. `defineHostProp` adds non-prop methods or properties such as `reset()` or read-only `files`.

## rendering

`html` and `svg` are tagged template helpers. They safely compose primitives, nodes, fragments, and iterables. In attribute positions, `false`, `null`, and `undefined` omit the attribute; `true` creates an empty boolean attribute. In data positions those values render nothing.

Rocket understands Datastar attributes in rendered markup and adds two structural constructs.

### conditionals

```js
render: ({ html }) => html`
	<template data-if="$$status === 'loading'"><p>loading</p></template>
	<template data-else-if="$$status === 'error'"><p>failed</p></template>
	<template data-else><p>ready</p></template>
`;
```

Only one branch is mounted. Use `data-show` instead when the element must remain mounted.

### loops

```js
render: ({ html }) => html`
	<ul>
		<template data-for="item, row in $$items">
			<li><span data-text="row + 1"></span>: <span data-text="item"></span></li>
		</template>
	</ul>
`;
```

Supported forms are:

- `data-for="$$items"` → `item`, `i`
- `data-for="entry in $$items"` → `entry`, `i`
- `data-for="entry, row in $$items"` → `entry`, `row`

Rows are preserved by position, not item identity, in the current beta. Do not rely on identity preservation when reordering.

## slots and outer signals

Shadow modes use native slots. In light mode, `<slot>` is a Rocket projection marker for original host children and supports named and fallback content.

Rocket normally scopes signal-name attributes in component content. Add `__root` only when authored children must bind to an outer page signal:

```html
<app-field>
	<input data-bind:name__root />
</app-field>
```

Supported families are `data-bind`, `data-computed`, `data-indicator`, and `data-ref`. Do not use `__root` for normal component-local state.

## manifests

`manifest` documents slots and events that cannot be inferred from props. Each registered class exposes static `manifest()`. `publishRocketManifests({endpoint})` posts a sorted manifest document containing version and generation time.

## rules

- remember Rocket is beta and pin the Pro version.
- prefer props for public state and `$$` for private reactive state.
- keep setup behavior out of `render`; keep ref-dependent work in `onFirstRender`.
- register cleanup for timers, observers, subscriptions, and third-party instances.
- use `observeProps` rather than treating `props` as reactive signals.
- use semantic HTML and expose accessible names, focus behavior, slots, properties, and events.
- do not expose the internal `$._rocket` path as public API.
