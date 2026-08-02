# Shared mode detection for the vibe governance hooks.
#
# CANDIDATE / validation harness for proposals/hub-and-spoke-mode.md. This lets the
# always-on hook append a draft modes/<mode>.md module based on the workspace manifest
# in the launch cwd. Not adopted framework doctrine.
#
# Sourced by hooks/inject-governance.sh (Claude Code) and
# hooks/inject-governance-agy.sh (Antigravity CLI). Keeps detection single-sourced.

# Echo the active mode (workspace|hub|spoke) for the given cwd, or nothing (single).
vibe_detect_mode() {
  local cwd="${1:-$PWD}" manifest=""
  if [ -f "$cwd/workspace.md" ]; then
    manifest="$cwd/workspace.md"                 # workspace-root map
  elif [ -f "$cwd/vdesign/workspace.md" ]; then
    manifest="$cwd/vdesign/workspace.md"         # hub/spoke repo manifest
  fi
  [ -n "$manifest" ] || return 0
  # first `mode:` value; tolerate quotes, trailing comments, whitespace
  sed -n 's/^[[:space:]]*mode:[[:space:]]*["'\'']*\([a-zA-Z]*\).*/\1/p' "$manifest" | head -n1
}

# Echo the path to the draft module for a mode, if it exists.
vibe_mode_module() {
  local root="$1" mode="$2" f
  [ -n "$mode" ] || return 0
  f="$root/modes/$mode.md"
  [ -f "$f" ] && printf '%s' "$f"
}
