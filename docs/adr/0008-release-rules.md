# ADR 0008: Release rules in the Agile principles

- **Status:** Accepted
- **Date:** 2026-11-21
- **Decider:** Jian Zhang

## Context

Only projects that publish versions release, yet each release needs notes consumers
can follow, a fixed commit and a channel that carries only releases. vibe's v0.8.1
release, made under draft rules, caught three gaps in its notes before publication.
[ADR 0005](0005-branching.md) left the install channel and patches to these rules.

## Decision

- The rules live in a **Releasing** section of the Agile principles, outside the
  governance spine; the spine names `CHANGELOG.md` among the root files.
- Notes land in the release commit; a breaking or behavioural change carries the steps
  to migrate. No changelog format is prescribed.
- Before publishing, the agent checks the notes against a real upgrade from the version
  consumers run, following only the notes; the user approves publication.
- Releases are annotated tags `v<version>`, never moved once pushed and pushed with the
  branch to every remote. Every build names its commit, keeping manifest versions plain
  SemVer.
- Consumers install only releases, from `main`; a patch that must ship without
  unreleased work branches from the release tag as `fix/<slug>`.
- A release is an event, not a lifecycle state; publication is added to each released
  increment's DONE record.

## Alternatives rejected

- **Rules in the spine.** Every session would carry rules most projects never use
  ([ADR 0001](0001-mode-specific-rules-via-injection.md)'s reasoning).
- **Prescribe a changelog format.** A format does not make notes correct; the upgrade
  check does.
- **A human runs the upgrade check.** The agent can follow the notes literally in a
  scratch install; the user keeps the publication gate, as in v0.8.1.
- **A `-dev` version for unreleased work.** Updaters would receive it.

## Consequences

- vibe's v0.11.0 is cut under these rules as their second validation run.
- A project that publishes records its version scheme, channels and where fixes go in
  one ADR.
