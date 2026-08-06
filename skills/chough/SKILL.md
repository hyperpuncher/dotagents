---
name: chough
description: Fast ASR CLI tool for transcribing audio/video files. Use when user wants to transcribe audio/video, generate subtitles (VTT), convert speech to text with timestamps (JSON).
---

# chough

use chough for fast, CPU-only transcription of audio or video. it supports plain text, timestamped JSON, and WebVTT subtitles.

## install

- Arch Linux: `paru -S chough-bin`
- macOS: `brew install --cask hyperpuncher/tap/chough`
- Windows: `winget install chough`
- source: `go install github.com/hyperpuncher/chough/cmd/chough@latest`

`ffmpeg` is required. the first run downloads the roughly 650 MB model into the operating system's user cache under `chough/models/<model-name>`.

## common usage

flags must appear before the input file.

```bash
# text to stdout
chough audio.mp3

# audio from stdin
cat audio.mp3 | chough

# timestamped JSON
chough -f json podcast.mp3 > transcript.json

# WebVTT subtitles
chough -f vtt -o subtitles.vtt video.mp4
```

video input is supported whenever ffmpeg supports the format.

## cli flags

| flag                   | purpose                                   | default |
| ---------------------- | ----------------------------------------- | ------- |
| `-c, --chunk-size INT` | chunk size in seconds; maximum `300`      | `20`    |
| `-f, --format FORMAT`  | `text`, `json`, or `vtt`                  | `text`  |
| `-o, --output FILE`    | write output to a file                    | stdout  |
| `-r, --remote`         | use the server configured by `CHOUGH_URL` | off     |

prefer the default 20-second chunk size.

## remote mode

set `CHOUGH_URL` to an HTTP or HTTPS server and pass `--remote`:

```bash
CHOUGH_URL=http://localhost:8080 chough --remote audio.mp3
```

when deciding whether to use an available remote server, check `${CHOUGH_URL}/health` first. fall back to local transcription if it is unavailable unless the user explicitly requires remote mode.

## server mode

start a server that keeps the model loaded between requests:

```bash
chough --server --port 8080

chough --server \
	--host 0.0.0.0 \
	--port 8080 \
	--workers 2 \
	--queue-size 10
```

| flag                   | purpose                                   | default   |
| ---------------------- | ----------------------------------------- | --------- |
| `--host`               | listen address                            | `0.0.0.0` |
| `--port`               | listen port                               | `8080`    |
| `--workers`            | concurrent audio-preparation workers      | `2`       |
| `--queue-size`         | maximum queued requests                   | `10`      |
| `--max-upload`         | maximum audio size in MB                  | `1024`    |
| `--allow-private-urls` | allow URL downloads from private networks | off       |

server mode has no authentication, TLS, CORS policy, or rate limiting. do not expose it directly to the public internet; use a trusted reverse proxy when those controls are required.

URL transcription blocks loopback, private, link-local, multicast, and other special-use destinations, including after redirects. only use `--allow-private-urls` for trusted LAN or homelab sources.

## HTTP API

| method | endpoint      | purpose                                           |
| ------ | ------------- | ------------------------------------------------- |
| `POST` | `/transcribe` | transcribe an upload, public URL, or base64 audio |
| `GET`  | `/health`     | inspect model and queue status                    |

```bash
# upload
curl -X POST http://localhost:8080/transcribe \
	-F "file=@audio.mp3" \
	-F "format=json"

# public URL
curl -X POST http://localhost:8080/transcribe \
	-H "Content-Type: application/json" \
	-d '{"url":"https://example.com/audio.mp3","format":"vtt"}'

# base64
curl -X POST http://localhost:8080/transcribe \
	-H "Content-Type: application/json" \
	-d '{"base64":"...","format":"text"}'

curl http://localhost:8080/health
```

## JSON output

JSON chunks always contain `start_time`, `end_time`, and `text`. when supplied by the recognizer, they also contain aligned arrays:

- `tokens`: recognizer tokens
- `timestamps`: token start times in seconds
- `durations`: token durations in seconds
- `log_probs`: token log probabilities

optional arrays are omitted when they are unavailable or not aligned with the tokens.

## environment

- `CHOUGH_MODEL`: custom model directory
- `CHOUGH_URL`: remote server URL for `--remote`; must start with `http://` or `https://`

## troubleshooting

- ffmpeg errors: confirm `ffmpeg` is installed and supports the input format
- model errors: confirm the user cache directory is writable, or set `CHOUGH_MODEL`
- memory pressure: try a smaller positive `--chunk-size`

resources: [github](https://github.com/hyperpuncher/chough)
