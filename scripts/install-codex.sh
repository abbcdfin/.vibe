#!/usr/bin/env bash
# Install (or remove) the vibe always-on governance hook for OpenAI Codex CLI.
#
# Codex's plugin_hooks feature is removed, so the hook cannot ship inside a
# plugin; it must be registered standalone in Codex's config.toml. This script
# does that idempotently, writing a marker-delimited block so re-runs update in
# place and --uninstall removes it cleanly.
#
# Usage:
#   scripts/install-codex.sh              # install/update the SessionStart hook
#   scripts/install-codex.sh --fallback   # also symlink $CODEX_HOME/AGENTS.md -> vibe.md
#   scripts/install-codex.sh --uninstall  # remove the hook block (and managed symlink)
#   scripts/install-codex.sh --dry-run    # print what would change, write nothing
#
# Respects $CODEX_HOME (defaults to ~/.codex).
set -euo pipefail

BEGIN_MARKER="# >>> vibe governance (managed by scripts/install-codex.sh) >>>"
END_MARKER="# <<< vibe governance <<<"

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HOOK="$ROOT/hooks/inject-governance-codex.sh"
SPINE="$ROOT/vibe.md"
CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
CONFIG="$CODEX_HOME/config.toml"
AGENTS="$CODEX_HOME/AGENTS.md"

FALLBACK=0 UNINSTALL=0 DRY_RUN=0
for arg in "$@"; do
  case "$arg" in
    --fallback)  FALLBACK=1 ;;
    --uninstall) UNINSTALL=1 ;;
    --dry-run)   DRY_RUN=1 ;;
    -h|--help)   sed -n '2,17p' "$0"; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

say()  { printf '%s\n' "$*"; }
run()  { if [ "$DRY_RUN" = 1 ]; then say "[dry-run] $*"; else eval "$*"; fi; }

# Strip any existing managed block from stdin (used for both update and uninstall).
strip_block() {
  awk -v b="$BEGIN_MARKER" -v e="$END_MARKER" '
    $0==b {skip=1; next} $0==e {skip=0; next} !skip {print}
  '
}

# --- sanity checks -----------------------------------------------------------
[ -f "$HOOK" ] || { echo "error: hook script not found: $HOOK" >&2; exit 1; }
[ -f "$SPINE" ] || { echo "error: vibe.md not found: $SPINE" >&2; exit 1; }
if [ ! -x "$HOOK" ]; then
  say "making hook executable: $HOOK"
  run "chmod +x '$HOOK'"
fi

if command -v codex >/dev/null 2>&1; then
  hooks_state="$(codex features list 2>/dev/null | awk '$1=="hooks"{print $3}')"
  case "$hooks_state" in
    true)  say "codex 'hooks' feature: enabled (stable)" ;;
    "")    say "warning: could not read 'codex features list' — proceeding anyway" ;;
    *)     say "warning: codex 'hooks' feature is '$hooks_state', not 'true'. The hook may not fire until enabled." ;;
  esac
else
  say "warning: 'codex' not on PATH — writing config anyway; verify on the target machine."
fi

# --- uninstall ---------------------------------------------------------------
if [ "$UNINSTALL" = 1 ]; then
  if [ -f "$CONFIG" ] && grep -qF "$BEGIN_MARKER" "$CONFIG"; then
    say "removing vibe hook block from $CONFIG"
    if [ "$DRY_RUN" = 1 ]; then
      say "[dry-run] would strip the managed block"
    else
      tmp="$(mktemp)"; strip_block < "$CONFIG" > "$tmp"; cat "$tmp" > "$CONFIG"; rm -f "$tmp" 2>/dev/null || true
    fi
  else
    say "no vibe hook block found in $CONFIG — nothing to remove"
  fi
  if [ -L "$AGENTS" ] && [ "$(readlink "$AGENTS")" = "$SPINE" ]; then
    say "removing managed symlink $AGENTS"
    run "rm -f '$AGENTS'"
  fi
  say "done."
  exit 0
fi

# --- install / update --------------------------------------------------------
say "target config: $CONFIG"
run "mkdir -p '$CODEX_HOME'"

BLOCK="$BEGIN_MARKER
[[hooks.SessionStart]]
[[hooks.SessionStart.hooks]]
type = \"command\"
command = '$HOOK'
timeout = 30
$END_MARKER"

if [ "$DRY_RUN" = 1 ]; then
  say "[dry-run] would ensure this block in $CONFIG:"
  printf '%s\n' "$BLOCK"
else
  tmp="$(mktemp)"
  # Preserve everything except any prior managed block, then append the fresh one.
  if [ -f "$CONFIG" ]; then strip_block < "$CONFIG" > "$tmp"; else : > "$tmp"; fi
  # Ensure a trailing newline before appending.
  [ -s "$tmp" ] && [ "$(tail -c1 "$tmp")" != "" ] && printf '\n' >> "$tmp"
  printf '%s\n' "$BLOCK" >> "$tmp"
  cat "$tmp" > "$CONFIG"; rm -f "$tmp" 2>/dev/null || true
  say "hook registered (idempotent — re-run to update the path safely)."
fi

# --- optional AGENTS.md fallback symlink -------------------------------------
if [ "$FALLBACK" = 1 ]; then
  if [ -e "$AGENTS" ] && [ ! -L "$AGENTS" ]; then
    say "warning: $AGENTS exists and is not a symlink — leaving it untouched."
  elif [ -L "$AGENTS" ] && [ "$(readlink "$AGENTS")" = "$SPINE" ]; then
    say "fallback symlink already correct: $AGENTS -> $SPINE"
  else
    say "linking fallback: $AGENTS -> $SPINE"
    run "ln -sf '$SPINE' '$AGENTS'"
  fi
fi

# --- verify emitted JSON -----------------------------------------------------
if [ "$DRY_RUN" != 1 ]; then
  if out="$(printf '{}' | "$HOOK" 2>/dev/null)"; then
    if command -v jq >/dev/null 2>&1; then
      if printf '%s' "$out" | jq -e '.hookSpecificOutput.additionalContext | length > 0' >/dev/null 2>&1; then
        say "verify: hook emits valid JSON with governance context. ✔"
      else
        say "verify: hook ran but JSON check failed — inspect: printf '{}' | '$HOOK'"
      fi
    else
      say "verify: hook ran (install jq for a full JSON check)."
    fi
  else
    say "verify: hook FAILED to run — inspect: printf '{}' | '$HOOK'"
  fi
fi

say ""
say "Next: start 'codex' in any repo; the vibe rules should appear in context."
say "(SessionStart fires on startup/resume/clear/compact.)"
