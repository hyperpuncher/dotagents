# backend reference

## request contract

Datastar backend actions send `Datastar-Request: true`.

- GET and DELETE put signals in the `datastar` query parameter.
- POST, PUT, and PATCH send signals as JSON by default.
- `{contentType: 'form'}` submits the closest form, or the form selected by `selector`, and does not send signals.
- signals beginning with `_` are excluded by default.

Use the official SDK for the project's language when available. Inspect its installed version and API rather than translating method names from another language. Official SDKs exist for multiple languages and expose equivalent concepts with language-specific APIs.

## response types

Backend actions understand:

| content type        | effect                                   |
| ------------------- | ---------------------------------------- |
| `text/event-stream` | process zero or more Datastar SSE events |
| `text/html`         | patch returned top-level elements        |
| `application/json`  | patch signals                            |
| `text/javascript`   | execute returned JavaScript              |
| `204 No Content`    | complete without a patch                 |

The Tao of Datastar recommends using SSE consistently, including for single patches. Plain HTML, JSON, and JavaScript responses remain useful for simple endpoints and compatibility.

## plain HTML responses

By default, top-level elements morph their matching DOM elements, generally by ID.

```http
HTTP/1.1 200 OK
Content-Type: text/html

<section id="results">
	<p>updated by the backend</p>
</section>
```

Optional response headers:

- `datastar-selector`: CSS target selector
- `datastar-mode`: `outer`, `inner`, `remove`, `replace`, `prepend`, `append`, `before`, or `after`
- `datastar-use-view-transition`: whether to use the View Transition API

Default mode is `outer`. Prefer stable IDs and default morphing over selectors and insertion modes unless another strategy is genuinely needed. Add IDs to important descendants whose state, listeners, or transitions should survive morphs.

## JSON and JavaScript responses

JSON patches signals:

```http
Content-Type: application/json
datastar-only-if-missing: true

{"form":{"error":""}}
```

Signal patches follow JSON Merge Patch semantics. `datastar-only-if-missing: true` avoids overwriting existing signals; `null` removes a signal.

JavaScript executes in the browser:

```http
Content-Type: text/javascript
datastar-script-attributes: {"type":"module"}

console.log("executed from a Datastar response")
```

Prefer element and signal patches. Return JavaScript only when script execution is intentional and safe. In SSE responses, SDKs may provide an execute-script helper that emits a script through an element patch.

## SSE

Set `Content-Type: text/event-stream`. Each event must end with a blank line. Multiline values use repeated `data:` lines.

A raw element patch looks like:

```text
event: datastar-patch-elements
data: elements <section id="status">
data: elements     ready
data: elements </section>

```

A single response can send zero, one, or many events and can remain open:

```text
event: datastar-patch-elements
data: elements <section id="status">working</section>

event: datastar-patch-elements
data: elements <section id="status">done</section>

```

Element patch events can additionally specify `selector`, `mode`, `namespace` (`svg` or `mathml`), `useViewTransition`, and `viewTransitionSelector`. Signal patch events can specify `onlyIfMissing`; setting a signal to `null` removes it.

Use the SDK's patch-elements and patch-signals helpers instead of formatting SSE manually. The SDK should also set required streaming headers and handle multiline data correctly.

## long-lived updates and CQRS

A useful real-time pattern separates reads from writes:

```html
<main id="main" data-init="@get('/updates')">
	<button data-on:click="@post('/commands/do-something')">do something</button>
</main>
```

- `/updates` is a long-lived SSE read connection that sends the latest rendered view.
- command endpoints modify authoritative backend state and usually return `204`, or patch validation signals.
- persisted changes cause the updates stream to render and push a fresh view.

This avoids connection-local application state and missed-delta problems. Re-render the latest state rather than relying on every client to receive every domain event.

## production concerns

- enable streaming-compatible compression; prefer Zstandard (`zstd`) or Brotli (`br`) when negotiated and supported, with gzip as a compatibility fallback. Repeated HTML in long-lived streams compresses extremely well.
- ensure proxies and middleware do not buffer SSE.
- stop work when the request disconnects.
- send valid UTF-8 and preserve the SSE blank-line delimiter.
- use appropriate cache and authentication headers.
- keep authorization and validation on the backend; browser signals are untrusted input.
- avoid putting secrets in signals or returned HTML.
- use normal redirects and links for page navigation.
