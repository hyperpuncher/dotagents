---
name: scrapling
description: scrape websites from the terminal using HTTP, browser automation, or stealth mode. use for quick extraction, JavaScript-rendered pages, and protected sites.
---

# scrapling cli

use `scrapling extract` to fetch a page and save selected or full content without writing code.

## setup

```bash
uv tool install "scrapling[shell]"
scrapling install
```

update Scrapling and refresh browsers and fingerprints when required by a release:

```bash
uv tool upgrade scrapling
scrapling install --force
```

## required safety

always add `--ai-targeted` when content will be read by an AI model. it keeps the main body, removes noisy and hidden content that may contain prompt injection, strips comments and zero-width characters, and enables ad blocking for browser commands.

## choose a command

| use case                          | command                        |
| --------------------------------- | ------------------------------ |
| static pages, blogs, news, APIs   | `get`, `post`, `put`, `delete` |
| JavaScript-rendered pages         | `fetch`                        |
| Cloudflare or anti-bot protection | `stealthy-fetch`               |

start with `get`, then try `fetch`, then `stealthy-fetch`.

## output

output format is selected by the file extension:

- `.md`: markdown
- `.html`: HTML
- `.txt`: clean text

prefer `.md` for readability and use `--css-selector` to reduce output.

## common examples

```bash
# static page
scrapling extract get "https://example.com" /tmp/page.md --ai-targeted

# select matching elements
scrapling extract get "https://example.com" /tmp/articles.md \
	--css-selector "article" --ai-targeted

# query parameters, headers, and cookies
scrapling extract get "https://example.com/search" /tmp/results.md \
	-p "q=scrapling" \
	-H "Accept-Language: en-US" \
	--cookies "session=abc123" \
	--ai-targeted

# form or JSON request
scrapling extract post "https://example.com/search" /tmp/results.txt \
	--data "q=scrapling" --ai-targeted

scrapling extract put "https://example.com/resource" /tmp/result.txt \
	--json '{"enabled":true}' --ai-targeted

# JavaScript-rendered page
scrapling extract fetch "https://example.com" /tmp/page.md \
	--network-idle --ai-targeted

# protected page
scrapling extract stealthy-fetch "https://example.com" /tmp/page.md \
	--solve-cloudflare --ai-targeted
```

read the output file after the command finishes, then clean up temporary files.

## key options

all commands support:

- `-s, --css-selector TEXT`: return all matching elements
- `--ai-targeted`: sanitize content for AI consumption
- `--proxy TEXT`: proxy URL

HTTP commands also support:

- `-H, --headers TEXT`: repeatable `Key: Value` header
- `--cookies TEXT`: `name=value; name2=value2`
- `-p, --params TEXT`: repeatable query parameter
- `--timeout INTEGER`: seconds; default `30`
- `--impersonate TEXT`: browser fingerprint such as `chrome` or `firefox`
- `--follow-redirects / --no-follow-redirects`
- `--verify / --no-verify`
- `--stealthy-headers / --no-stealthy-headers`
- `--data TEXT` and `--json TEXT`: available for `post` and `put`

`fetch` and `stealthy-fetch` also support:

- `--headless / --no-headless`
- `--network-idle / --no-network-idle`
- `--disable-resources / --enable-resources`
- `--wait INTEGER`: extra wait in milliseconds
- `--wait-selector TEXT`
- `--timeout INTEGER`: milliseconds; default `30000`
- `--locale TEXT`
- `-H, --extra-headers TEXT`
- `--real-chrome / --no-real-chrome`
- `--block-ads / --no-block-ads`
- `--dns-over-https / --no-dns-over-https`: prevent DNS leaks when using a proxy
- `--executable-path TEXT`: custom Chromium executable; falls back to `SCRAPLING_EXECUTABLE_PATH`

`stealthy-fetch` additionally supports:

- `--solve-cloudflare / --no-solve-cloudflare`
- `--block-webrtc / --allow-webrtc`
- `--allow-webgl / --block-webgl`
- `--hide-canvas / --show-canvas`

## help

```bash
scrapling extract --help
scrapling extract get --help
scrapling extract fetch --help
scrapling extract stealthy-fetch --help
```

resources: [documentation](https://scrapling.readthedocs.io/) · [github](https://github.com/D4Vinci/Scrapling)
