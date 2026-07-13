---
description: De-slop recent code changes
---
Review these code changes, applying fixes as you go. **Do not** commit the results.

Load the `code-conventions` skill and follow it throughout.

## What to review

Review uncommitted changes. If there are none, diff all commits from the closest upstream branch/revision. If `.jj` is in the repo root, use `jj` instead of `git` for looking at revision history.

## Requirements check

An issue, PR or reference to a specification plan may be included below. If so, verify the implementation satisfies the need described there. If any changes reference GitHub issues (e.g. `#123`) or a public URL, follow the references using `gh` or a skill to understand what the changes address. If no references are given or found, infer intent from the code, comments, and commit messages.

## Cleanup pass

After verifying requirements are met, take another pass:

- Simplify and improve readability
- Reduce duplication
- Extract helper functions in code or tests into reusable utilities
- Apply best practices from any AGENTS.md/CLAUDE.md files, stored memory, language-specific skills, and repo docs addressing contributors
- Verify third-party libraries are used idiomatically
- Apply `code-conventions` rules (comments, style, LLM artifacts, test organization)

When finished, show a concise bulleted list of changes made and why.

## Other notes

$@
