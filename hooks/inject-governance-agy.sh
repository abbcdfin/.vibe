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
# which manifest detection keys off. cwd is never a fallback: absent a workspace,
# only VIBE_MODE=worker appends a module; otherwise the spine alone is injected.
set -euo pipefail

# Capture the stdin JSON payload (contains workspacePaths, conversationId, ...).
_stdin="$(cat 2>/dev/null || true)"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPINE="$ROOT/vibe.md"
[ -f "$SPINE" ] || { printf '{"injectSteps":[]}'; exit 0; }

# Resolve the user's workspace from the payload, with jq or, failing that, python3.
_first_ws() {
  if command -v jq >/dev/null 2>&1; then
    jq -r '.workspacePaths[0] // empty' 2>/dev/null
  else
    python3 -c 'import json,sys
try: print((json.load(sys.stdin).get("workspacePaths") or [""])[0])
except Exception: pass' 2>/dev/null
  fi
}
WS="$(printf '%s' "$_stdin" | _first_ws || true)"

# Mode-aware injection: VIBE_MODE=worker is adopted; workspace manifests remain candidates.
# shellcheck source=lib-mode.sh
. "$ROOT/hooks/lib-mode.sh"
_mode="$(vibe_detect_mode "$WS")"
if [ -z "$WS" ] && [ -z "$_mode" ]; then
  echo "vibe: no workspacePaths in the PreInvocation payload; mode modules skipped" >&2
fi
_module="$(vibe_mode_module "$ROOT" "${_mode:-}")"

_emit_payload() {
  cat "$SPINE"
  if [ -n "$_module" ]; then
    printf '\n\n---\n\n'
    cat "$_module"
  fi
}

if command -v jq >/dev/null 2>&1; then
  _emit_payload | jq -Rs '{injectSteps: [{ephemeralMessage: .}]}'
else
  _emit_payload | python3 -c 'import json,sys;print(json.dumps({"injectSteps":[{"ephemeralMessage":sys.stdin.read()}]}))'
fi
