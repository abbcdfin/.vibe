# Proposal: Release Rules

> **Status: CANDIDATE — not adopted.** Awaiting validation, not an active framework rule.
> Graduation target: a **Releasing** section in `skills/agile-principles/reference.md`, and
> `CHANGELOG.md` named in the spine's "Where things live". Not the spine itself — only
> projects that publish versions need these rules, the same reasoning ADR 0001 applied to
> modes.

## Motivation

The framework says nothing about releases, changelogs or tags. Two pieces of evidence:

- **vsigma v0.2.1** — the tag was moved after it was published. That was harmless only
  because nobody had fetched it yet.
- **This repo** — its README "Versioning" paragraph is a changelog growing inside the
  front door, and v0.7.0 and v0.8.0 were tagged without checking an upgrade.

## Rules (project-independent)

1. **Notes land in the release commit, before the tag.** The release commit is the one the
   tag points at. It carries `CHANGELOG.md` (what changed, for consumers) and, for a
   breaking or behavioural change, a migration guide in `docs/`.
2. **A published tag never moves.** If a release is wrong, cut the next patch. A tag is
   published once it has been pushed to any remote; before that it is local and may be
   redone.
3. **Check the notes against a real upgrade before tagging.** Upgrade an actual consumer —
   or, if none exists yet, a scratch install of the previous release — following only the
   notes. A step the notes leave out is a defect in the notes.

## Where and when

- **Where.** `CHANGELOG.md` sits at the root beside `README.md`, as the front door for
  people consuming releases. A migration guide is stable, so it goes in `docs/`. The
  spine's "front door" widens from one file to the root files written for consumers.
- **When.** A release is an **event, not a lifecycle state**: it bundles phases that are
  already DONE (vsigma v0.2.0 carried phases 4.8–4.10). A phase's DONE summary in
  `plan.md` records which release carried it.

## One fact, one place

Three records touch a release. Each holds a different fact, so none restates another:

| Record | Holds | For |
|---|---|---|
| Commit messages | Why each change was made | Maintainers |
| `plan.md` DONE summary | Which release carried the phase | The next session |
| `CHANGELOG.md` | What changed, from the consumer's side | Users |

A changelog entry does not repeat phase internals; `plan.md` points at the release rather
than copying its notes.

## Per project, recorded once

The version scheme (including what counts as breaking), which branch gets the tags, the
remotes a release is pushed to, and where fixes for older lines go. These are release
decisions, so they belong in `docs/` — one ADR is enough.

## Validation

vsigma v0.2.1 shows the rules are **needed**, not that they **work** — it is the mistake
rule 2 prevents. Validation is the next release of a real project made under all three
rules: notes in the release commit, an upgrade check that either passed or caught a gap,
and no tag moved afterwards.

## Open questions

1. **Who runs the upgrade check** — the agent, or a human as a gate before the tag?
2. **Changelog format** — prescribe Keep a Changelog, or leave it to each project?
