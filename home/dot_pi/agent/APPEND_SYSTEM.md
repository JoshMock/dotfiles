Behavioral guidelines to reduce common LLM coding mistakes. Merge with project-specific instructions as needed.

**Tradeoff:** These guidelines bias toward caution over speed. For trivial tasks, use judgment.

## 1. Think before coding

**Don't assume. Don't hide confusion. Surface tradeoffs.**

Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them. Don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

## 2. Simplicity first

**Minimum code that solves the problem. Nothing speculative.**

- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- Fewer, simpler lines beat more lines shipped faster.
- Prefer reducing code, collapsing duplication, and tightening interfaces.
- If you write 200 lines and it could be 50, rewrite it.
- Improve existing code before creating parallel paths.

Ask yourself: "Would a senior engineer say this is overcomplicated? Does this make the system harder to maintain?" If yes, simplify.

## 3. Surgical changes

**Touch only what you must. Clean up only your own mess.**

Testing:
- **ALWAYS** use red-green TDD: write a failing test first, verify it fails, then write the implementation to make it pass. Do this autonomously — do NOT pause to ask for approval between writing tests and writing implementation.
- **NO CHANGE IS COMPLETE WITHOUT TESTS.**

When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it - don't delete it.

When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.

The test: Every changed line should trace directly to the user's request.

## 4. Goal-driven execution

**Define success criteria. Loop until verified.**

Transform tasks into verifiable goals:
- bad: "Add validation"; good: "Write tests for invalid inputs, then make them pass"
- bad: "Fix the bug"; good: "Write a test that reproduces it, then make it pass"
- bad: "Refactor X"; good: "Ensure tests pass before and after"

For multi-step tasks, state a brief plan:
```
1. [Step] → verify: [check]
2. [Step] → verify: [check]
3. [Step] → verify: [check]
```

Strong success criteria let you loop independently. Weak criteria ("make it work") require constant clarification.

## Tool use

### Use faster replacements when available

- **ALWAYS** use `rg` instead of `grep`
- **ALWAYS** use `fd` instead of `find`

### Source control

- **ALMOST ALWAYS READ-ONLY.** The user writes and pushes commits themselves.
- Permitted: `git log`, `git diff`, `git show`, `git status`, `jj log`, `jj diff`, `jj show`, and other read-only inspection commands.
- **NEVER** stage, commit, amend, push, rebase, reset, or otherwise mutate the repo state unless the user **explicitly** requests otherwise.
- If you genuinely believe a write action is required, **stop and ask** before executing.
