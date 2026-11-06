# ADR 0004: Topic design documents in `docs/design/`

- **Status:** Accepted
- **Date:** 2026-11-06
- **Decider:** Jian Zhang

## Context

The spine names two design documents, `product_specification.md` and
`architecture_design.md`, and keeps `docs/` flat until it outgrows roughly five files.
A project that designs a feature, component or subsystem in more depth adds files beside
those two, so the global documents lose their place as entry points, and the threshold
forces a reorganization partway through the project.

## Decision

- The two global design documents stay at the root of `docs/`.
- A feature, component or subsystem that needs more than its share of a global document
  gets `docs/design/<topic>.md`, linked from the global document it refines. That
  document serves as the index.
- `docs/design/` is created with its first document, not at initialization.
- Topic documents are design documents under [ADR 0003](0003-document-kinds-and-proposal-lifecycle.md):
  living, with pending marks for accepted but unbuilt parts.

## Alternatives rejected

- **Keep `docs/` flat until about five files.** Every project reorganizes midway, and
  links break when it does.
- **Move all design documents, the global two included, into `docs/design/`.** Every
  existing project, the initializer and the spine name the global documents by path;
  moving them costs a migration and gains nothing.
- **A separate index file.** It repeats what the global documents already link to and
  drifts from them.

## Consequences

- An existing project moves topic designs from the root of `docs/` into `docs/design/`
  and repoints links to them; the v0.10.0 changelog carries the step.
- The five-file threshold still governs any other kind of document in `docs/`.
