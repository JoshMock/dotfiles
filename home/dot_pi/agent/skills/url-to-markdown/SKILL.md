---
name: url-to-markdown
description: Use when needing an easily readable markdown version of any web page.
---

If given a URL from the user, or a list of URLs from a web search, you can make the page more readable by converting it to markdown.

## Usage

Append any URL to `https://r.jina.ai/` to receive a markdown version of that page.

Example with `curl`:

```bash
# fetch www.example.com
curl "https://r.jina.ai/https://www.example.com" \
  -H "Authorization: Bearer $(pass agents/jina-reader/pi)"
```
