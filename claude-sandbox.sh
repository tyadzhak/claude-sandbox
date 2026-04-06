#!/usr/bin/env bash
set -e

PROJECT_DIR="${1:?Usage: claude-sandbox /path/to/project}"

podman build -t claude-sandbox "$(dirname "$0")"

podman run -it --rm \
  --name claude-sandbox \
  -v "${PROJECT_DIR}:/workspace:Z" \
  -v "${HOME}/.claude:/home/claude/.claude:Z" \
  claude-sandbox