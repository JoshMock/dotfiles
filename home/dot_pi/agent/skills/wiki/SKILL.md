---
name: wiki
description: This is your long-term memory. Use at the beginning of any turn to look up useful information that is not available in your current context (e.g. README, AGENTS.md, repo documentation). Use at the end of any turn to store anything that should be remembered long-term. Any best practices, coding concepts, or  that are useful across sessions.
---

Your long term memory for any concepts that are not specific to a single repository live in `~/Code/llm-wiki/`.

Types of materials you will read or add in the wiki:

- coding conventions
- best practices
- general context about a collection of repositories or dependencies that are meant to be used together
- other contextual information about current work, initiatives, or larger goals of the current work

## Before starting work

Use `tree`, `ls`, `exa`, or any other file/directory listing tools to view the file structure.
If file and directory names are not helpful, use `head` or other line-based file reading tools to view the YAML frontmatter of documents to get human-readable titles, descriptions and other metadata.
If you find documents that seem relevant to your work, read them in full.

## Before writing anything

**ALWAYS read `~/Code/llm-wiki/AGENTS.md` in full before creating or editing any wiki file.**
It specifies mandatory format rules (OKF frontmatter fields, index.md requirements, source control steps) that must be followed for every write. Skipping this step will produce malformed entries.

Required frontmatter fields (from AGENTS.md):
- `type`: kind of concept, e.g. "Process Rule", "Code Review Principle", "Reference"
- `title`: human-readable display name
- `description`: single sentence summary
- `resource`: URI identifying the underlying asset (omit only if no canonical URL exists)
- `tags`: YAML list of short strings

Required housekeeping for every write:
1. Start a new `jj` revision (or `git` commit) **before** making changes, with a short description.
2. Update (or create) the `index.md` in the same directory.
3. Fix any links if renaming or removing a file.

## At the end of a turn

If any information or instruction you have received impacted the work you just did, evaluate whether it would be useful to add to the wiki or modify existing materials.
Use the file structure to help make this decision, but feel free to add new directories or files if they do not exist.
Once you have information to add, if you have the ability to spawn subagents, instruct it with what information it should add and where it should add it.
If you cannot spawn subagents, make the changes yourself.
