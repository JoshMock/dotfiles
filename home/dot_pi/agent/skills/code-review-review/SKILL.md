---
name: code-review-review
description: Use whenever you have been asked to read and respond to code review comments on a pull request.
---

## Prerequisites

This skill drives the GitHub CLI. Before starting, confirm both:

- `gh` is installed and runnable (`gh --version`).
- `gh` has an active authenticated session (`gh auth status`; exits non-zero if
  not logged in).

If either check fails, stop and ask the user to install `gh` or run `gh auth
login`. Do not attempt to work around a missing or unauthenticated `gh`.

## 1. Check out the exact revision under review first

Validating a comment against the wrong code wastes effort and produces wrong
conclusions. Before reading any comment:

1. Identify the PR's head branch and verify it exists locally and is current:
   ```bash
   gh pr view <N> --json number,headRefName,headRefOid,url
   git fetch origin <headRefName>
   git checkout <headRefName> && git pull --ff-only   # git repos
   ```
2. In a `jj` repo (a `.jj/` dir exists), **do not run `git` mutating commands**.
   Fetch and point the working copy at the PR head instead:
   ```bash
   jj git fetch
   jj new <bookmark-or-change-id>
   ```
3. Confirm the checked-out commit matches the PR head SHA (`headRefOid`). If it
   does not, stop and reconcile before continuing.

## 2. Fetch ONLY unresolved comments

Resolved threads are already handled. Acting on them creates noise and
re-litigates settled decisions. The REST comments endpoint does **not** expose
resolution state, so you must use the GraphQL `reviewThreads` API and filter on
`isResolved == false`:

```bash
gh api graphql -f query='
{
  repository(owner:"<OWNER>", name:"<REPO>") {
    pullRequest(number:<N>) {
      reviewThreads(first:100) {
        nodes {
          isResolved
          isOutdated
          comments(first:20) {
            nodes { author { login } path line body }
          }
        }
      }
    }
  }
}' --jq '.data.repository.pullRequest.reviewThreads.nodes[]
          | select(.isResolved == false)
          | {author: .comments.nodes[0].author.login,
             path: .comments.nodes[0].path,
             line: .comments.nodes[0].line,
             body: .comments.nodes[0].body}'
```

Notes:
- `gh pr view --json comments` and `gh api repos/.../pulls/<N>/comments` return
  **all** review comments with no resolution field. Do not use them to decide
  what to act on.
- If the user names a specific reviewer (e.g. "only Copilot"), filter further on
  `author.login`. Copilot's login is `copilot-pull-request-reviewer`; most bots
  have distinct logins (`github-actions`, etc.). Confirm the login rather than
  matching on display name.
- Use `--paginate` / `github.paginate` equivalents if a PR has more than 100
  threads (bump `first:` or page the cursor).

## 3. Validate each claim against the current code

Do not trust a comment's analysis or proposed fix. Many are wrong, outdated, or
based on a misreading. For each unresolved comment:

1. Read it in full, plus any linked materials.
2. Open the cited file **at the revision you checked out** and read enough
   surrounding code to understand actual behavior. Line numbers in old comments
   drift; locate the real code by content, and treat `isOutdated: true` threads
   with extra suspicion.
3. Derive your own conclusion from the code. State explicitly whether the claim
   holds. Common reasons a claim is wrong:
   - The design already handles the concern a different way (e.g. a same-runner
     A/B comparison cancels out hardware variance the comment worries about).
   - The code path the comment describes does not exist or is unreachable.
   - The comment assumes a tool/version/permission that the code already sets.
4. If unsure, run the smallest check that settles it (read the referenced
   function, grep for the symbol, check a tool's version/flags, trace the data
   flow) rather than guessing.

Before fixing comments one by one, look at them together: if several point at the
same area, decide whether the design itself is wrong and say so instead of
patching each symptom.

## 4. Make changes, one standalone revision per fix

- If a change is needed, perform it in its own git/jj revision. The revision
  description should succinctly describe the change and must **not** link to the
  review comment or PR.
- Keep each fix isolated so it can be reviewed independently.
- Reject-with-reason is a valid outcome: if the claim does not hold, make no
  change and record why.

## 5. Report

When every unresolved comment is resolved or rejected, list each one and how you
responded (fixed in revision X / rejected because Y). Do not push to a remote.
