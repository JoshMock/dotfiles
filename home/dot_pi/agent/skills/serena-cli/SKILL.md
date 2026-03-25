---
name: serena-cli
description: Use when navigating or editing code symbols, searching the codebase, reading or writing project memories, or activating a Serena project. Also use when the user asks how to invoke Serena tools from the shell or in a script.
---

# Serena CLI

`~/.local/bin/serena` is a compiled binary wrapping all Serena MCP tools as subcommands. It is the **only** way to invoke Serena tools — the MCP server is not registered in `~/.pi/agent/mcp.json`.

## Important: Stateless Invocations

Each `serena` call spawns a **fresh server process** — no state persists between calls. Tools that require an active project (file/symbol operations) will error without one. Since only one tool can be called per invocation, this means:

- Tools that **do not** require an active project work standalone: `list-memories`, `read-memory`, `get-current-config`, `activate-project`
- **`write-memory` requires an active project** even with the `global/` prefix. If no project is active, write the memory file directly to `~/.serena/memories/global/<name>.md` using the `write` tool as a fallback.
- Tools that **do** require an active project (`list-dir`, `find-file`, `find-symbol`, `get-symbols-overview`, etc.) will return an error unless run after the serena config already has a project activated from a prior session — or unless you use the `bash` tool to call them in a shell script that chains activations some other way

In practice, the most reliable workflow is to call `activate-project` once per session (its effect persists in serena's on-disk config), then call other tools freely.

## Usage

```
serena <subcommand> [flags]
serena --help
serena <subcommand> --help
```

Global flags:
- `-t, --timeout <ms>` — call timeout (default: 30000)
- `-o, --output <format>` — `text` | `markdown` | `json` | `raw` (default: `text`)

## Available Tools (26)

### Project & Config
| Subcommand | Required flags | Description |
|---|---|---|
| `activate-project` | `--project <name\|path>` | activate a project by name or path |
| `get-current-config` | — | show active project, tools, modes |
| `switch-modes` | `--modes <m1,m2>` | set active modes (e.g. `editing,interactive`) |
| `check-onboarding-performed` | — | check if onboarding is done for active project |
| `onboarding` | — | get onboarding instructions |
| `initial-instructions` | — | get the Serena instructions manual |
| `prepare-for-new-conversation` | — | prep state for a new conversation |
| `open-dashboard` | — | open the Serena web dashboard |

### File System
| Subcommand | Required flags | Description |
|---|---|---|
| `list-dir` | `--relative-path <path> --recursive <true\|false>` | list directory contents |
| `find-file` | `--file-mask <glob> --relative-path <path>` | find files matching a glob |
| `create-text-file` | `--relative-path <path> --content <text>` | write or overwrite a file |
| `search-for-pattern` | `--substring-pattern <regex>` | regex search across codebase |

### Symbol Navigation
| Subcommand | Required flags | Description |
|---|---|---|
| `get-symbols-overview` | `--relative-path <file>` | high-level symbol summary of a file |
| `find-symbol` | `--name-path-pattern <pattern>` | find symbols by name/path pattern |
| `find-referencing-symbols` | `--name-path <path> --relative-path <file>` | find all references to a symbol |

### Symbol Editing
| Subcommand | Required flags | Description |
|---|---|---|
| `replace-symbol-body` | `--name-path <path> --relative-path <file> --body <code>` | replace a symbol's full body |
| `insert-after-symbol` | `--name-path <path> --relative-path <file> --body <code>` | insert code after a symbol |
| `insert-before-symbol` | `--name-path <path> --relative-path <file> --body <code>` | insert code before a symbol |
| `rename-symbol` | `--name-path <path> --relative-path <file> --new-name <name>` | rename a symbol codebase-wide |
| `safe-delete-symbol` | `--name-path-pattern <pattern> --relative-path <file>` | delete if no references exist |

### Memory
| Subcommand | Required flags | Description |
|---|---|---|
| `list-memories` | — | list all memories (optional: `--topic`) |
| `read-memory` | `--memory-name <name>` | read a memory by name |
| `write-memory` | `--memory-name <name> --content <text>` | write or update a memory |
| `edit-memory` | `--memory-name <name> --needle <str> --repl <str> --mode <literal\|regex>` | find-replace in a memory |
| `rename-memory` | `--old-name <name> --new-name <name>` | rename or move a memory |
| `delete-memory` | `--memory-name <name>` | delete a memory |

## Examples

```bash
# activate a project (persists in serena's config for subsequent calls)
serena activate-project --project the-agency

# list top-level directory contents
serena list-dir --relative-path . --recursive false

# search for a pattern across the codebase
serena search-for-pattern --substring-pattern "TODO" --paths-include-glob "**/*.ts"

# get symbols overview of a file
serena get-symbols-overview --relative-path src/index.ts

# find a symbol
serena find-symbol --name-path-pattern "MyClass/myMethod" --relative-path src/index.ts

# read/list memories
serena list-memories
serena read-memory --memory-name project_overview

# output as JSON for scripting
serena list-memories --output json

# increase timeout for slow operations
serena get-symbols-overview --relative-path src/large-file.ts --timeout 60000
```

## Suppress Stderr Noise

Serena writes INFO logs to stderr on every call. Suppress in scripts:

```bash
serena list-memories 2>/dev/null
```

## Regenerating the Binary

When serena is updated upstream:

```bash
npx mcporter generate-cli --from ~/.local/bin/serena
```

This re-reads the embedded metadata and reruns the original generation command against the latest server.

## Original Generation Command

```bash
npx mcporter generate-cli \
  --command "uvx --from git+https://github.com/oraios/serena serena start-mcp-server" \
  --name serena \
  --description "Serena coding agent MCP tools CLI" \
  --runtime bun \
  --compile ~/.local/bin/serena
```
