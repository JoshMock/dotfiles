## Coding practices

### 1. Think before coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State any consequential assumptions explicitly.
- If multiple interpretations exist, present them. Don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, raise it.

### 2. Simplicity first

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- Fewer, simpler lines beat more lines shipped faster.
- Prefer reducing code, collapsing duplication, and tightening interfaces.
- If you write 200 lines and it could be 50, rewrite it.
- Improve existing code before creating parallel paths.

Ask yourself: "Would a senior engineer say this is overcomplicated? Does this make the system harder to maintain?" If yes, simplify. If a `ponytail` rule is relevant, apply it.

### 3. Surgical changes

**Touch only what you must. Clean up only your own mess.**

When editing existing code:
- Don't improve adjacent code, comments, or formatting.
- Only refactor things that are related to your change, and prefer simplification in those refactors.
- Match existing style, even if you'd do it differently.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Only remove dead code related to your change. Present the option to delete more when found.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-driven execution

**Define success criteria. Loop until verified.**

- **ALWAYS** use red-green TDD for behavior changes and bug fixes: write a failing test, verify it fails, **then** write the implementation to make it pass. Do NOT pause to ask for approval between writing tests and implementation. **NO BEHAVIOR CHANGE OR FIX IS COMPLETE WITHOUT TESTS.**
- Use appropriate verification for changes that are not behavior changes or bug fixes.
- If you edit the logic of pre-existing tests, list each such change explicitly with a brief justification. The existing test suite is a tool to prevent you from introducing regressions, so changing tests is a yellow flag that you are cheating or cutting corners, which is explicitly forbidden.

### 5. Interactive feedback loops

When asked to ask questions, or to otherwise get feedback, go one point at a time and wait for responses:

- Ask ONE question, then **STOP**. **Do not proceed** to the next question.
- **NEVER** assume, invent, or narrate a user response. Do not write "user agreed" or fabricate an answer.
- Wait for the user's actual reply before updating state or moving on.
- Your recommendation or default answer is a suggestion, **not consent**. Only apply it if the user explicitly confirms.

## Tool use

### Source control

- **USE ATOMIC COMMITS.** One commit per standalone change you make, so that each can be reviewed in isolation.
- **NEVER** push commits to a remote unless otherwise instructed.
- **ALWAYS** add `Assisted-by: <name>` trailers to all commit messages, where `name` is `Pi Coding Agent (<model name>)`, e.g. `Pi Coding Agent (Claude Sonnet 4.8)`
- If `.jj/` exists in the repo root, **DO NOT USE ANY `git` COMMANDS IN THIS REPO** and follow the "Jujutsu" section below. if you are on a detached `HEAD`, you are probably in a `jj`-managed repo; verify by looking for a `.jj/` directory.

#### Jujutsu (`jj`) ONLY

The following rules apply to any Jujutsu-managed repository.

- **ONLY** use `jj` commands in a Jujutsu repo, **NEVER** `git` commands.
- Before any history-rewriting `jj` command (`squash`, `rebase`, `abandon`, `op restore`), run `jj log` first and name the exact target revision. Do not run these reflexively.
- `jj` is **not** `git`. Edits are applied by amending the CURRENT revision by default, which is done by just editing files (the working copy IS a revision) and then run any `jj` command to amend the revision. Set its commit message with `jj describe -m "..."`.
- **ALWAYS** pass `-m`/`--message` to `jj describe`, `jj commit`, and `jj squash`. Never let a `jj` command open `$EDITOR` (it can hang or fail under a sandbox).
- **NEVER** use bare `jj squash` to "save" or "amend." With no `--into`/`--from` it moves the working-copy changes DOWN into the parent revision and merges the two. Only use `jj squash` when the deliberate goal is folding one revision into another.
- **ALWAYS** start a new revision before making edits if there is work you did not author in the current revision. Mention whatever such action you took when completing your turn.

#### `gh` CLI tool

Take maximum advantage of the `gh` CLI tool when it is available to you. For example, if a github.com URL is provided, **ALWAYS** attempt to use `gh` to read the contents of that URL before falling back to other URL-reading strategies.

If `gh` is being used to interact with or create a PR or issue, **ALWAYS** append a footnote in small text to the description or comment that says `---\n\nauthored by Pi Coding Agent (<model name>)`.

### Tool versions

`mise` is often used to install multiple versions of certain tools, like `node`. If a test is failing, or some other problem is occurring, only when using a particular version of a tool, use `mise exec ...` to reproduce. If the needed version of a tool is missing from `mise`, **DO NOT** install yourself; pause and ask me to install it.

## Wiki

If it exists, **always** use the `wiki` skill for looking up and remembering facts that should be remembered across multiple sessions.
