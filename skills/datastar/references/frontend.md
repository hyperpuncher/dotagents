# frontend reference

## signals and expressions

Define one signal:

```html
<div data-signals:menu-open__ifmissing="false"></div>
```

Define an object of signals:

```html
<div data-signals="{user: {name: '', role: 'member'}}"></div>
```

Use `$menuOpen` and `$user.name` in expressions. Referencing an undeclared signal creates it with an empty-string value. Setting a signal to `null` or `undefined` removes it. Prefix private signals with `_` to exclude them from backend requests by default.

Expressions support JavaScript operators, calls, ternaries, objects, and arrays. `el` is always available. `evt` is available to event handlers. Separate multiple statements with semicolons, including across lines. Datastar does not await asynchronous expression results.

```html
<button data-on:click="$menuOpen = !$menuOpen">toggle</button>
<p data-text="$user.name || 'anonymous'"></p>
```

Use `@peek(() => $signal)` to read without subscribing. Computed expressions must be pure; use `data-effect` for side effects.

## core attributes

| attribute                     | purpose                                         | example                                            |
| ----------------------------- | ----------------------------------------------- | -------------------------------------------------- |
| `data-attr`                   | reactively set HTML attributes                  | `data-attr:disabled="$saving"`                     |
| `data-bind`                   | two-way bind a signal to a control              | `data-bind:query`                                  |
| `data-class`                  | toggle classes                                  | `data-class:hidden="!$open"`                       |
| `data-computed`               | define a read-only derived signal               | `data-computed:total="$price * $qty"`              |
| `data-effect`                 | run a side effect initially and on dependencies | `data-effect="console.log($query)"`                |
| `data-ignore`                 | skip Datastar processing                        | `data-ignore`                                      |
| `data-ignore-morph`           | protect a subtree from morphing                 | `data-ignore-morph`                                |
| `data-indicator`              | true while a fetch is active                    | `data-indicator:_saving`                           |
| `data-init`                   | run when initialized or reapplied               | `data-init="@get('/updates')"`                     |
| `data-json-signals`           | render signals as JSON for debugging            | `data-json-signals`                                |
| `data-on`                     | handle DOM or custom events                     | `data-on:click="$open = true"`                     |
| `data-on-intersect`           | react to viewport intersection                  | `data-on-intersect__once="@get('/more')"`          |
| `data-on-interval`            | run on an interval                              | `data-on-interval__duration.5s="@get('/status')"`  |
| `data-on-signal-patch`        | react whenever signals are patched              | `data-on-signal-patch="console.log(patch)"`        |
| `data-on-signal-patch-filter` | filter watched signal paths                     | `data-on-signal-patch-filter="{include: /^user/}"` |
| `data-preserve-attr`          | preserve attributes during morphing             | `data-preserve-attr="open class"`                  |
| `data-ref`                    | store an element reference in a signal          | `data-ref:dialog`                                  |
| `data-show`                   | show or hide based on a boolean                 | `data-show="$open"`                                |
| `data-signals`                | add, update, or remove signals                  | `data-signals:count__ifmissing="0"`                |
| `data-style`                  | reactively set inline styles                    | `data-style:display="$hidden && 'none'"`           |
| `data-text`                   | set text content                                | `data-text="$message"`                             |

Most keyed attributes also support object syntax:

```html
<div
	data-attr="{'aria-busy': $saving, disabled: $saving}"
	data-class="{active: $active, hidden: !$visible}"
></div>
```

`data-show` can briefly flash before initialization. Add `style="display: none"` when the initial state should be hidden. For `data-style`, an empty string, `null`, `undefined`, or `false` restores the original inline value, or removes the property if none existed.

## binding

`data-bind` creates the signal if absent. For ordinary Datastar interactions, prefer binding controls to signals and sending the default JSON signal payload. This preference concerns payload/state handling—it does not mean avoiding semantic `<form>` elements.

Predefine a signal to preserve its intended type:

```html
<div data-signals:quantity__ifmissing="0">
	<input type="number" data-bind:quantity />
</div>
```

Predefine an array to bind multiple checkbox values. File inputs without forms become arrays of `{name, contents, mime}` with base64 contents. For normal file uploads, use a form with `enctype="multipart/form-data"` and a backend action using `{contentType: 'form'}`.

Custom elements can specify a property and sync events:

```html
<my-toggle data-bind:enabled__prop.checked__event.change></my-toggle>
```

## modifiers

Modifiers use `__name`; tags use `.value`:

```html
<input data-on:input__debounce.300ms="$query = evt.target.value" />
```

`data-on:submit` prevents normal form submission by default. Common `data-on` modifiers:

- `__once`, `__passive`, `__capture`
- `__prevent`, `__stop`, `__outside`
- `__window`, `__document`
- `__delay.500ms`
- `__debounce.500ms.leading.notrailing`
- `__throttle.500ms.noleading.trailing`
- `__viewtransition`
- `__case.camel|kebab|snake|pascal`

`data-init` supports `__delay` and `__viewtransition`. `data-on-interval` uses `__duration.500ms` or `__duration.1s`, optionally `.leading`. Intersection supports `__once`, `__exit`, `__half`, `__full`, and `__threshold.25`. `data-ignore__self` ignores only the element, not its descendants. `data-json-signals__terse` emits compact JSON.

Keyed signal attributes default to camel-case names. Other keyed attributes default to kebab case. Use `__case` only when the target casing differs.

## actions

### local actions

```html
<div data-text="$foo + @peek(() => $bar)"></div>
<button data-on:click="@setAll('', {include: /^form\./})">clear</button>
<button data-on:click="@toggleAll({include: /^selected\./})">toggle</button>
```

- `@peek(callable)` reads signals without subscribing.
- `@setAll(value, filter?)` sets matching signals.
- `@toggleAll(filter?)` toggles matching boolean signals.
- filters use `{include: RegExp, exclude?: RegExp}`.

### backend actions

```html
<button data-on:click="@get('/items')">refresh</button>
<button data-on:click="@post('/items')">create</button>
<button data-on:click="@put('/items/1')">replace</button>
<button data-on:click="@patch('/items/1')">update</button>
<button data-on:click="@delete('/items/1')">delete</button>
```

All signatures are `@method(uri, options = {})`. Options:

- `contentType`: `'json'` (default) or `'form'`
- `filterSignals`: `{include, exclude?}` regex filter
- `selector`: form selector when `contentType` is `'form'`
- `headers`: request headers object
- `openWhenHidden`: keep SSE open in hidden tabs; defaults to `false` for GET and `true` for other methods
- `payload`: replace the generated payload
- `retry`: `'auto'`, `'error'`, `'always'`, or `'never'`
- `retryInterval`, `retryScaler`, `retryMaxWait`, `retryMaxCount`
- `requestCancellation`: `'auto'`, `'cleanup'`, `'disabled'`, or an `AbortController`

GET and DELETE send signals in a `datastar` query parameter. POST, PUT, and PATCH send them as a JSON body. Requests include `Datastar-Request: true`. Signals prefixed with `_` are excluded by default.

Prefer this default signal payload for ordinary Datastar requests, and send all relevant signals rather than maintaining partial payload filters. Use `{contentType: 'form'}` when native form validation/encoding is required, an existing endpoint expects form data, or files should be uploaded with `multipart/form-data`. Form mode validates and sends form controls instead of signals.

By default, a new request cancels an in-flight request with the same HTTP method and URL, regardless of which element initiated it. Use `requestCancellation: 'disabled'` when those requests must run concurrently.

Listen for request lifecycle events with `data-on:datastar-fetch`. `evt.detail.type` is `started`, `finished`, `error`, `retrying`, or `retries-failed`.

## JavaScript interop and security

Keep expressions small. Pass values into external functions and return results; asynchronous functions should dispatch custom events. Prefer web components for substantial reusable browser behavior, following “props down, events up.”

Never insert unescaped user input into Datastar expressions: expressions can execute JavaScript. Signals are visible and user-modifiable, so never place secrets in them and always validate and authorize requests on the backend. If unsafe content cannot be escaped, isolate it under `data-ignore`.

Datastar evaluates expressions with `Function()`. A Content Security Policy must therefore allow `'unsafe-eval'` in `script-src`; account for this explicitly instead of weakening other directives unnecessarily.

## pro features

When the project has a valid license and a version-matched Pro bundle, see [Datastar Pro](pro.md) for `data-animate`, validation, media queries, frame/resize observers, persistence, URL synchronization, scrolling, transitions, Pro actions, tooling, and Rocket.
