---
name: web-search
description: Search the web using SearxNG, a locally-run meta search engine that aggregates results from multiple engines
---

# SearXNG Search

SearXNG is a metasearch engine that runs locally. It aggregates results from multiple search engines and package repositories, returning clean JSON output.

## Quick Reference

| Task | Command | Category |
|------|---------|----------|
| General web search | `curl "http://localhost:8080/search?q=<query>&format=json"` | `general` |
| Search Cargo/crates.io | `curl "http://localhost:8080/search?q=<crate>&format=json&categories=cargo"` | `cargo` |
| Search npm packages | `curl "http://localhost:8080/search?q=<pkg>&format=json&categories=packages"` | `packages` |
| Search code repositories | `curl "http://localhost:8080/search?q=<query>&format=json&categories=repos"` | `repos` |
| Search IT resources | `curl "http://localhost:8080/search?q=<query>&format=json&categories=it"` | `it` |
| Limit results | Add `&limit=N` to URL | - |
| Multiple categories | `&categories=cat1,cat2` | - |

## Available Categories

Run to see all categories:
```bash
curl -s "http://localhost:8080/config" | jq '.categories'
```

Notable categories:
- **general**: General web search (default)
- **cargo**: Rust crates from crates.io
- **packages**: Multi-repo (npm, rubygems, haskell/hoogle, hex, packagist, metacpan, pub.dev, pkg.go.dev, docker hub, alpine, etc.)
- **it**: IT/tech resources (includes GitHub, Docker Hub, crates.io)
- **repos**: Code repositories
- **scientific publications**: Academic papers

## JSON Response Structure

```json
{
  "query": "search term",
  "number_of_results": 0,
  "results": [
    {
      "url": "https://example.com",
      "title": "Result Title",
      "content": "Snippet of content...",
      "publishedDate": "2025-01-01T00:00:00",
      "engine": "duckduckgo",
      "engines": ["duckduckgo", "startpage"],
      "score": 3.0,
      "category": "general"
    }
  ],
  "answers": [],          // Direct answers/infoboxes
  "suggestions": [],      // Search suggestions
  "corrections": [],      // Query corrections
  "infoboxes": [],       // Knowledge panels
  "unresponsive_engines": []
}
```

## Common Usage Patterns

### 1. Package Repository Searches

**Cargo/Rust crates:**
```bash
curl -s "http://localhost:8080/search?q=tokio&format=json&categories=cargo" | \
  jq '.results[] | {title, url, content}'
```

**npm packages:**
```bash
curl -s "http://localhost:8080/search?q=express&format=json&categories=packages" | \
  jq '.results[] | select(.engines[] == "npm") | {title, url, content}'
```

**PyPI packages (workaround - see below):**
```bash
# PyPI engine is enabled but not returning results in current SearXNG config
# Use direct API or qypi CLI instead (see PyPI Workaround section)
```

### 2. Web Search with Filtering

**IT/Tech search:**
```bash
curl -s "http://localhost:8080/search?q=rust+async&format=json&categories=it" | \
  jq '.results[0:5] | .[] | {title, url, engines}'
```

**GitHub repositories:**
```bash
curl -s "http://localhost:8080/search?q=machine+learning&format=json&categories=repos" | \
  jq '.results[] | select(.engines[] == "github") | {title, url}'
```

### 3. Extracting Specific Information

**Very helpful** for avoiding wasting tokens by adding a large amount of data to the context.

**Get top 3 results:**
```bash
curl -s "http://localhost:8080/search?q=rust+ownership&format=json" | \
  jq '.results[0:3] | .[] | {title, url, content}'
```

**Check which engines returned results:**
```bash
curl -s "http://localhost:8080/search?q=python&format=json" | \
  jq '.results[0].engines'
```

**Get answer boxes/infoboxes:**
```bash
curl -s "http://localhost:8080/search?q=rust+language&format=json" | \
  jq '.infoboxes, .answers'
```

## Known Issues

- **Cargo category sometimes returns empty**: Try `categories=packages` or `categories=it` which also include crates.io
- **Rate limiting**: SearXNG may rate-limit if too many requests in quick succession
