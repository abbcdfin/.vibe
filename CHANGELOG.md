# Changelog

What changed in each vibe release, newest first, for the people who install it. Update
the plugin as your tool's section of the [README](README.md) describes; an **Upgrade**
line names any further step a release needs. Versions follow
[Semantic Versioning](https://semver.org/) in its 0.x form: a minor version adds or
changes a feature, and a patch fixes one.

## Unreleased

- Distinguishes living design documents from historical ADRs. Accepted but unbuilt
  design is marked pending; ADR upkeep preserves the original decision and reasoning.
- Lists every candidate in the plan and deletes its proposal at DONE, after preserving
  the decision and redirecting surviving links.
- Gives a feature, component or subsystem design its own `docs/design/<topic>.md`,
  linked from the global design document it refines. The two global documents stay at
  the root of `docs/`.
- Shortens governance, skill entry points, roles and setup instructions while preserving
  the committed architectural and agentic principle defaults.
- Aligns experimental hub/spoke planning paths and marks workspace-root initialization
  as proposed. The initializer preserves existing content and avoids repeating resolved
  target questions.
- Documents Antigravity update steps and the staging path checked with CLI 1.4.4.
- **Upgrade:** list proposals missing from `## Candidates`. Before deleting a DONE
  proposal, preserve its decision in `docs/` and redirect links there or to a Git revision.
  Move topic design documents from the root of `docs/` into `docs/design/`, link each
  from its global design document, and repoint other links to it.

## v0.9.0 — 2026-11-04

- Adopts increment progress units: persistent "done when", optional slices and tasks,
  explicit scope boundaries, verification at DONE and release tracking after publication.
- Increment acceptance is distinct from IPD Decision Check Points. IPD Lifecycle Phases
  retain their names; increments use the activities appropriate to their outcome.
- Updates governance, Agile guidance, initializer seeds and dependent proposals.
- **Upgrade:** existing plans switch from phases to increments at their next increment;
  DONE history stays as written. Keep each new increment's "done when" in `plan.md` or
  a referenced specification, and have `active_plan.md` point to it.
- The README gains Codex update steps: install the plugin again, after
  `codex plugin marketplace upgrade uc-labs` for the Git marketplace.
- Antigravity: when the hook payload names no workspace, the hook injects the spine alone
  instead of reading the plugin's own directory for a workspace manifest.

## v0.8.1 — 2026-10-29

- Release notes move here from the README.
- The README's Claude Code update steps gain the missing
  `claude plugin update vibe@uc-labs`; `marketplace update` alone leaves the old version.
- The v0.8.0 entry gains the upgrade step it shipped without, and `/vibe:init` now
  migrates an old `vdesign/env.md` by that step.
- Adds `proposals/release-rules.md`, a candidate not yet in effect.

## v0.8.0 — 2026-10-08

- `vdesign/env.md` is renamed `vdesign/dev_env.md` and scoped to the development
  environment: setup, toolchains, local paths, and the variables you set to work here.
- **Upgrade:** in each project with a `vdesign/env.md`, rename it to `dev_env.md` —
  `/vibe:init` does this. Then move out what describes the built system: a runtime
  variable or deployment target to `docs/architecture_design.md`, an imposed limit to
  `vdesign/constraints.md`, creating either file if the project lacks it. A variable
  that is both, such as a URL you override to run locally, is defined in
  `docs/architecture_design.md`; `dev_env.md` keeps only the value you set.

## v0.7.0 — 2026-10-05

- Adds the `agile-principles` skill, the method layer — how work is sequenced, built
  and verified — beside the architectural (structure) and agentic (domain) skills. It
  maps the twelve Agile Manifesto principles onto the framework machinery that
  discharges each, and carries "build thin, then widen", with fail-loud as its engine.
  The spine's Lifecycle points at it.

## v0.6.0 — 2026-09-06

- The spine is re-based on two axes: **where** an artifact lives (volatility) and
  **when** work advances (the DRAFT → ACCEPTED → BUILDING → DONE lifecycle). Adds an
  Output discipline section.
- The injection preamble moves into `vibe.md`, so all four adapters are pure transport
  over one file.

## v0.5.0 — 2026-08-16

- The initializer is a single plugin-namespaced `init` skill, invoked as `/vibe:init`
  on Claude Code, Codex and Antigravity. Claude's `commands/init.md` is dropped.
- **Upgrade:** invoke `/vibe:init` on every tool; the `vibe:vibe-init` skill is gone.

## v0.4.1 — 2026-08-15

- Fixes the Antigravity `PreInvocation` hook: flat schema, the `injectSteps` /
  `ephemeralMessage` output contract, and a relative path that works from any install
  location. Verified firing live on the `agy` CLI.

## v0.4.0 — 2026-08-15

- Ports the `/vibe:init` initializer to a cross-tool skill, for Antigravity and Codex,
  which do not load Claude's `commands/`.

## v0.3.0 — 2026-08-07

- Adds OpenAI Codex CLI and pi adapters.

## v0.2.0 — 2026-08-02

- The first plugin form, for Claude Code and Antigravity CLI.

## v0.1.0 — 2026-07-31

- The pre-plugin framework, embedded in each repository as `.vibe/`.
