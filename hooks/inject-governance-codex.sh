#!/usr/bin/env bash
# Vibe always-on governance injector — OpenAI Codex CLI variant.
#
# Bundled in the plugin as a SessionStart hook (.codex-plugin/hooks.json), which
# fires in Codex 0.146.0 after a one-time trust review. Also registerable as a
# standalone hook in ~/.codex/config.toml for anyone who prefers not to trust a
# bundled hook — same script, different wiring. See README (Install — Codex CLI).
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

FULL="$(cat "$SPINE")"

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
