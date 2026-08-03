---
name: deslop
description: Use to clean up any code changes of AI artifacts, bad patterns, and poor convention alignment before calling a code change "done."
---
Review these code changes, applying fixes as you go. **Do not** commit the results.

## What to review

Review uncommitted changes. If there are none, diff all changes from the closest upstream branch/revision (usually `main`).

`scripts/changed-files.sh` prints that file list.

## Run first (automated passes)

From the repo being reviewed, run these before any manual cleanup:

1. `scripts/fix-unicode.sh` - rewrites hard-to-type unicode punctuation to ASCII in changed files.
2. `scripts/find-tropes.sh` - reports header comments, stray TODOs, and leftover unicode for judgment calls.
3. `scripts/audit.sh` - runs whichever package security audit the repo supports.

Review the diff these produce, then continue with the manual fixes below.

## What to fix

- Simplify and improve readability
- Reduce duplication
- Extract helper functions in code or tests into reusable utilities
- Review and apply best practices from any AGENTS.md/CLAUDE.md files, stored memory, language-specific skills, repo docs, CONTRIBUTING guidelines, or specifications
- Verify third-party libraries are used idiomatically
- Verify no new third-party libraries are added without clear justification
- Run any package level security audits, e.g. `npm audit` when a package-lock.json is present, and resolve any findings that don't contradict other requirements
- Apply any code convention skills/tools
- Apply any non-destructive suggestions from `ponytail` skills/tools
- Ensure all code is linted and passes required formatting checks
- Ensure tests validate **actual functionality** of this code project, not just validate that dependencies, stdlib or language works as expected
- Ensure any code coverage requirements are met
- Add docstrings where helpful
- Remove common AI tropes, like:
  - "header" comments (e.g. `// ------- utilities ---------`)
  - Unicode characters like arrows or emdashes that can't be easily typed on a standard keyboard
  - Redundant comments that just explain what the code obviously does
  - etc (use your judgment, they're your own tropes after all)
