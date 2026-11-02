# Proposal: Release Rules

> **Status: CANDIDATE — not adopted.** Graduation target: a **Releasing** section in
> `skills/agile-principles/reference.md`, and `CHANGELOG.md` named in the spine's "Where
> things live". The rules stay out of the spine: only projects that publish versions need
> them (ADR 0001's reasoning).

## Rules

1. **Notes land in the release commit** — the commit the tag points at. `CHANGELOG.md`
   says what changed for consumers; a breaking or behavioural change adds the steps to
   migrate, as an **Upgrade** line in its entry or, if longer, a guide in `docs/`.
2. **Check the notes against a real upgrade before publishing.** Start from the version
   consumers actually run and follow only the notes; a missing step is a defect. A release
   is published by the first push consumers can install from, which may be a branch rather
   than the tag — so check a scratch install through a copy of that channel, then confirm
   on a real one.
3. **Tag the release commit, and never move a pushed tag.** Annotated, named `v<version>`
   to match the manifests, with the message `v<version> — <summary>`. Push the branch and
   the tag together, to every remote. If a release or its notes prove wrong, cut the next
   patch.

## Where and when

- **Where.** `CHANGELOG.md` sits at the root beside `README.md`, widening the front door to
  the root files written for consumers. A project's release decisions are stable, so one
  ADR in `docs/` records them: the version scheme and what counts as breaking, the tagged
  branch, the channels consumers install from and the push that publishes to each, and
  where fixes for older lines go.
- **When.** A release is an event, not a lifecycle state. It bundles phases already DONE,
  and each phase's DONE summary in `plan.md` names the release that carried it.

## Validation

A real project's release made under all three rules, whether its check passes or catches
a gap. **Run 1**, this repo's v0.8.1, did: the check caught three gaps in the notes (listed
in the release commit) and produced rule 2's channel clause.

## Open questions

1. Does the agent run the upgrade check, or a human? In run 1 the agent did; the human
   gated publishing.
2. Prescribe a changelog format, such as Keep a Changelog, or leave it to each project?
