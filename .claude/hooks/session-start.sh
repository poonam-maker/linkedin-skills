#!/bin/bash
# Cloud-session setup: install the Python deps and make the 11 skills
# available to Claude Code. Safe to run more than once.
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../.." && pwd)}"
cd "$PROJECT_DIR"

pip install --quiet --disable-pip-version-check -r requirements.txt

mkdir -p "$HOME/.claude/skills"
for dir in skills/*/; do
  name="$(basename "$dir")"
  ln -sfn "$PROJECT_DIR/skills/$name" "$HOME/.claude/skills/$name"
done
