# shellcheck shell=bash
# Shared mode detection for the vibe governance hooks.
#
# VIBE_MODE=worker selects the adopted worker module (modes/worker.md) before any
# workspace manifest is read. Manifest-based modes (workspace|hub|spoke) remain
# candidates under validation for the hub-and-spoke proposal.
#
# Sourced by hooks/inject-governance.sh (Claude Code), inject-governance-codex.sh (Codex)
# and inject-governance-agy.sh (Antigravity CLI). Keeps detection single-sourced.

# Echo the active mode (worker, or manifest-derived workspace|hub|spoke), or nothing.
# Passing an explicit empty cwd skips manifest lookup without falling back to $PWD.
vibe_detect_mode() {
  case "${VIBE_MODE:-}" in
    "") ;;
    worker)
      printf '%s' worker
      return 0
      ;;
    *)
      echo "vibe: ignoring unknown VIBE_MODE='$VIBE_MODE'" >&2
      ;;
  esac
  local cwd="${1-$PWD}" manifest=""
  [ -n "$cwd" ] || return 0
  if [ -f "$cwd/workspace.md" ]; then
    manifest="$cwd/workspace.md"                 # workspace-root map
  elif [ -f "$cwd/vdesign/workspace.md" ]; then
    manifest="$cwd/vdesign/workspace.md"         # hub/spoke repo manifest
  fi
  [ -n "$manifest" ] || return 0
  # first `mode:` value; tolerate quotes, trailing comments, whitespace
  sed -n 's/^[[:space:]]*mode:[[:space:]]*["'\'']*\([a-zA-Z]*\).*/\1/p' "$manifest" | head -n1
}

# Echo the path to the module for a mode, if it exists.
vibe_mode_module() {
  local root="$1" mode="$2" f
  [ -n "$mode" ] || return 0
  f="$root/modes/$mode.md"
  [ -f "$f" ] && printf '%s' "$f"
}
