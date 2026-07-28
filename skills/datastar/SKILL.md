---
name: datastar
description: Build backend-driven, reactive web interfaces with Datastar and Datastar Pro. Use for data-* attributes, signals, actions, HTML or SSE patches, Datastar architecture, Pro plugins, or Rocket web components.
---

# datastar

Datastar is a lightweight hypermedia framework that combines backend-driven DOM updates with declarative frontend reactivity.

- docs: https://data-star.dev
- consolidated docs: https://data-star.dev/docs.md
- repository: https://github.com/starfederation/datastar
- browser bundle: `bundles/datastar.js`

## workflow

1. inspect the project's backend language, framework, templates, installed Datastar SDK, pinned version, and whether Datastar Pro is licensed and loaded.
2. keep durable and authoritative state on the backend.
3. render semantic HTML on the backend.
4. use signals sparingly for ephemeral UI state and values sent to the backend.
5. trigger backend requests with `@get`, `@post`, `@put`, `@patch`, or `@delete`.
6. return HTML, JSON, JavaScript, or preferably Datastar SSE events; use the project's official SDK when available.
7. favor default morphing and coarse-grained “fat morphs” over manually coordinating small fragments.
8. preserve normal web behavior: links for navigation, forms where appropriate, semantic HTML, keyboard access, and ARIA.

Read these references as needed:

- [frontend reference](references/frontend.md): signals, expressions, attributes, modifiers, and actions
- [backend reference](references/backend.md): requests, response types, SSE, patching, and SDK guidance
- [architecture](references/architecture.md): the Datastar way, state placement, CQRS, morphing, and common pitfalls
- [Datastar Pro](references/pro.md): Pro bundle, attributes, actions, and tools
- [Rocket](references/rocket.md): Pro's typed, reactive web-component API

## install

For a no-build setup, host the bundle yourself when possible. A CDN is suitable for a quick start:

```html
<script
	type="module"
	src="https://cdn.jsdelivr.net/gh/starfederation/datastar@v1.0.2/bundles/datastar.js"
></script>
```

Do not silently replace an existing pinned version. Match the project's installed or pinned Datastar version.

## minimal example

```html
<main id="main" data-signals:count__ifmissing="0">
	<p>count: <span data-text="$count"></span></p>
	<button type="button" data-on:click="$count++">local increment</button>
	<button
		type="button"
		data-indicator:_saving
		data-attr:disabled="$_saving"
		data-on:click="@post('/counter')"
	>
		save
	</button>
</main>
```

A backend action can return replacement HTML:

```http
Content-Type: text/html

<main id="main">...</main>
```

With the default `outer` morph mode, top-level element IDs identify existing DOM elements to patch.

## formatting

Use [dsfmt](https://github.com/hyperpuncher/dsfmt) to format Datastar attributes and expressions when it is installed or adopted by the project.

```bash
dsfmt --write src/
dsfmt --check src/
```

It supports HTML, JSX, TSX, Templ, HEEx, and Blade. It formats recognized Datastar attributes and their expressions while preserving unrelated source where possible. Do not run it on unsupported formats or substitute it for the project's normal formatter.

Install it when requested or when adding it to project tooling:

```bash
cargo install --git https://github.com/hyperpuncher/dsfmt
```

## core syntax

- signals are referenced as `$name`; nested paths are supported.
- actions use `@name(...)`.
- every expression has `el`, the element containing the attribute.
- event expressions have `evt`.
- modifiers follow `__`; modifier tags follow `.`, for example `data-on:input__debounce.300ms`.
- HTML lowercases attribute names. keyed signal attributes convert kebab case to camel case: `data-signals:user-name` creates `$userName`.
- signal names beginning with `_` are excluded from backend requests by default.
- signal names cannot contain `__`.
- attributes are evaluated in DOM order, so declare dependencies such as `data-indicator` before an initiating `data-init`.

## rules

- use only documented Datastar attributes, actions, modifiers, patch modes, and SDK methods.
- prefer signal-bound controls and the default JSON signal payload for ordinary Datastar requests; keep semantic forms, and use form encoding when native validation, compatibility, or multipart uploads require it.
- do not invent framework-specific SDK APIs; inspect the installed SDK or its documentation.
- do not make client signals a second source of truth for server state.
- escape user input before placing it in expressions; treat signals as visible, user-modifiable input and validate them on the backend.
- initialize editable/ephemeral signals with `__ifmissing` so morphs do not overwrite them.
- keep view-only server-controlled signals private with an `_` prefix.
- prefer returning a complete stable region with IDs and letting Datastar morph it.
- prefer SSE consistently, especially for streaming or multiple updates; ensure every SSE event ends with a blank line.
- use Pro features when appropriate if the project has a valid commercial license and a version-matched Pro bundle; otherwise stay with core APIs.
- do not use optimistic success states when backend confirmation matters; show an in-progress state and let the backend-confirmed patch show success.
