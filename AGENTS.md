## rules

- use conventional commits: `feat|fix|refactor|build|ci|chore|docs|style|perf|test`
- clone repo into `~/projects/docs/` for reference when needed
- use `/tmp` for temporary files
- always typecheck, lint, and format before finishing
- never commit unless the user explicitly asks
- never use python for file edits

## tool preferences

| use this | not this |
| -------- | -------- |
| `trash`  | `rm`     |
| `fd`     | `find`   |
| `rg`     | `grep`   |
| `sd`     | `sed`    |
| `bunx`   | `npx`    |
| `uv`     | `pip`    |

## package manager

- detect from `package.json` (bun, npm, pnpm, yarn)
- if none use `bun`

## formatting

- tabs for indentation
