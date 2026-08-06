---
name: find-links
description: Use this skill to search for bookmarked URLs that are relevant to your work.
---

A CLI tool `packt` exists on this machine, which gives access to a semantically-searchable index of URLs with some basic metadata attached.

Basic usage:

```sh
# one-time setup: env vars required to connect to Elasticsearch and Jina APIs
export ELASTICSEARCH_URL=$(pass show cloud/context-graph/es-url)
export ELASTICSEARCH_API_KEY=$(pass show cloud/context-graph/elasticsearch)
export JINA_API_KEY=$(pass show agents/jina-reader/pi)

# do a bookmark search
packt search 'RFCs about CLI tools'
```

Search for all links with a given tag:

```sh
packt search --tag cli
```


Get the results of a search back as JSON:
```sh
packt search --json --tag cli 'workstream planning docs'
```
