## Coding practices

### 1. Think before coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them. Don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### 2. Simplicity first

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
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
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

### 4. Goal-driven execution

**Define success criteria. Loop until verified.**

- **ALWAYS** use red-green TDD: write a failing test, verify it fails, **then** write the implementation to make it pass. Do NOT pause to ask for approval between writing tests and implementation.
- **NO CHANGE IS COMPLETE WITHOUT TESTS.**
- **NEVER** edit pre-existing tests without stopping and asking. Treat the existing test suite as a read-only tool to prevent you from introducing regressions.

### 5. Interactive feedback loops

When asked to ask questions, or to otherwise get feedback, one point at a time and wait for responses:

- Ask ONE question, then **STOP**. **Do not proceed** to the next question.
- **NEVER** assume, invent, or narrate a user response. Do not write "user agreed" or fabricate an answer.
- Wait for the user's actual reply before updating any file or moving on.
- A recommendation or default is a suggestion, not consent. Only apply it after the user explicitly confirms.

## Tool use

### Use faster and more accurate commands when available

- **ALWAYS** use `rg` instead of `grep`
- **PREFER** `ast-grep` to `rg` for code search
- **ALWAYS** use `fd` instead of `find`

### Source control

- If `.jj/` exists in the repo root, **only** use `jj` commands; otherwise, use `git`
- **ALMOST ALWAYS READ-ONLY.** Do **NOT** write or push commits.
- Permitted: `git log`, `git diff`, `git show`, `git status`, `jj log`, `jj diff`, `jj show`, and other read-only inspection commands.
- **NEVER** stage, commit, amend, push, rebase, reset, or otherwise mutate the repo state unless the user **explicitly** requests otherwise.
- If you believe a write action is required, **stop and ask** before executing.

### Tool versions

`mise` is often used to install multiple versions of certain tools, like `node`. If a test is failing, or some other problem is occurring, only when using a particular version of a tool, use `mise exec ...` to reproduce. If the needed version of a tool is missing from `mise`, **DO NOT** install yourself; pause and ask me to install it.
