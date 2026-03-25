---
name: skill-authoring
description: Create and maintain Agent Skills that follow the agentskills.io specification and local conventions. Use when you need to add or update skills under ~/.pi/skills.
---

# Skill Authoring Guide

Use this skill when you need to **create or update skills** in `~/.pi/skills`. It captures the Agent Skills format plus local conventions learned in this environment.

## Safety Rules (Do Not Violate)

- **Do not modify** user data outside `~/.pi/skills` unless explicitly instructed.
- Prefer **read-only inspection** before editing any existing skill files.
- Any reusable scripts must go in the skill's `scripts/` directory (do not embed large reusable snippets in `SKILL.md`).
- If the task requires new automation, add it under `scripts/` in the skill directory.

## Required Structure

A skill directory must include at least:

```
<skill-name>/
└── SKILL.md
```

### SKILL.md frontmatter (required)

```
---
name: <skill-name>
description: <what it does and when to use it>
---
```

Constraints (from spec):
- `name` is 1–64 chars, lowercase letters/numbers/hyphens only.
- No leading/trailing hyphen, no consecutive `--`.
- Must match the **parent directory name** exactly.
- `description` is 1–1024 chars and should include when to use the skill.

Optional fields:
- `license`, `compatibility`, `metadata`, `allowed-tools`.

## Recommended Body Sections

- **Safety Rules** (explicit allowed/forbidden actions).
- **What to Produce** (expected output format and decision rules).
- **Suggested Workflow** (step-by-step).
- **Notes** (edge cases, cautions).

## Local Conventions Learned Here

- Use `scripts/` for reusable code instead of embedding large snippets in `SKILL.md`.
- Include **explicit pre-commands** when required (e.g., a sync command that must run before analysis).
- Keep instructions concise and unambiguous.
- Deduplicate outputs when threads or repeated items are expected.

## Optional Directories

- `scripts/` — executable helpers (Python/Bash/JS). Document usage in `SKILL.md`.
- `references/` — additional docs for progressive disclosure.
- `assets/` — templates, static data, diagrams.

## Workflow Checklist

1. Create `~/.pi/skills/<skill-name>/`.
2. Add `SKILL.md` with valid frontmatter.
3. Write clear rules for when and how the skill is used.
4. Add helpers under `scripts/` if needed, and reference them with relative paths.
5. Keep `SKILL.md` under 500 lines and move extra details into `references/` if needed.
6. Validate naming constraints and ensure the directory name matches `name`.

## Example Skeleton

```
---
name: example-skill
description: Explain when to use this skill and what it accomplishes.
---

# Example Skill

## Safety Rules (Do Not Violate)
- ...

## What to Produce
- ...

## Suggested Workflow
1. ...
```

## References

- Agent Skills specification: /home/joshmock/Downloads/specification.md
