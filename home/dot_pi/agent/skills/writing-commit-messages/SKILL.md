---
name: writing-commit-messages
description: Use when you are about to write a git commit message, or rewrite one after an amend, squash, split, rebase, reorder, or any other history rewrite that changes what a commit contains.
---

# Writing commit messages

**Subject.** One line, imperative mood, capitalized, no trailing period, ideally under ~50 chars, hard limit ~72. Say
what the commit does ("Retry 429 responses in transport", not "Retried 429s" or "Bug fix"). Use a conventional-commit
prefix only when the repo already uses them, and copy the repo's form, including a scope where it uses one and the
casing after the colon: `feat: add per-host retry budgets`, `fix(transport): retry 429 responses`,
`chore(deps): update actions/checkout to v7`.

**Body.** Optional, and skip it for trivial or self-evident changes. When the change needs context, add a blank line
after the subject, then explain *why* the change is needed and anything non-obvious about *how*, wrapped at ~72 chars.
Do not narrate the diff line by line; the diff already shows what changed.

- Reference issues in the body or footer (`Closes #123`, `Refs #123`).
- One logical change per commit. Do not bundle unrelated edits.
- When several commits will become one PR, write each so the history reads cleanly on its own; do not rely on the PR
  description to make a commit legible.
- Whenever an operation changes what a commit contains - amend, squash, split, rebase, reorder, or any history
  rewrite - rewrite its message to match the new content. Never leave a message describing a state the commit no
  longer reflects.

When working autonomously, prefer small, focused, self-contained commits. An explicit instruction overrides this: if
told to squash, amend, split, or use a specific message or format, do exactly that.
