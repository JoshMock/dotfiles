---
name: url-to-markdown
description: Use when needing an easily readable markdown version of any web page.
---

If given a URL from the user, or a list of URLs from a web search, you can make the page more readable by converting it to markdown.

## Usage

If the link is to github.com, attempt to use the `gh` CLI tool to summarize the page. If not, continue.

Use the Jina Reader API with `curl`:

```bash
# fetch www.example.com
curl "https://r.jina.ai/https://www.example.com" \
  -H "Authorization: Bearer $(pass agents/jina-reader/pi)"
```
