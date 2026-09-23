---
name: url-to-markdown
description: Use when needing an easily readable markdown version of any web page.
---

If given a URL from the user, or a list of URLs from a web search, you can make the page more readable by converting it to markdown.

## Usage

If the link is to github.com, **ALWAYS** use the `gh` CLI tool if available to read the URL. If not, continue.

If the `hister` CLI tool exists, or if Hister is running at `localhost:4433`, use its search API to see if a Markdown representation of the page is available. If Hister is not available, continue.

If the `jina` CLI tool exists:

1. set the `JINA_API_KEY` env var: `export JINA_API_KEY=$(pass agents/jina-reader/pi)`
2. use `jina read` to get a markdown rendering of a page: `jina read http://www.example.com`

If `jina` is not installed, use the Jina web API. Example with `curl`:

```bash
# fetch www.example.com
curl "https://r.jina.ai/https://www.example.com" \
  -H "Authorization: Bearer $(pass agents/jina-reader/pi)"
```
