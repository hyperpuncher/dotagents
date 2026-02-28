---
name: chough
description: Fast ASR CLI tool for transcribing audio/video files. Use when user wants to transcribe audio/video, generate subtitles (VTT), convert speech to text with timestamps (JSON), or optimize transcription for low memory.
---

## Installation

**Arch Linux:** `paru -S chough-bin`
**macOS:** `brew install --cask hyperpuncher/tap/chough`
**Windows:** `winget install chough`
**Source:** `go install github.com/hyperpuncher/chough/cmd/chough@latest`

**Requires:** `ffmpeg` for audio/video support

## Quick Reference

```bash
# Basic transcription (text to stdout)
chough audio.mp3

# JSON with timestamps
chough -f json podcast.mp3 > transcript.json

# WebVTT subtitles
chough -f vtt -o subs.vtt video.mp4

# Low memory (30s chunks)
chough -c 30 audiobook.mp3
```

## Flags

| Flag               | Description             | Default |
| ------------------ | ----------------------- | ------- |
| `-c, --chunk-size` | Chunk size in seconds   | 60      |
| `-f, --format`     | Output: text, json, vtt | text    |
| `-o, --output`     | Output file             | stdout  |
| `--version`        | Show version            | -       |

## Chunk Size Guide

- **15-30s**: Low memory (~500MB), higher error rate
- **60s**: Balanced (default) - ~1.6GB RAM

## Performance

| Duration | Time  | Speed          |
| -------- | ----- | -------------- |
| 15s      | 2.0s  | 7.4x realtime  |
| 1min     | 4.3s  | 14.1x realtime |
| 5min     | 16.2s | 18.5x realtime |
| 30min    | 90.2s | 19.9x realtime |

## Troubleshooting

**Out of memory:** Use `-c 30` or `-c 15`
**Model fails:** Check internet, verify `$XDG_CACHE_HOME` is writable
**ffmpeg errors:** Ensure ffmpeg is installed

## Notes

- First run downloads ~650MB model to `$XDG_CACHE_HOME/chough/models`
- Auto-extracts audio from video files
- Set `CHOUGH_MODEL` env var to use custom model path
- VTT groups tokens into subtitle cues automatically

## Docs

- [GitHub](https://github.com/hyperpuncher/chough)
