# Proposal: Hub-and-Spoke (Multi-Repository) Mode

> **Status: CANDIDATE — not adopted.** This is a proposal awaiting validation, not an
> active framework rule. Do **not** treat it as doctrine. It must be run manually on at
> least one real multi-repository project and pass a Decision Check Point before it
> graduates into the framework. Per [ADR 0001](../docs/adr/0001-mode-specific-rules-via-injection.md),
> the graduation target is `modes/` (loaded by mode-dependent injection), **not** `vibe.md`.

## Motivation

The current framework assumes a **single repository**: one `vdesign/` (volatile process
memory) and one `docs/` (stable outcomes) living beside one codebase. This breaks down when
a product is built from **multiple components, each in its own repository** (e.g. a firmware
repo, a mobile app, and a backend) that must evolve against **shared, cross-cutting
contracts**.

Left unaddressed, agents working across such repos re-invent shared data structures locally,
duplicate cross-stack plans, and lose track of which repo owns a given decision — directly
violating **One Fact, One Place (#1)**.

This proposal adds an opt-in **hub-and-spoke mode** so a user can declare a multi-repo
workspace and have the agent operate coherently across it.

## The core idea: scope, don't fork

Multi-repo is **not a new model** — it is the existing `vdesign/` (volatile) + `docs/`
(stable) split projected onto two **scopes**:

* **Global (hub):** cross-cutting concerns that belong to no single component — the
  cross-stack roadmap, global constraints, and the **contracts/schemas** that define the
  seams between components.
* **Local (spoke):** each component repo is a **normal single-repo vibe project**, with its
  own `vdesign/` and `docs/` scoped to its slice.

The **hub is itself a vibe project** whose "code" is contracts and the cross-cutting plan
instead of an application. This reuse keeps identities, principles, and proposals entirely
mode-independent — only *where artifacts live* and *the context-sync order* change.

## The mode knob (topology as data)

Mode is opt-in. **Absence of a manifest = single mode**, so existing single-repo projects
need zero configuration (**Minimal Mechanism #6**).

Hub mode is declared by a single manifest in the hub repo, e.g. `vdesign/workspace.md`:

```yaml
mode: hub
hub:    architecture/     # single source of truth
spokes: [firmware/, mobile/, cloud/]
```

Topology is **data fed to generic rules**, never hardcoded into the rules themselves
(**Construct Engine #3**). Component-specific constraints (hardware limits, UI frameworks,
etc.) do **not** belong here — they stay in each spoke's `vdesign/constraints.md` and
`docs/`, exactly as in single mode.

## Artifact placement

| Concept    | Single mode              | Hub mode — global (hub)          | Hub mode — local (spoke)          |
|------------|--------------------------|----------------------------------|-----------------------------------|
| Roadmap    | `vdesign/plan.md`        | hub `plan.md` (cross-stack)      | spoke `vdesign/active_plan.md`    |
| Checkpoint | `vdesign/checkpoint.md`  | hub (cross-cutting sessions)     | spoke (its slice)                 |
| Constraints| `vdesign/constraints.md` | hub (global)                     | spoke (local)                     |
| Stable docs| `docs/`                  | hub `docs/` + **`docs/contracts/`** | spoke `docs/`                  |

**Schemas-first** is simply **One Fact One Place (#1)** + **Auto Propagation (#2)** applied
to interfaces: cross-boundary data structures are defined **once** in the hub's
`docs/contracts/`; spokes consume them and never re-invent them locally.

## Workflow changes

Only the **Context Sync** step becomes scope-aware:

* **Single mode** — read local `vdesign/plan.md` + `checkpoint.md` (unchanged).
* **Hub mode** — read the **hub's global plan + contracts first**, then the **active spoke's**
  local `vdesign/`. Cross-boundary changes originate in the hub; local changes stay in the
  spoke.

Everything else in `vibe.md` (identities, principles, decision-making ladder) is untouched.

## Resolved design question: mode awareness delivery

*Does the agent reliably know which mode and scope it is in?*

**Resolved by [ADR 0001](../docs/adr/0001-mode-specific-rules-via-injection.md):**
mode awareness is delivered as **always-on hook-injected governance**, not left to a
discretionary read. The `SessionStart` hook reads `vdesign/workspace.md` and appends
the matching `modes/*.md` module to the injected spine. Validation should still
confirm this holds up in practice, but the mechanism is decided.

## How to validate

The seam only exists at the boundary between repos, so validation must **cross** it.

**Minimum viable setup:** 1 hub with `docs/contracts/` + a manifest, and **2 spokes that both
depend on one shared contract**. (One spoke, or two unrelated spokes, proves nothing.)

**Run three tasks:**

1. **Contract-origin change** — modify a shared contract in the hub and propagate to both
   spokes. *Tests schemas-first + auto-propagation.*
2. **Purely local change** — a task confined to one spoke. *Tests that the agent stays local
   and does not over-consult the hub (cost).*
3. **Cross-cutting feature** — one feature spanning hub + both spokes. *Tests context-sync
   order and that nothing is duplicated across scopes.*

## Known failure modes to watch during validation

* **Source drift** — the agent edits the shared contract *from within a spoke* locally
  instead of at the hub. (Primary risk; defeats single-source.)
* **Over-consultation** — global context-sync fires for trivial local work; overhead exceeds
  benefit.
* **Stale manifest** — `workspace.md` drifts out of sync with the actual repos.
* **Placement ambiguity** — the agent is unsure whether a new file belongs in the hub or a
  spoke.

## Graduation criteria

Promote out of `proposals/` **into `modes/`** (per [ADR 0001](../docs/adr/0001-mode-specific-rules-via-injection.md);
the operational rules become `modes/hub.md` + `modes/spoke.md`, with a small
mode-agnostic pointer added to `vibe.md`) only after:

* It has been run manually on at least one real multi-repository project.
* The three validation tasks completed with **no duplication of shared contracts** across
  spokes and the agent consistently consulted the hub before writing cross-boundary code.
* The `workspace.md`-driven hook injection reliably makes the agent mode-aware in
  practice (the mechanism is decided in ADR 0001; validation confirms it works).
