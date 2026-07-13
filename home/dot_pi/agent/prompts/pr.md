---
description: Review PRs from URLs with structured issue and code analysis
argument-hint: "<PR-URL>"
---
You are given one or more GitHub PR URLs: $@

For each PR URL, do the following in order:
1. Read the PR page in full. Include description, all comments, all commits, and all changed files.
2. Identify any linked issues referenced in the PR body, comments, commit messages, or cross links. Read each issue in full, including all comments.
3. Analyze the PR diff. Read all relevant code files in full with no truncation and compare against the diff. Do not fetch PR file blobs unless a file is missing on main or the diff context is insufficient. Include related code paths that are not in the diff but are required to validate behavior.
4. Check if documentation or release notes require modification. This is often the case when existing features have been changed, or new features have been added.
5. Provide a structured review with these sections:
   - What it does: one short paragraph describing the change and its intent.
   - Good: solid choices or improvements.
   - Bad: concrete issues, regressions, missing tests, or risks.
   - Ugly: subtle or high impact problems.
   - Tests: what is covered, what is missing, and whether existing tests are adequate.
   - Open questions for you: only things blocking a merge decision that need the user's input. Omit the section entirely if there are none.

Format of the expected response per PR:
PR: <url>
What it does:
- ...
Good:
- ...
Bad:
- ...
Ugly:
- ...
Tests:
- ...
Open questions for you:
- ...

If no issues are found, say so under Bad and Ugly.
