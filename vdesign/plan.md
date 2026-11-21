# Plan

Status: `[ ]` ACCEPTED, `[/]` BUILDING, `[x]` DONE.

## Increments

- [x] 1. Adopt increment progress units — accepted in
  [ADR 0002](../docs/adr/0002-increments-as-progress-units.md).
  Done when: the governance, Agile guidance, initializer and dependent proposals use
  the accepted increment model consistently; IPD and workflow phases retain their
  meanings; migration is documented; affected skills and delivered hook contexts pass
  validation.
  Outcome: adopted across the framework; the proposal now points to canonical guidance.
  Verified: both affected skill validators, all three shell adapter outputs, local
  Markdown links and anchors, and `git diff --check` pass. A review then trimmed the
  spine and restored "done when" where "acceptance criteria" had crept back. Released in
  v0.9.0.
- [x] 2. Antigravity hook never guesses the workspace — done when: a payload without
  `workspacePaths` gets the spine alone, with or without `jq`, and a named workspace still
  gets its mode module. Verified: five cases against a scratch plugin copy carrying a
  decoy `vdesign/workspace.md`. Released in v0.9.0.
- [x] 3. Document kinds and the proposal lifecycle — accepted in
  [ADR 0003](../docs/adr/0003-document-kinds-and-proposal-lifecycle.md).
  Done when: the spine defines design documents and decision records and takes a proposal
  from its candidate line to deletion at DONE; the initializer seeds agree; this repository
  follows both — candidates listed here with proposals in `vdesign/proposals/`, the adopted
  proposal removed, design documents describing the current system; no shipped file names
  this repository's `vdesign/` or `proposals/` by path; every adapter still injects
  `vibe.md` unchanged; local links resolve.
  Outcome: the spine separates living design documents from dated decision records and
  carries a proposal from its candidate line to deletion at DONE; the four candidate
  proposals moved here, the adopted one was removed, and the README's design notes became
  `docs/architecture_design.md`. Verified: the Claude Code, Codex and Antigravity hooks
  inject `vibe.md` byte for byte and a hub manifest still appends its module; `pi/vibe.ts`
  is unchanged and was not run. Both plugin validators, all local Markdown links
  and anchors, and `git diff --check` pass. A peer review then added link repair before a
  proposal's deletion, the limits of ADR upkeep and pending marks for unbuilt design.
  Released in v0.10.0.
- [x] 4. Framework consistency and concision — accepted by the user's cleanup request.
  Done when: governance, roles, skills, initialization and current design documents agree;
  redundant wording and document inconsistencies are removed while committed principle
  defaults, the increment lifecycle and candidate arguments are preserved; installation
  and migration steps remain usable; skill, plugin, link and adapter checks pass; the
  core guidance is shorter. Policy changes require a separate acceptance decision.
  Outcome: retained the consolidation and hub/spoke path fixes; restored committed
  architectural and agentic references verbatim, proposal arguments and failure lists,
  concision rules, rule-name indexes and lazy directory creation. Alternative defaults
  are a separate candidate, with deny-by-default retained. The spine is 817 words and
  the README 585, down from 1,264 and 1,589. No policy ADR was created.
  Verified: four skills, two role definitions, local links and anchors, 18 adapter cases
  with terminal newlines normalized, exact reference/draft preservation and whitespace
  checks. `claude plugin validate .` passes; Antigravity validation passes with its
  expected Claude-hook warning. Live pi validation was not run. Released in v0.10.0.
- [x] 5. Topic design documents — accepted in
  [ADR 0004](../docs/adr/0004-topic-design-documents.md).
  Done when: the spine places feature, component and subsystem designs in
  `docs/design/<topic>.md`, linked from the global design document they refine; the
  initializer creates the directory only with its first document; the changelog carries
  the upgrade step; the adapters inject `vibe.md` unchanged; local links resolve; both
  plugin validators pass.
  Outcome: the spine and initializer place topic designs as decided; this repository has
  none, so nothing moved. Verified: the Claude Code, Codex and Antigravity hooks inject
  `vibe.md` unchanged, the hub manifest still appends its module, 31 files' local links
  resolve, `git diff --check` is clean and both plugin validators pass. Released in v0.10.0.
- [x] 6. Branching — accepted in [ADR 0005](../docs/adr/0005-branching.md).
  Done when: the spine's Lifecycle carries branching rules 1–4 and the release-rules
  candidate takes rule 5; the initializer creates `dev` when absent and installs vibe's
  pre-push hook only when the clone has none; the hook refuses an untagged push of `main`
  and passes a tagged one and other branches; this repository runs the shipped hook; the
  changelog carries the upgrade steps; the adapters inject `vibe.md` unchanged; local
  links resolve; both plugin validators pass.
  Outcome: the spine's Lifecycle carries the branching model (841 → 921 words); the
  release-rules candidate takes the patch rule as rule 6; the initializer creates `dev`
  and installs the shipped `skills/init/pre-push` when no hook exists, and reports and
  skips without `.git/`, a commit or `main`. Built by a delegated developer from a
  reviewed board.
  Verified: the hook against a scratch bare remote (untagged `main` refused, also beside
  `dev`; tagged `main`, `dev` and `inc/*` pass); a real `/vibe:init` through
  `claude --plugin-dir` created `dev` and installed a byte-identical hook; the
  developer's run of the initializer's steps passed seven cases, including no `main`, an
  unborn `main` and no `.git/`. The Claude Code adapter delivers `vibe.md` byte for byte,
  Codex and Antigravity without its final newline as before; both plugin validators pass;
  local links resolve and `git diff --check` is clean. pi was not run.
- [x] 7. Roles — accepted in [ADR 0006](../docs/adr/0006-delegated-work.md).
  Done when: `agents/` holds `architect`, `implementer` and `tester` with the
  responsibilities ADR 0006 gives them, and `software-expert` is gone; no shipped file,
  design document or README names it; the changelog carries the rename as an Upgrade
  step; each role loads as a subagent on Claude Code and Antigravity; both plugin
  validators pass.
  Outcome: `architect`, `implementer` and `tester` (100–107 words each) replace
  `software-expert`; `product-owner`, the spine's Roles and the Agile reference name
  them, and the changelog's Unreleased entry carries the Upgrade step. Built by a
  delegated developer from a reviewed board.
  Verified: each role, `product-owner` included, loads through `claude --plugin-dir`
  as `vibe:<role>` and answers with its own limits, and `vibe:software-expert` is
  reported missing; on Antigravity each loads from a scratch workspace plugin, which
  exposes plugin agents unprefixed. No shipped file or README names `software-expert`;
  both plugin validators pass; the adapters deliver `vibe.md` as before; local links
  resolve and `git diff --check` is clean. pi was not run.
- [x] 8. Delegation rules — accepted in [ADR 0006](../docs/adr/0006-delegated-work.md).
  Done when: the spine states when to delegate, what a brief carries, what a report
  returns, that the delegating session verifies results and owns `plan.md`, the
  checkpoint and decisions, that the implementer drafts the board and stops for review,
  and that workers commit on the increment's branch before handing back. In a scratch
  project, a delegated implementer drafts the board and stops, then builds by the
  approved board, commits on the branch and reports as the spine requires. The adapters
  inject `vibe.md` unchanged. Widened by the user on 2026-11-21 to include the report.
  Outcome: the spine's Delegation section gives when to delegate, the brief, the board
  review, the handback report and commit, and the delegating session's ownership;
  BUILDING has every board task name its verification, as the initializer's template
  now does (934 → 1,059 words). Built by a delegated developer from a reviewed board.
  Verified: in a scratch project through `claude --plugin-dir`, a Sonnet implementer
  given the framed role and a brief that did not mention the board committed only its
  board and stopped; told the board was approved, it committed each task on the branch,
  left `plan.md`, the checkpoint and `dev` alone, and reported each task's commit and
  evidence, then what was not run and a finding; its test passed and failed against a
  broken script. The Claude Code adapter delivers `vibe.md` byte for byte, Codex and
  Antigravity without its final newline as before; both plugin validators pass; local
  links resolve and `git diff --check` is clean. pi was not run.
- [x] 9. Worker mode — accepted in [ADR 0006](../docs/adr/0006-delegated-work.md).
  Done when: `modes/worker.md` holds the worker rules; `hooks/lib-mode.sh` selects it
  when `VIBE_MODE=worker`, before any manifest; the Claude Code, Codex and Antigravity
  hooks deliver the spine and the worker module with the variable, and their current
  output without it; a Claude Code worker launched with the variable and a role in a
  scratch project completes a small brief without creating `vdesign/` or `docs/`; pi's
  behaviour is recorded; the mctl mission pilot is a candidate.
  Outcome: `modes/worker.md` (110 words) replaces the session workflow with working
  inside the brief and limits a worker's `vdesign/` edits to its board;
  `hooks/lib-mode.sh` selects it on `VIBE_MODE=worker` before any manifest and ignores
  other values with a warning, and the Antigravity hook applies it without a workspace.
  pi delivers the spine alone, as the README, the architecture design and `pi/vibe.ts`
  record. Built by a delegated developer from a reviewed board.
  Verified: against `dev`'s hooks, all three adapters' stdout and stderr are unchanged
  without the variable, plain and with a hub manifest; with it they deliver the spine
  and the worker module, which wins over a manifest, Antigravity also without a
  workspace or `jq`; an unknown value warns and changes nothing. Claude Code and
  Antigravity sessions quoted the module only when launched with the variable; Codex was
  checked at the script level. A Sonnet worker given the variable and the implementer
  role completed a small brief in a scratch project, committed on its branch and created
  neither `vdesign/` nor `docs/`; a control run without the variable did the same, so
  that run does not discriminate. shellcheck, both plugin validators, local links and
  `git diff --check` pass. pi was not run.
- [/] 10. Milestones — accepted in [ADR 0007](../docs/adr/0007-milestones.md).
  Done when: the spine's Lifecycle defines a milestone as a heading in `plan.md` with
  its own "done when", accepted with the increments listed under it and DONE when they
  are and its end-to-end check passes; a goal names accepted milestones in order, the
  checkpoint names the goal and the milestone in progress, and running toward a goal
  changes no gate. The initializer's `plan.md` seed shows a milestone heading. In a
  scratch project, a Claude Code session given a goal over a two-increment milestone
  builds both in order, each on its own branch, verifies the milestone and stops. The
  adapters inject `vibe.md` unchanged; both plugin validators pass.
- [ ] 11. Release rules — accepted in [ADR 0008](../docs/adr/0008-release-rules.md).
  Done when: `skills/agile-principles/reference.md` has a Releasing section carrying the
  rules, with the agent running the upgrade check, the user approving publication and no
  prescribed changelog format; the spine names `CHANGELOG.md` in "Where things live";
  the adapters inject `vibe.md` unchanged; local links resolve; both plugin validators
  pass.

## Candidates

- Principle defaults — consider the policy alternatives identified during cleanup;
  committed references remain authoritative. [Proposal](proposals/principle-defaults.md).
- Hub-and-spoke mode — multi-repository workspaces; the `modes/` harness and
  `/vibe:init hub|spoke` exist to validate it. [Proposal](proposals/hub-and-spoke-mode.md).
- Test-driven execution — a failing test as the contract for agentic work.
  [Proposal](proposals/tdd-execution.md).
- Mission pilot — one mctl mission on an increment branch, with an architect supervisor
  and implementer and tester workers, once mctl references roles by name and sets
  `VIBE_MODE=worker`. Record what the board review and the tester caught that the
  implementer did not; watch for workers leaving their briefs or duplicating what they
  could not see, delegation too small to repay its brief, and briefs that drop the why.
  Open: whether the supervisor defaults to `architect`. The tested per-host recipe for
  applying a role is in `git show 3740b6a:vdesign/proposals/delegated-work.md`.
- Validate increment planning in a real project — host project to be selected;
  [pilot criteria](../docs/adr/0002-increments-as-progress-units.md#validation-still-pending).
