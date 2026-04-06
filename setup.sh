#!/usr/bin/env bash
set -e

REPO_NAME="claude-sandbox"

# Check dependencies
command -v gh &>/dev/null || { echo "GitHub CLI (gh) not found. Install: brew install gh"; exit 1; }
command -v git &>/dev/null || { echo "git not found"; exit 1; }

# Init repo
git init
git add .
git commit -m "Initial commit: Claude Code Podman sandbox"

# Create private GitHub repo and push
gh repo create "$REPO_NAME" --private --source=. --remote=origin --push

echo "Done! Repo created at: https://github.com/$(gh api user -q .login)/$REPO_NAME"