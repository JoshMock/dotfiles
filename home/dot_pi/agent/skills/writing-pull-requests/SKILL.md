---
name: writing-pull-requests
description: Use when you are about to open a pull request, write or update its title or description, open it as a draft, or bring the description of an open PR back in sync with the change.
---

# Writing pull requests

**Title.** One line, imperative mood, capitalized, no trailing period, ideally under ~70 chars. State the change, not
the activity ("Fix transport retry on 429", not "Fixes for retry"). Use a conventional-commit prefix (`feat:`, `fix:`,
`docs:`, `refactor:`, `test:`, `chore:`) only when the repo already uses them, and copy the repo's form, including a
scope where it uses one and the casing after the colon: `feat(transport): add per-host retry budgets`,
`docs(knowledgebase): add the telemetry flow`, `fix: retry 429 responses in transport`.

**Description.** Scale it to the change; do not pad a small PR. Write natural paragraphs without hard wraps (see the
"Markdown style" rules in CLAUDE.md). Default structure:

- **Summary** - what the PR does. Lead with this; together with Intention it is the only mandatory part.
- **Intention** - why the change is needed: the problem it solves, the motivation, or the goal it serves. Answers
  "why is this needed?" rather than restating what changed. Omit it for bugfixes where the why is self-evident.
- **Changes** - a short bullet list of the notable changes, for anything beyond a trivial diff, always collapsed (see
  "Collapsed lists" below). Skip for one-liners.
- **Related** - link issues with `Closes #123` / `Fixes #123`, or reference related PRs. Collapse the list when it
  runs long.
- **Notes** (optional) - breaking changes, follow-ups, risks, or anything a reviewer must know before approving. Open
  with an alert where one is warranted (see "Alerts" below), and collapse the rest when it runs long.

**Collapsed lists.** Keep the section heading and put the list under it in a `<details>` block whose `<summary>` says
what opens: `Expand to see the list of changes`, `Expand to see the related issues and pull requests`, or
`Expand to see the notes`. Summary, Intention and any alert stay above the fold, and the lists open on demand.
Changes is always collapsed. Related and Notes are collapsed when the list runs long, measured in characters rather
than in bullets, with about 500 characters as the yardstick: three one-line bullets stay open, one bullet of five
sentences does not. Leave a blank line after the `<summary>` line and one before `</details>`, or GitHub renders the
Markdown inside as plain text. When Notes opens with an alert, the alert stays outside the block and only the
remaining notes go inside, and the block starts with a `###` heading of your choice (`### Further notes`) rather
than with the first bullet.

**Alerts.** GitHub renders a blockquote that opens with `> [!IMPORTANT]`, `> [!WARNING]`, or `> [!CAUTION]` as a
colored callout ([syntax](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#alerts)).
Use one where a reviewer or merger must not miss something: a breaking change or a merge-order constraint as
IMPORTANT, a step that can damage an environment as WARNING or CAUTION. Only these three earn the attention a
callout demands, so leave NOTE and TIP out, and an ordinary remark stays a Notes bullet. The text sits on `> ` lines
under the marker, one alert type per block, never inside another blockquote, and at most two or three per
description. An alert sits at the top of its section, right under the heading and before any list, and never
between or inside regular list items. The same syntax works in issues, comments, and reviews.

When working autonomously, keep PRs focused: one logical change per PR, and if the description needs an "and also",
consider splitting. Open as a draft when the work is incomplete or you want early feedback. An explicit instruction
overrides this: if told to combine changes, structure the PR a certain way, or open it ready for review, do exactly
that.

When iterating on an open PR, keep the description in sync with the current state of the change; a stale description
is worse than none. Editing a PR description is itself an outward-facing action, so confirm first per "Workflow:
public-facing and irreversible actions" in CLAUDE.md.
