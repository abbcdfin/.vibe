#!/usr/bin/env bash
# Vibe always-on governance injector — OpenAI Codex CLI variant.
#
# Registered as a STANDALONE SessionStart hook in ~/.codex/config.toml (or a
# ~/.codex/hooks.json). It is NOT bundled inside the plugin: Codex's
# `plugin_hooks` feature is removed, so plugin-bundled hooks do not fire — but
# the standalone `hooks` feature is stable. See README (Install — Codex CLI).
#
# Codex SessionStart fires on startup/resume/clear/compact. The hook reads a JSON
# payload on stdin and writes a JSON response on stdout; the string at
# hookSpecificOutput.additionalContext is added as extra developer context. We
# inject the same single-source vibe.md spine used by every other adapter.
set -euo pipefail

cat >/dev/null 2>&1 || true   # drain the hook's stdin JSON payload (unused)

# This script lives in <repo>/hooks/; the spine is one level up. Codex sets no
# plugin-root env var, so resolve relative to the script itself.
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPINE="$ROOT/vibe.md"
[ -f "$SPINE" ] || { printf '{"continue":true}'; exit 0; }

PREAMBLE="# Vibe Framework — Active Operating Governance
The vibe framework is installed. The rules below are ALWAYS in effect for this session. Follow them.

---
"
FULL="$PREAMBLE$(cat "$SPINE")"

# CANDIDATE mode-aware injection (validation harness for the hub-and-spoke proposal).
# shellcheck source=lib-mode.sh
. "$ROOT/hooks/lib-mode.sh"
_mode="$(vibe_detect_mode "$PWD")"
_module="$(vibe_mode_module "$ROOT" "${_mode:-}")"
if [ -n "$_module" ]; then
  FULL="$FULL

---

$(cat "$_module")"
fi

if command -v jq >/dev/null 2>&1; then
  printf '%s' "$FULL" | jq -Rs \
    '{continue: true, hookSpecificOutput: {hookEventName: "SessionStart", additionalContext: .}}'
else
  FULL="$FULL" python3 -c 'import json,os;print(json.dumps({"continue":True,"hookSpecificOutput":{"hookEventName":"SessionStart","additionalContext":os.environ["FULL"]}}))'
fi
