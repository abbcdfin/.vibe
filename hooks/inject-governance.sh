#!/usr/bin/env bash
# Vibe always-on governance injector.
#
# Fires on SessionStart (every session: startup, resume, clear, compact, fork).
# Whatever this script writes to stdout is added to Claude's context, so the
# vibe governance spine is loaded automatically in every project — no per-repo
# setup required. This is the reliable stdout-based path (see README for the
# user-level CLAUDE.md fallback).
set -euo pipefail

# CLAUDE_PLUGIN_ROOT is set by Claude Code; fall back to this script's parent
# for direct/manual invocation and testing.
ROOT="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)}"

SPINE="$ROOT/vibe.md"
[ -f "$SPINE" ] || { echo "vibe: governance spine not found at $SPINE" >&2; exit 0; }

cat "$SPINE"

# CANDIDATE mode-aware injection (validation harness for the hub-and-spoke proposal).
# Appends a draft modes/<mode>.md based on the workspace manifest in the launch cwd.
# shellcheck source=lib-mode.sh
. "$ROOT/hooks/lib-mode.sh"
_mode="$(vibe_detect_mode "$PWD")"
_module="$(vibe_mode_module "$ROOT" "${_mode:-}")"
if [ -n "$_module" ]; then
  printf '\n\n---\n\n'
  cat "$_module"
fi
