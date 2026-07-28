# architecture

## default mental model

Treat the view as a function of authoritative backend state:

```text
view = render(state)
```

The backend sends current HTML; Datastar morphs it into the DOM while preserving unchanged browser state. This makes coarse-grained rendering practical and usually simpler than maintaining many fragment endpoints.

## state placement

Keep durable, shared, security-sensitive, and authoritative state on the backend.

Use signals sparingly for:

- current input values
- open/closed UI controls
- loading and validation state
- CSRF values
- values being submitted to the backend

Editable ephemeral signals declared in rendered elements should usually use `__ifmissing`, preventing later morphs from resetting client edits:

```html
<div data-signals:query__ifmissing="''"></div>
```

View-only signals controlled by the backend should normally start with `_`, which excludes them from request payloads by default:

```html
<!-- The backend template emits this value. -->
<div data-signals:_can-edit="true"></div>
```

Do not mirror the entire backend model into frontend signals.

## morphing

Trust default morphing and send a stable, reasonably large region—sometimes `main` or even the full document. Stable element IDs anchor patches. Let the morph algorithm find fine-grained changes.

Use `data-ignore-morph` only for subtrees that Datastar must not touch, such as stateful third-party widgets. Use `data-preserve-attr` when only specific attributes must retain browser state.

Avoid premature server-side HTML diffing. Long-lived compressed HTML streams can achieve excellent compression while keeping rendering stateless.

## CQRS and real-time updates

Separate commands from the live rendered view:

- commands validate input and modify the database;
- a read/update SSE connection renders when backend state changes;
- command responses are often `204`, or signal patches for validation;
- the live read connection sends the backend-confirmed view.

Do not have command endpoints patch a view that a separate update stream will immediately overwrite. Communicate durable changes through authoritative storage.

Batch or throttle render notifications when updates are frequent. Always render the latest state after a batch rather than sending fragile deltas. Cache/share rendered work where many users receive the same view.

## user experience

- use `data-indicator` for ordinary request progress.
- with a separate CQRS update stream, a command can add a loading class and let the next backend-rendered morph remove it.
- avoid optimistic success claims when the operation can fail; show progress, then show backend-confirmed state.
- use `<a>` for navigation and browser history rather than rebuilding routing in signals.
- use semantic HTML and preserve keyboard and screen-reader behavior.

## rendering options

A normal initial server-rendered page is simple and resilient. For highly dynamic systems, an initial static shell can connect to an updates endpoint and receive its dynamic content. This can reduce work for bots and previews, but it also means dynamic content depends on JavaScript and a successful connection. Choose deliberately.

## review checklist

- is the backend the source of truth?
- are signals limited to useful client interaction state?
- do editable signals use `__ifmissing` where morphs might reset them?
- are private/view-only signals prefixed with `_`?
- are patch targets stable and identifiable?
- could one coarse morph replace several fragment-specific endpoints?
- are writes authorized and validated server-side?
- does success come from backend-confirmed state?
- is SSE unbuffered, compressed, and cancellation-aware?
- does navigation still use normal links and browser behavior?
- if Pro features are used, is the commercial license valid and the bundle version-matched?
