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
7. Ask me which concerns to post as review comments on the PR. Propose a default selection (for example, all `major` concerns). Then **STOP** and wait for my reply. Do not create any review or comment until I explicitly approve a selection.
8. After I approve, create ONE **pending** (draft) review with one inline comment per approved concern:
   - Anchor each comment on the most relevant line or line range of the PR head (`line`/`side: RIGHT`, plus `start_line`/`start_side` for ranges). Compute line numbers from the head version of the file.
   - Make each comment self-contained. State the problem, its impact, and a concrete fix.
   - End each comment body with `\n\n<sub>authored by Pi Coding Agent (<model name>)</sub>`.
   - Write the payload to a temp JSON file as `{"body": "", "comments": [...]}` and run `gh api -X POST repos/<owner>/<repo>/pulls/<n>/reviews --input <file>`.
   - **NEVER** include an `event` field, and **NEVER** call the submit-review endpoint (`.../reviews/<id>/events`). Without `event`, GitHub keeps the review `PENDING`. Only I submit it.
   - If I already have a pending review on the PR, stop and tell me. GitHub allows only one pending review per user.
   - Confirm the returned `state` is `PENDING`. Report the review URL and a table of the comments (concern → file:lines).

## HARD REQUIREMENTS before authoring a structured review or submitting any code review comments to GitHub

1. **Prove every behavior claim.** Each concern must cite either code that was actually read (file:line range, not `grep` hits) or a command that was run. Otherwise, label it unverified and leave it out of the default selection.
2. **Trace the full path for claims about output or errors.** For "X outputs Y" claims, follow the call to where the output is actually written.
3. **Disprove systemic claims before stating them.** If a concern says existing code has the same problem, the agent must first search existing tests for a counterexample (e.g. `rg "input_validation_failed" test/`).
4. **Ban grep-and-slice for core files.** Stop using `grep | head` and `sed -n` slices as a substitute for "read in full" on core files. If a file is too large to read whole, the agent must say "partial read" next to each concern that depends on it.
5. **Reproduce cheap claims.** When a check takes under a minute, run it before staging the comment.
