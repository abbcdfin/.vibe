---
name: init
description: Initialize a vibe project with planning files and design document stubs. Use for project setup or scaffolding. Supports single (default), hub and spoke; hub/spoke are experimental.
---

# Vibe Project Initializer

Modes:

- `single` (default)
- `hub` (experimental)
- `spoke` (experimental)

Read the requested mode from the invocation text, not a positional `$1` argument.

Read and follow the matching mode in `reference.md` alongside this file. Tell the
user that hub/spoke mode is experimental before scaffolding it.
