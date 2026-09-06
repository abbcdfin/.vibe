#!/usr/bin/env bash
# Vibe always-on governance injector — Antigravity CLI variant.
#
# Fires on PreInvocation. Per Antigravity's hook contract, the command reads a
# JSON payload on stdin and writes a JSON response on stdout of the form:
#
#   {"injectSteps": [{"ephemeralMessage": "<governance text>"}]}
#
# `ephemeralMessage` is a transient system message injected before the model
# runs, so the same single-source vibe.md spine used by the Claude Code hook
# (hooks/inject-governance.sh) is asserted into context.
#
# PreInvocation fires before EACH model invocation (Antigravity has no
# SessionStart event), so the spine is re-asserted each turn — always-on
# governance at the cost of re-injection.
#
# Working directory: Antigravity sets cwd to the directory containing hooks.json
# (the plugin root), so the plugin's own files are addressed relative to "..".
# The user's project is NOT cwd here — it arrives as `workspacePaths` on stdin,
# which is what the mode harness keys off (falling back to $PWD).
set -euo pipefail

# Capture the stdin JSON payload (contains workspacePaths, conversationId, ...).
_stdin="$(cat 2>/dev/null || true)"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPINE="$ROOT/vibe.md"
[ -f "$SPINE" ] || { printf '{"injectSteps":[]}'; exit 0; }

FULL="$(cat "$SPINE")"

# Resolve the user's workspace from the payload (cwd is the plugin dir, not the
# project), so mode detection sees the real project. Fall back to $PWD.
WS=""
if command -v jq >/dev/null 2>&1; then
  WS="$(printf '%s' "$_stdin" | jq -r '.workspacePaths[0] // empty' 2>/dev/null || true)"
fi
[ -n "$WS" ] || WS="$PWD"

# CANDIDATE mode-aware injection (validation harness for the hub-and-spoke proposal).
# shellcheck source=lib-mode.sh
. "$ROOT/hooks/lib-mode.sh"
_mode="$(vibe_detect_mode "$WS")"
_module="$(vibe_mode_module "$ROOT" "${_mode:-}")"
if [ -n "$_module" ]; then
  FULL="$FULL

---

$(cat "$_module")"
fi

if command -v jq >/dev/null 2>&1; then
  printf '%s' "$FULL" | jq -Rs '{injectSteps: [{ephemeralMessage: .}]}'
else
  FULL="$FULL" python3 -c 'import json,os;print(json.dumps({"injectSteps":[{"ephemeralMessage":os.environ["FULL"]}]}))'
fi
