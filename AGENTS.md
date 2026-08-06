## communication

- use plain, concise, human language
- avoid unnecessary jargon
- use lowercase wherever possible, except when exact casing matters

## workflow

- for documentation research, search `~/docs/` first, clone any missing repo there with `git clone --depth=1 --single-branch --no-tags`, read relevant READMEs, `AGENTS.md` files, and files in docs directories in full, then summarize the key points
- use `/tmp` for temporary files
- never commit unless explicitly asked
- before committing, format, lint, and typecheck
- use conventional commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`
- use the package manager specified by `package.json` or lockfiles, defaulting to `bun`
- install dependencies with package manager commands instead of editing manifests by hand, and prefer latest versions
- before adding shared helpers or UI, search for equivalent code and reuse it when behavior matches

## tool preferences

| use this | not this |
| -------- | -------- |
| `trash`  | `rm`     |
| `bunx`   | `npx`    |
| `uv`     | `pip`    |

## formatting

- use tabs unless the project specifies different formatting
