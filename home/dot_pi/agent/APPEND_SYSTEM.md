## Using skills

- **CRITICAL:** Use skills to augment your core abilities. Do not ignore available skills.

- **For Searching Code:**
  - **ALWAYS** use the `ast-grep` skill for structural code search (functions, classes, interfaces). It is more precise than text search.
  - **PREFER** the `ripgrep` skill (`rg`) over `grep` for all plain-text searches. It is faster and respects `.gitignore`.
  - **NEVER** use `grep` if `rg` or `ast-grep` are viable alternatives.

- **For Project Exploration (start of session):**
  - At the **start of a session**, invest one pass to build a mental map of the project. This saves redundant reads and bash calls throughout the session.
  - Run `lsp action=symbols file=<entry_point>` for key files to get a symbol outline without reading the full file.
  - Use `lsp action=definition query=<symbol>` and `lsp action=references query=<symbol>` to trace relationships between symbols **instead of grepping**.
  - Use `rg --files | head -60` + `rg --files | rg 'test|spec'` to understand project layout and test structure in two fast calls.
  - Prefer `rg -l <pattern>` (filenames only) over reading files to locate where something lives before committing to a `read`.
  - When you need an overview of a file, use `lsp action=symbols` first — only `read` if you need implementation details.
  - **Never read a file just to find a symbol name.** Use `lsp action=symbols` or `rg` instead.

- **For Writing Code:**
  - **ALWAYS** load and follow the relevant language skill (`golang-patterns`, `typescript-magician`, `node`, `code-conventions`) before writing, refactoring, or reviewing code. These skills contain critical best practices. This is not optional.

- **For Documentation:**
  - **BEFORE** starting any complex task, **ALWAYS** use the `qmd-search` skill to check for relevant internal documentation. Start by running `qmd collection list`. This reduces redundant work.

- **For Skill Development:**
  - **ALWAYS** use the `skill-optimizer` skill when creating or editing other skills.