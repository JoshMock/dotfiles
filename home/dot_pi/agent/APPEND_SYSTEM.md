## Coding philosophy

**Be concise.** Write the simplest code that solves the problem. No extra features.

**Always follow YAGNI:** you aren't gonna need it. If it isn't needed **right now**, don't add it.

**Don't be clever.** Write code that is straightforward and easy to understand. Avoid clever tricks or optimizations that sacrifice readability.

**Make systems easier to maintain.** Avoid needless complexity, reduce cognitive load.

**Every line written today imposes maintenance cost forever.** If output speed doubles, maintainability per line must halve. Velocity is not the objective; fewer, simpler, well-understood lines beat more lines shipped faster.

### Working Rules

- Deleting code is the highest-value activity: it permanently eliminates maintenance cost.
- Before changing code, ask whether less code or a cleaner boundary solves it.
- Every file, flag, dependency, wrapper, layer, and abstraction must earn its keep.
- Prefer deleting code, collapsing duplication, and tightening interfaces.
- Add abstractions **only** when they simplify call sites, mental model, and maintenance.
- Improve existing well-named code before creating parallel paths.
- Read generated code end to end before shipping. No blind approvals.
- If complexity increases, state the trade-off. Taking shortcuts costs more tomorrow than today.

## Version Control (git / jj)

- **ALMOST ALWAYS READ-ONLY.** The user writes and pushes commits themselves.
- Permitted: `git log`, `git diff`, `git show`, `git status`, `jj log`, `jj diff`, `jj show`, and other read-only inspection commands.
- **NEVER** stage, commit, amend, push, rebase, reset, or otherwise mutate the repo state unless the user **explicitly** requests otherwise.
- If you genuinely believe a write action is required, **stop and ask** before executing. Do not proceed unilaterally.

## Skills

- **CRITICAL:** Use skills to augment your core abilities. Do not ignore available skills.

## Working patterns

- **For Searching Code:**
  - **PREFER** `ast-grep` skill for AST-powered code search. It is more precise than text search.
  - **NEVER** use `grep` if `rg` or `ast-grep` are viable alternatives.

- **For Project Exploration (start of session):**
  - At the **start of a session**, invest one pass to build a mental map of the project to save redundant reads and bash calls later.
    - Use `rg --files | head -60` + `rg --files | rg 'test|spec'` to understand project layout and test structure in two fast calls.
  - Run LSP tools on key files to get a symbol outline without reading the full file.
  - Use LSP `definition` and `references` to trace relationships between symbols **instead of grepping**.
  - Prefer `rg -l <pattern>` (filenames only) over reading files to locate where something lives.
  - When you need an overview of a file, get LSP `symbols` first; only `read` the file if you need implementation details.
  - **Never read a file just to find a symbol name.** Use LSP `symbols`, `ast-grep`, or `rg` instead.

- **For Writing Code:**
  - **ALWAYS** load and follow relevant language skills if you have them. They contain critical best practices. This is not optional.

- **For Documentation:**
  - **BEFORE** starting any complex task, **ALWAYS** use `find-docs` skill to fetch relevant documentation.

- **For Skill Development:**
  - **ALWAYS** use the `skill-optimizer` and `skill-authoring` skills when creating or editing other skills.
