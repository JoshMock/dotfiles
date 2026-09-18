---
description: Fix the described bug, or a Github issue describing an issue, analyze the
---

Use the `gh` tool to look at the following issue. Analyze the problem, then look at the code in this repo and try to identify the issue and solve it. If the problem or its solution are unclear, explain your findings and propose possible paths forward.

## For bugs
- Ignore any root cause analysis in the issue (likely wrong)
- Read all related code files in full (no truncation)
- Trace the code path and identify the actual root cause
- Apply a fix, or explain why no fix is justifiable

## For feature requests
- Do not trust implementation proposals in the issue without verification
- Read all related code files in full (no truncation)
- Apply the most concise implementation approach

## Source control
For each atomic fix applied, create a new revision. **ALWAYS** use `jj` instead of `git` if the repo has a `.jj` directory at the repo root.

## The Issue

$@
