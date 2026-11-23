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
  Released in v0.11.0.
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
  Released in v0.11.0.
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
  Released in v0.11.0.
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
  Released in v0.11.0.
- [x] 10. Milestones — accepted in [ADR 0007](../docs/adr/0007-milestones.md).
  Done when: the spine's Lifecycle defines a milestone as a heading in `plan.md` with
  its own "done when", accepted with the increments listed under it and DONE when they
  are and its end-to-end check passes; a goal names accepted milestones in order, the
  checkpoint names the goal and the milestone in progress, and running toward a goal
  changes no gate. The initializer's `plan.md` seed shows a milestone heading. In a
  scratch project, a Claude Code session given a goal over a two-increment milestone
  builds both in order, each on its own branch, verifies the milestone and stops. The
  adapters inject `vibe.md` unchanged; both plugin validators pass.
  Outcome: the spine's Lifecycle defines milestone headings with their own "done when",
  verified on `dev` once their increments are DONE, and goals as ordered milestones
  that change no gate; ACCEPTED numbers a milestone's increments, and its DONE
  triggers a checkpoint update (1,059 → 1,147 words). The initializer's seed shows the
  heading and `product-owner` prepares milestones. Built by a delegated developer from
  a reviewed board.
  Verified: in a scratch project through `claude --plugin-dir`, a Sonnet session given
  "Goal: milestone M1" built both increments in order, each marked BUILDING on `dev`,
  built on its own branch, merged with `--no-ff` and deleted; it then verified M1 on
  `dev`, including a README requirement neither increment's check covered, recorded M1's
  outcome under its heading and stopped without touching `main`. The tests and all four
  invocations pass when run independently. The adapters deliver `vibe.md` as before;
  both plugin validators pass; local links resolve and `git diff --check` is clean. pi
  was not run.
  Released in v0.11.0.
- [x] 11. Release rules — accepted in [ADR 0008](../docs/adr/0008-release-rules.md).
  Done when: `skills/agile-principles/reference.md` has a Releasing section carrying the
  rules, with the agent running the upgrade check, the user approving publication and no
  prescribed changelog format; the spine names `CHANGELOG.md` in "Where things live";
  the adapters inject `vibe.md` unchanged; local links resolve; both plugin validators
  pass.
  Outcome: the Agile reference's Releasing section carries the six rules, where and when
  to release, and ADR 0008's answers; the skill's description now triggers on cutting a
  release. The spine names `CHANGELOG.md` and routes releasing to `agile-principles`
  (1,147 → 1,155 words). Built by a delegated developer from a reviewed board.
  Verified: a Haiku session asked about cutting a release named `vibe:agile-principles`
  from its description. The adapters deliver `vibe.md` as before; both plugin
  validators pass, including the skill's frontmatter; local links resolve and
  `git diff --check` is clean. pi was not run.
  Released in v0.11.0.
- [x] 12. Release review and concision — accepted by the user on 2026-11-21 from the
  v0.11.0 content review.
  Done when: the spine says only tasks use plain checkboxes; Delegation's board rule
  names a delegated increment build; the checkpoint may be updated when a goal starts;
  the Agile skill's method index names its reference's rules; every host manifest
  describes the current framework and carries the same version as the others; the
  README lists worker
  mode among its components and mentions `dev` and the pre-push hook under
  initialization; the draft mode modules and the initializer say "session workflow";
  the initializer states the v0.8.0 rename itself; the hub board links
  `../plan.md#increments`; the architecture design records how each host exposes roles;
  candidate proposals use current terms; every adapter delivers `vibe.md` byte for byte.
  The spine is shorter with every rule kept in it, checked rule by rule, and the
  increment 8, 9 and 10 behaviour checks pass again against it. Both plugin validators
  pass without a missing-version warning; local links resolve.
  Outcome: the review's corrections landed in the spine, `modes/worker.md`, the Agile
  index, the draft modes and the initializer; the five manifests share one current
  description (Codex's without roles, which it does not load) and Antigravity's gains a
  version; the README and the architecture design describe worker mode, initialization
  and per-host role discovery; the Codex and Antigravity hooks keep `vibe.md`'s final
  newline. The spine went from 1,155 to 1,054 words with every rule kept, mapped rule by
  rule; the lead's review restored eight places where shortening had changed meaning.
  Built by a delegated developer from a reviewed board.
  Verified: 32 adapter cases on the `jq` and `python3` paths deliver `vibe.md` byte for
  byte, append worker and hub modules in one layout and warn on an unknown value.
  Against the final spine, in scratch projects through `claude --plugin-dir`, a
  delegated implementer committed only its board and stopped, then built by it and
  reported each task's commit and evidence; a worker completed its brief without
  creating `vdesign/` or `docs/`, and sessions saw the worker module only with the
  variable; a goal over a two-increment milestone ran both in order on their branches,
  verified M1 on `dev` and stopped. Both plugin validators pass with no version warning;
  shellcheck, local links and `git diff --check` are clean. pi was not run.
  Released in v0.11.0.
- [x] 13. Verification by review — accepted by the user on 2026-11-23, to stop roles
  rerunning checks another role already ran; widened the same day to set when the full
  suite runs.
  Done when: `skills/agile-principles/reference.md` has a Verifying section: a check
  runs once, where the work is done, and is reported as command, result and commit;
  later verifiers check that the evidence proves its "done when" item and read the diff
  for logic gaps, adding only the missing checks; they rerun only when evidence is
  missing, stale, contradicted by the diff or could not run where the work was done, and
  then only the checks covering what changed or is in doubt. Tasks and slices run the
  checks covering what they change; the full suite runs once per increment, by the
  session that owns DONE, after merging `dev` into the increment branch and before
  merging it into `dev`; milestone verification adds end-to-end checks without another
  full run. The role running a check judges which checks cover a change and what the
  full suite is; vibe names no commands. The spine's Lifecycle carries the cadence
  (BUILDING and DONE) and Delegation's Ownership the review rule in one sentence;
  `agents/implementer.md` runs the covering checks, not the full suite;
  `agents/tester.md` reviews evidence first and spends execution on unproven logic, edge
  and failure cases; the architecture design records the rationale. In scratch projects,
  each in at least 4 of 5 Sonnet runs: a session verifying a slice handback with current
  evidence finds a planted logic defect and reruns none of the reported checks; with
  stale evidence it reruns only the checks covering the change; completing the increment
  it runs the full suite once, after merging `dev` and before merging into `dev`. The
  adapters deliver `vibe.md` byte for byte; both plugin validators pass; local links
  resolve.
  Outcome: the Agile reference's Verifying section carries run-once evidence, review
  before rerun, four rerun exceptions, the cadence and the judgment rule; the spine's
  Lifecycle names the covering checks per task, one full-suite run at DONE and no extra
  run at a milestone, and Ownership reviews rather than reruns (1,054 → 1,079 words). The
  implementer runs covering checks; the tester reviews first. Built by a delegated
  developer from reviewed boards; the lead tightened wording in four places. Early checks
  with only "narrowest check" wording reran the full suite on stale evidence in 4 of 4
  runs, which led to the cadence.
  Verified: in scratch projects through `claude --plugin-dir` with Sonnet, 5 of 5 runs
  each found a planted defect in a slice handback with no rerun; reran only the covering
  tests on stale evidence (and caught the refactor's regression by review); and, completing
  the increment, merged `dev`, ran the full suite once and then merged into `dev`. The
  lead's single full run at DONE: 21 adapter cases byte for byte on the `jq` and
  `python3` paths, both plugin validators, shellcheck, 67 local links and
  `git diff --check`. pi was not run.
  Released in v0.12.0.

## Candidates

- Principle defaults — consider the policy alternatives identified during cleanup;
  committed references remain authoritative. The v0.11.0 review found the Boy Scout
  Rule contradicting the spine's scope rule, and a default to always generate a
  Dockerfile, Makefile and CI. [Proposal](proposals/principle-defaults.md).
- Hub-and-spoke mode — multi-repository workspaces; the `modes/` harness and
  `/vibe:init hub|spoke` exist to validate it. Decide whether to schedule validation or
  withdraw the draft modules from the shipped hooks.
  [Proposal](proposals/hub-and-spoke-mode.md).
- Tighter pre-push hook — accept only an annotated `v*` tag, and refuse `main` when its
  tag is neither in the push nor on the remote; today any local tag passes.
- `uv` outside the spine — the Python-specific default rides in every session; move it
  to `dev_env.md` guidance or the initializer.
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
  Include one milestone of at least two increments run under a goal
  ([ADR 0007](../docs/adr/0007-milestones.md)): record each stop and whether a gate
  caused it, and whether the end-to-end check caught what the increments' checks did
  not.
