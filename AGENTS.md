## communication

- use plain, concise, human language
- avoid unnecessary jargon
- use lowercase wherever possible, except when exact casing matters
- no em-dashes
- for every local file you create or mention, provide a clickable markdown link using its verified absolute `file://` URL, never a relative link, bare path, or localhost preview URL unless explicitly requested

## workflow

- for documentation research, search `~/docs/` first, clone any missing repo there with `git clone --depth=1 --single-branch --no-tags`, read relevant READMEs, `AGENTS.md` files, and files in docs directories in full, then summarize the key points
- use `/tmp` for temporary files
- never commit unless explicitly asked
- before committing, format, lint, and typecheck
- use conventional commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`
- use the package manager specified by `package.json` or lockfiles, defaulting to `bun`
- install dependencies with package manager commands instead of editing manifests by hand, and prefer latest versions
- before adding shared helpers or UI, search for equivalent code and reuse it when behavior matches

## implementation

- start with the smallest complete solution and apply YAGNI aggressively
- use existing platform and framework capabilities before writing custom machinery
- optimize for fewer concepts and less total code, not merely moving complexity between files or layers
- do not add abstractions, compatibility layers, or defensive fallbacks without a demonstrated need
- extract shared code only after the same pattern appears in at least three real places
- if a small change starts growing into a state machine or touching many files, stop, reassess, and present the simpler options before continuing
- do not preserve obscure or accidental behavior with significant machinery without confirming that it matters
- simplify an approved direction in place; ask before reverting, resetting, or discarding it

## tool preferences

| use this | not this |
| -------- | -------- |
| `trash`  | `rm`     |
| `bunx`   | `npx`    |
| `uv`     | `pip`    |

## formatting

- use tabs unless the project specifies different formatting
