---
description: Review code changes, apply fixes, and summarize
---
Review these code changes, applying fixes as you go. **Do not** commit the results.

Load the `code-conventions` skill and follow it throughout.

$@

## What to review

Review uncommitted changes. If there are none, diff all commits from the closest upstream branch/revision.

## Requirements check

- If a spec exists (e.g. `specs/` directory), verify the implementation satisfies it and update long-living spec contracts to reflect any implementation changes
- If changes reference GitHub issues, use `gh` or a web skill to understand what the changes address
- Otherwise, infer intent from the code and comments

## Cleanup pass

After verifying requirements, take another pass:

- Simplify and improve readability
- Reduce duplication
- Extract test helpers into generic, reusable utilities
- Apply best practices from AGENTS files, stored memories, and language-specific skills
- Verify third-party libraries are used idiomatically
- Apply `code-conventions` rules (comments, style, LLM artifacts, test organization)

When finished, show a concise bulleted list of changes made and why.
