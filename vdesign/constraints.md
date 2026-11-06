# Constraints

- Files the plugin ships — `vibe.md`, `skills/`, `agents/`, `modes/`, `hooks/` — are read
  inside users' projects, where a relative path resolves against the user's repository.
  Never point them at this repository's own `vdesign/` or `docs/` by path; name the thing
  instead ([ADR 0003](../docs/adr/0003-document-kinds-and-proposal-lifecycle.md)).
