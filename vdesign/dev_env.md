# Development Environment

- Local checkout: `/home/jian/playground/vibe-coding/vibe`.
- Bash, `jq`, Node.js and Python 3 are available. Use `uv run` for Python commands.
- `package.json` supplies pi extension metadata; it declares no build or test scripts.
- Governance hook smoke checks can invoke the scripts in `hooks/` from a temporary
  workspace and compare their delivered text with `vibe.md`.
