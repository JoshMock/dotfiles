---
name: github-pr
description: ALWAYS use when authoring a pull request on GitHub.
---

When asked to create a pull request on GitHub, note all of the following instructions:

- If the `gh` CLI tool is available to you, **ALWAYS** use it.
- When writing the PR description, the following rules apply:
  - The first paragraph clearly explains the problem the PR is solving.
  - The second paragraph is a high-level technical explanation of the solution the PR implements.
  - If there are any documentation URLs that help someone deep-dive into the subject matter, include them as relevant.
  - If the PR solves any open issues, include a block that says `Fixes #<issue ID>` for each issue that should be closed. If there are other related PRs or issues, include links to them as needed. Use `gh` to search the repo's issues and PRs (both open and recently closed) to include as much context as possible, but do **NOT** add tangentially-related links just to fulfill the obligation of linking to something. These links should be highly relevant and directly related, or not included at all.
  - **ALWAYS** add an `Assisted-by` footnote to the PR body so it can be persisted into the merge commit message: `Assisted-by: Pi Coding Agent (<model display name>)`
