# Claude Sandbox

Run [Claude Code](https://docs.anthropic.com/en/docs/claude-code) inside a Podman container, isolating it from your host system while giving it access to your project files.

## Why

Running Claude Code in a container limits the blast radius — it can only touch the mounted project directory, not your entire filesystem.

## Prerequisites

- [Podman](https://podman.io/docs/installation) installed and running

## Quick start

```bash
# First run — builds the image and drops you into a container shell
./claude-sandbox.sh /path/to/your/project

# Inside the container, login once
claude
/login

# Exit and re-run — credentials are persisted automatically
./claude-sandbox.sh /path/to/your/project
```

## Usage

```bash
./claude-sandbox.sh /path/to/project            # start container
./claude-sandbox.sh /path/to/project --rebuild   # rebuild image first
```

Inside the container you get a bash shell with `claude` available on PATH. Run it manually with any flags you want:

```bash
claude                    # interactive mode
claude --model sonnet     # use a specific model
claude -p "fix the bug"   # non-interactive prompt
```

## How it works

```
Host                              Container (Podman)
/path/to/project ──mount───────►  /workspace          (your code)
claude-sandbox-home (volume) ──►  /home/claude         (persisted config, auth, cache)
                                  bash → claude
```

- **Persistent volume**: A named Podman volume (`claude-sandbox-home`) stores `/home/claude` across runs — login once, reuse forever
- **UID mapping**: `--userns=keep-id` ensures files written in the container match your host user
- **Isolation**: The container has no access to files outside the mounted project
- **Parallel runs**: Each invocation gets a unique container name

## Managing credentials

Credentials are stored in the `claude-sandbox-home` Podman volume. To reset:

```bash
podman volume rm claude-sandbox-home
```

