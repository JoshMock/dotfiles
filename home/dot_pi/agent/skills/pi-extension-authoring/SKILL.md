---
name: pi-extension-authoring
description: Authoring Pi TypeScript extensions — ExtensionAPI, custom tools, commands, UI hooks, resources_discover, `registerProvider()`, and how extendResources merges skill paths after base reload. Use when the user builds or debugs pi extensions, registers tools, adds /commands, hooks events, integrates TUI components, or ships extension examples. Use for "how do I extend pi", "extension API", "registerTool", "registerProvider", even if pi-mono is not mentioned.
compatibility: TypeScript/Node extension host; read pi-mono/packages/coding-agent for ExtensionAPI and loader behavior cited in this skill.
---

# Pi extension authoring

Ground every answer in `pi-mono/` files below.

## Grounding

1. `pi-mono/packages/coding-agent/docs/extensions.md` — capabilities, lifecycle, patterns.
2. `pi-mono/packages/coding-agent/examples/extensions/README.md` — runnable examples index.
3. `pi-mono/packages/coding-agent/src/core/resource-loader.ts` — `extendResources()` appends paths via `mergePaths` after existing `lastSkillPaths` (late paths lose name collisions to earlier ones unless names differ).
4. `pi-mono/packages/coding-agent/src/core/agent-session.ts` — extension commands vs queued prompts; skill expansion hooks.
5. `pi-mono/packages/coding-agent/docs/tui.md` — extension TUI component integration with `@mariozechner/pi-tui`: `Component` rendering contract, overlay patterns, input handling in extension context.
6. `pi-mono/packages/coding-agent/docs/custom-provider.md` — `registerProvider()` for proxies, OAuth/SSO, custom APIs, and custom model definitions.

## Invariants

- Extensions can register tools, commands, themes, prompts, and extra skill paths; exact API surface is defined in docs and example modules — start from `docs/extensions.md`, not memory.
- Dynamic resource discovery patterns live under `pi-mono/packages/coding-agent/examples/extensions/` (e.g. `dynamic-resources/` listing in examples README).

## Workflows

- **New extension**: Read `docs/extensions.md`, clone the closest `examples/extensions/` template, then align with project `AGENTS.md` if working inside `pi-mono`.
- **Skills from extensions**: Trace `extendResources` + `mergePaths` in `resource-loader.ts` to explain ordering with user/project/package skills.
- **Extension TUI**: Read `docs/tui.md` for the `Component` rendering contract in extension context; combine with `pi-tui` skill for library-level APIs.
- **Custom providers via extension**: See `pi-mono/packages/coding-agent/docs/custom-provider.md` for `registerProvider()` OAuth flows and proxy patterns (grounded in `pi-cli-workspace`).

## Anti-patterns

- Do not assert MCP support in core; optional via extension (see coding-agent README philosophy).
