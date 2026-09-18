---
description: Review a PR given a URL, using structured issue and code analysis
argument-hint: "<PR-URL>"
---
You are given one or more GitHub PR URLs: $@

For each PR URL, do the following in order:
1. Read the PR page in full. Include description, all comments, all commits, and all changed files.
2. Identify any linked issues referenced in the PR body, comments, commit messages, or cross links. Read each issue in full, including all comments.
3. Analyze the PR diff. Read all relevant code files in full with no truncation and compare against the diff. Do not fetch PR file blobs unless a file is missing on main or the diff context is insufficient. Include related code paths that are not in the diff but are required to validate behavior.
4. Check if documentation or release notes require modification. This is often the case when existing features have been changed, or new features have been added.
5. Check that tests are added/updated appropriately.
6. Provide a structured review with these sections:
   - `goal`: short paragraph describing the stated or implied intent of PR
   - `how`: 1-2 sentences describing how `goal` is accomplished by this change
   - `success`: 1-2 sentence evaluation of how well `how` accomplishes `goal`
   - `details`: bulleted list describing each atomic change and what it does in 1 sentence
   - `concerns.{major,minor,nit}`: nested bulleted lists of any concerns worth highlighting that likely need addressing
   - `unrelated`: any changes made that are unrelated to `goal`
   - `notes`: any other important context not covered by any of the above
