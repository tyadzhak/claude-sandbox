#!/usr/bin/env bash
set -e

PROJECT_DIR="${1:?Usage: claude-sandbox /path/to/project}"
PROJECT_DIR="$(cd "$PROJECT_DIR" && pwd)"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Build image only if it doesn't exist or --rebuild is passed
if [[ "${2}" == "--rebuild" ]] || ! podman image exists claude-sandbox; then
  podman build -t claude-sandbox "$SCRIPT_DIR"
fi

# Named volume persists /home/claude across runs (login once, reuse forever)
VOLUME_NAME="claude-sandbox-home"

podman run -it --rm \
  --name "claude-sandbox-$$" \
  --userns=keep-id \
  -v "${VOLUME_NAME}:/home/claude:Z" \
  -v "${PROJECT_DIR}:/workspace:Z" \
  claude-sandbox