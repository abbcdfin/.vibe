# Proposal: Release Rules

> **Status: CANDIDATE — not adopted.** Graduation target: a **Releasing** section in
> `skills/agile-principles/reference.md`, and `CHANGELOG.md` named in the spine's "Where
> things live". Not the spine itself: only projects that publish versions need these
> rules, the reasoning ADR 0001 applied to modes.

The framework says nothing about releases, changelogs or tags.

## Rules

1. **Notes land in the release commit** — the commit the tag points at. It carries
   `CHANGELOG.md` (what changed, for consumers) and, for a breaking or behavioural change,
   the steps to migrate: an **Upgrade** line in the entry, or a guide in `docs/` once the
   steps outgrow one.
2. **Check the notes against a real upgrade before publishing.** Start from the version a
   consumer actually runs and follow only the notes; a step they leave out is a defect. A
   release is published by the first push a consumer can install from — possibly a branch,
   not the tag — so check on a scratch install through a copy of that channel, and confirm
   on a real consumer once published.
3. **Tag the release commit, and never move a published tag.** Once the check passes, tag
   with an annotated tag named `v<version>` — the version every manifest carries — and the
   message `v<version> — <one-line summary>`. Push the branch and the tag together, to
   every remote. A tag is published once it is pushed to any remote; if a release or its
   notes are wrong, cut the next patch.

## Where and when

- **Where.** `CHANGELOG.md` sits at the root beside `README.md`: the front door widens to
  the root files written for consumers. A migration guide is stable, so it goes in `docs/`.
- **When.** A release is an **event, not a lifecycle state**: it bundles phases already
  DONE, and a phase's DONE summary in `plan.md` names the release that carried it.

Each record holds one fact: a commit message why a change was made, `plan.md` which
release carried a phase, `CHANGELOG.md` what changed for consumers. None restates another.

## Per project

Record once, in an ADR in `docs/`: the version scheme and what counts as breaking, the
tagged branch, the channels consumers install from and the push that publishes to each,
and where fixes for older lines go.

## Validation

A real project's next release made under all three rules: notes in the release commit, an
upgrade check that passed or caught a gap, and no tag moved afterwards.

**Run 1 — this repo, v0.8.1.** The check, from 0.7.0, caught three gaps in the notes
(listed in the release commit) and produced rule 2's channel clause: the `uc-labs`
marketplace clones `main`, so pushing `main` publishes. Tagged and pushed with `main`
to both remotes, then confirmed by upgrading the real install from 0.7.0 to 0.8.1.

## Open questions

1. Who runs the upgrade check — the agent, or a human gate? In run 1 the agent did;
   publishing, which the confirmation needs, was the human's gate anyway.
2. Prescribe a changelog format such as Keep a Changelog, or leave it to each project?
