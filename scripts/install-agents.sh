#!/bin/sh
# Install the /prompt-pilot command for supported AI coding agents.
#
# Usage:
#   scripts/install-agents.sh                # install globally for every detected agent
#   scripts/install-agents.sh --project      # install into the current project instead
#   scripts/install-agents.sh codex opencode # only these agents (codex|opencode|gemini|cursor)
#
# Claude Code is not handled here — install it as a plugin:
#   /plugin marketplace add savasturkoglu/promptpilot
#   /plugin install prompt-pilot@promptpilot

set -eu

REPO_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
AGENTS_DIR="$REPO_DIR/agents"

SCOPE=global
TARGETS=""
for arg in "$@"; do
  case "$arg" in
    --project) SCOPE=project ;;
    codex|opencode|gemini|cursor) TARGETS="$TARGETS $arg" ;;
    *) echo "Unknown argument: $arg" >&2; exit 1 ;;
  esac
done
[ -n "$TARGETS" ] || TARGETS="codex opencode gemini cursor"

install_file() { # $1=src $2=dest-dir $3=label
  mkdir -p "$2"
  cp "$1" "$2/"
  echo "  ✔ $3 → $2/$(basename "$1")"
}

echo "Installing /prompt-pilot ($SCOPE):"
for t in $TARGETS; do
  case "$t" in
    codex)
      # Codex custom prompts are global-only.
      install_file "$AGENTS_DIR/codex/prompt-pilot.md" "${CODEX_HOME:-$HOME/.codex}/prompts" "Codex CLI"
      ;;
    opencode)
      if [ "$SCOPE" = project ]; then
        install_file "$AGENTS_DIR/opencode/prompt-pilot.md" ".opencode/command" "OpenCode"
      else
        install_file "$AGENTS_DIR/opencode/prompt-pilot.md" "${XDG_CONFIG_HOME:-$HOME/.config}/opencode/command" "OpenCode"
      fi
      ;;
    gemini)
      if [ "$SCOPE" = project ]; then
        install_file "$AGENTS_DIR/gemini/prompt-pilot.toml" ".gemini/commands" "Gemini CLI"
      else
        install_file "$AGENTS_DIR/gemini/prompt-pilot.toml" "$HOME/.gemini/commands" "Gemini CLI"
      fi
      ;;
    cursor)
      if [ "$SCOPE" = project ]; then
        install_file "$AGENTS_DIR/cursor/prompt-pilot.md" ".cursor/commands" "Cursor"
      else
        install_file "$AGENTS_DIR/cursor/prompt-pilot.md" "$HOME/.cursor/commands" "Cursor"
      fi
      ;;
  esac
done
echo "Done. Restart the agent (or open a new session) and type /prompt-pilot"
