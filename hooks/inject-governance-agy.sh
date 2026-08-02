#!/usr/bin/env bash
# Vibe always-on governance injector — Antigravity CLI variant.
#
# Fires on PreInvocation. Antigravity expects the hook to read a JSON payload on
# stdin and write a JSON response to stdout with an `additionalContext` string,
# which is appended to the agent's prompt. We inject the same single-source
# vibe.md spine used by the Claude Code hook (hooks/inject-governance.sh).
#
# NOTE: PreInvocation fires before each invocation (Antigravity has no
# SessionStart event), so the spine is re-asserted each turn. That guarantees
# always-on governance at the cost of re-injection. If Antigravity's rules/
# directory turns out to auto-load, that is a lighter one-time alternative.
set -euo pipefail

cat >/dev/null 2>&1 || true   # drain the hook's stdin JSON payload (unused)

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SPINE="$ROOT/vibe.md"
[ -f "$SPINE" ] || { printf '{"allow_tool":true,"additionalContext":""}'; exit 0; }

PREAMBLE="# Vibe Framework — Active Operating Governance
The vibe framework is installed. The rules below are ALWAYS in effect for this session. Follow them.

---
"
FULL="$PREAMBLE$(cat "$SPINE")"

if command -v jq >/dev/null 2>&1; then
  printf '%s' "$FULL" | jq -Rs '{allow_tool: true, additionalContext: .}'
else
  FULL="$FULL" python3 -c 'import json,os;print(json.dumps({"allow_tool":True,"additionalContext":os.environ["FULL"]}))'
fi
