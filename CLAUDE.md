# Claude Sandbox

A Podman-based sandbox for running Claude Code in an isolated container.

## Project structure

- `Containerfile` — Fedora 41 image with Node.js, Claude Code, and dev tools
- `claude-sandbox.sh` — Main entry script: builds image, runs container with project mounted
## Key design decisions

- **Named Podman volume** (`claude-sandbox-home`) persists `/home/claude` across runs so login credentials, config, and cache survive container restarts
- **No `--dangerously-skip-permissions`** — the container provides isolation, user runs Claude interactively with normal permission prompts
- **Entrypoint is bash**, not Claude directly — user controls when/how to invoke Claude inside the container
- **`--userns=keep-id`** maps host UID into container to avoid file permission issues on mounted project
- Auth tokens are stored by Claude Code inside the container's home directory (not macOS Keychain), persisted via the named volume
