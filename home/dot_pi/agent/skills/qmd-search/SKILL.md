---
name: qmd-search
description: Search local documentation collections indexed by qmd. Read-only access to query, browse, and retrieve docs. Use when you need to look up API references, library docs, or any indexed documentation.
---

# qmd Documentation Search

Search and retrieve documentation from locally indexed collections using the `qmd` CLI.

## Safety Rules (Do Not Violate)

- **READ ONLY.** Never run commands that add, modify, remove, or re-index data.
- Forbidden commands: `collection add`, `collection remove`, `collection rename`, `context add`, `context rm`, `update`, `embed`, `cleanup`, `mcp`.
- Only use: `query`, `search`, `vsearch`, `get`, `multi-get`, `ls`, `collection list`, `status`.

## Suggested Workflow

1. **Discover what's available** — run `qmd context list` to see indexed collections and their descriptions.
2. **Search for information** — pick the best search mode:
   - `qmd query "<terms>"` — hybrid search with query expansion and reranking (best default choice).
   - `qmd search "<terms>"` — keyword/BM25 search when you want exact term matches.
   - `qmd vsearch "<terms>"` — vector similarity search for conceptual/fuzzy queries.
   **IMPORTANT:** on a machine with no Nvidia GPU, **ONLY** use `qmd search`, never `vsearch` or `query`.
3. **Scope to a collection** when you know which one is relevant: add `-c <collection>`.
4. **Retrieve full documents** when a search result looks promising: `qmd get <docid>` or `qmd get <docid> -l 100` to limit lines.
5. **Batch retrieve** with `qmd multi-get "<glob>"` for pulling several related files at once.

## Useful Options

| Flag | Purpose |
|---|---|
| `-n <num>` | Number of results (default 5; 20 for `--files`) |
| `-c <name>` | Filter to a specific collection |
| `--full` | Return full document content instead of snippets |
| `--line-numbers` | Add line numbers to output |
| `--files` | Compact output: docid, score, filepath, context |
| `--json` | JSON output with snippets |
| `--md` | Markdown-formatted output |
| `--min-score <n>` | Minimum similarity score filter |

## Notes

- Prefer `qmd query` over `search` or `vsearch` unless you have a specific reason — it combines both approaches with reranking.
- Use `--files` first to scan many results quickly, then `qmd get` on the most relevant hits.
- If results are poor, try rephrasing or broadening the query terms.
- `qmd ls <collection>` lists all files in a collection for manual browsing.
