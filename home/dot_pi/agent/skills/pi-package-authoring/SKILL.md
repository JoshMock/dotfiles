---
name: pi-package-authoring
description: Pi packages — npm/git distribution of extensions, skills, prompts, themes via keywords pi-package and package.json pi manifest; pi install paths and security expectations. Use when shipping or consuming pi-package, adding pi.skills entries, or explaining install vs project-local -l. Use for "publish pi skills on npm", "pi install", "pi-package.json", even without naming this skill.
compatibility: npm-compatible toolchain; read access to pi-mono docs and consumer package.json when validating pi-package manifests.
---

# Pi package authoring

## Grounding

1. `pi-mono/packages/coding-agent/docs/packages.md` — manifest, install commands, layout.
2. `pi-mono/packages/coding-agent/README.md` — Pi Packages section (`pi install`, `package.json` `pi` key, keywords).
3. `pi-mono/packages/coding-agent/src/core/package-manager.ts` — `resourcePrecedenceRank` (package-origin resources sort after user/project).

## Invariants

- Packages integrate through the same resource resolution pipeline as local dirs; **package-origin** metadata ranks after user/project auto paths — see `resourcePrecedenceRank` in `pi-mono/packages/coding-agent/src/core/package-manager.ts`.
- Third-party packages execute code; skills can instruct arbitrary actions — security notes are first-party in `docs/packages.md` and coding-agent README.

## Workflows

- **Define a package**: Mirror the `package.json` example from `docs/packages.md` / README; verify conventional dirs (`skills/`, `extensions/`, etc.) against those docs.
- **Predict overrides**: Combine package-manager precedence with `loadSkills` “first name wins” (`pi-mono/packages/coding-agent/src/core/skills.ts`).

## Anti-patterns

- Do not invent CLI flags not documented in `docs/packages.md` / README.
