# Increment 12 — Release review and concision

Done when: [increment 12 in the plan](plan.md#increments).

## Slice 1 — Corrections

- [x] **Fix spine and worker-mode rule gaps** — in `vibe.md`, change checkbox rule to tasks only, name a delegated increment build in `Delegation`'s board rule, and allow updating the checkpoint when a goal starts; align `modes/worker.md`'s board note with delegated increment builds — verify: inspect `git diff vibe.md modes/worker.md` against increment 12's contract and `vdesign/constraints.md`.
- [ ] **Fix Agile method index, draft modes, and initializer procedure** — align `skills/agile-principles/SKILL.md`'s Method names with `skills/agile-principles/reference.md`; replace obsolete `context sync` with `Session workflow` in `modes/hub.md`, `modes/spoke.md`, `modes/workspace.md` and `skills/init/reference.md`; state the v0.8.0 `vdesign/env.md` → `vdesign/dev_env.md` rename inline in `skills/init/reference.md`; fix hub mode's board link to `../plan.md#increments` — verify: inspect `git diff`, confirm `git grep -i "context sync" -- modes/ skills/` returns 0 matches, and run the `agile-principles` skill frontmatter/length check.

## Slice 2 — Consumer and design text

- [ ] **Align manifests, README, architecture design, and candidate proposals** — unify descriptions across `.claude-plugin/plugin.json`, `.claude-plugin/marketplace.json`, `.codex-plugin/plugin.json`, `plugin.json` and `package.json` (dropping cross-manifest notes) and add `"version": "0.10.0"` to `plugin.json` only (matching the other manifests); update `README.md` (`## Components` table with worker mode and `## Initialize a project` with `dev`, `pre-push` and worker mode); verify Codex's role discovery empirically on `codex-cli` and record how each host exposes roles in `docs/architecture_design.md`; update stale terms in `vdesign/proposals/hub-and-spoke-mode.md` and `vdesign/proposals/tdd-execution.md` — verify: validate JSON across all manifests, run `agy plugin validate . --json` (confirm no missing-version warning), and verify local Markdown links resolve.

## Slice 3 — Adapters

- [ ] **Preserve `vibe.md`'s final newline in Codex and Antigravity hooks** — update `hooks/inject-governance-codex.sh` and `hooks/inject-governance-agy.sh` so all three shell hooks deliver `vibe.md` byte for byte and append mode modules with identical layout (both `jq` and `python3` paths) — verify: run `bash -n hooks/*.sh`, `shellcheck -x -P hooks hooks/*.sh` via `uvx`, and adapter matrix (plain byte-for-byte equal to `vibe.md`, `VIBE_MODE=worker` and hub manifest byte-for-byte equal to Claude Code's layout, `VIBE_MODE=bogus` warns on stderr and matches plain/hub, Antigravity with/without `workspacePaths` and with/without `jq`).

## Slice 4 — Spine concision

- [ ] **Tighten `vibe.md` without moving or dropping any rule, then run final verification** — tighten `vibe.md` prose (keeping a short binding opening sentence, folding `vdesign/utils/` into the `Inside vdesign/:` table, keeping all rules including "Build thin, then widen" and IPD, preserving referenced headings/terms and plain behaviour-critical wording) and compile the sentence-by-sentence rule map — verify: check `wc -w vibe.md` (before `1,155` vs after), audit the rule map, re-run the full byte-for-byte adapter matrix, `agy plugin validate . --json`, `agile-principles` frontmatter check, `shellcheck`, local Markdown links check, and `git diff --check dev..HEAD`.
