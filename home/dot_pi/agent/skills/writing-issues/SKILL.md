---
name: writing-issues
description: Use when you are about to open an issue for a bug report or a feature request, or write or edit an issue title or body.
---

# Writing issues

**Title.** One line, capitalized, no trailing period, ideally under ~70 chars, specific enough to find in a search.
For a bug, state the observed symptom ("Transport hangs on 429 when the retry budget is exhausted", not "Retry bug").
For a feature, state the capability ("Add per-host retry budgets", not "Improve retries"). Use a conventional-commit
prefix only when the repo already uses them on issues, in the repo's form
(`fix(transport): hang on 429 when the retry budget is exhausted` for a bug,
`feat(transport): add per-host retry budgets` for a feature). Otherwise rely on the repo's labels.

**Body.** Scale it to the issue; a reproducible one-liner needs no structure. Write natural paragraphs without hard
wraps (see the "Markdown style" rules in CLAUDE.md). Default structure:

- **Summary** - the problem or request in a few sentences. Lead with this; it is the only mandatory part.
- **Reproduction** (bugs) - minimal steps, expected versus actual behavior, and the environment: affected version or
  commit, OS, relevant configuration. Put exact error output in a code block, trimmed to the relevant lines.
- **Motivation** (features) - the problem the feature solves or the goal it serves; answers "why is this needed?".
- **Proposal** (features, optional) - the suggested solution or API, plus alternatives you considered when they
  shaped the proposal.
- **Related** - link related issues and PRs with `#123`, or upstream reports by URL.
- **Notes** (optional) - workarounds, severity, regressions, or anything else that affects prioritization.

One problem or request per issue; if the body needs an "and also", file a second issue and link the two. Report what
you observed, and mark guesses about the cause as guesses. Opening or commenting on an issue is an outward-facing
action, so confirm first per "Workflow: public-facing and irreversible actions" in CLAUDE.md.
