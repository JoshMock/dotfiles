---
name: workspace
description: Use when creating a new Git branch or worktree for a code change.
---

Use `jj` as the default way to track changes in a Git repository. **NEVER USE `git` UNLESS THERE IS NO ALTERNATIVE.**

## Creating a new branch of work

If you are already in a subdirectory of `~/.local/share/jj-workspaces/`, ignore steps 1-3.

1. If the Git repo does not have a `.jj` directory yet, run `jj git init --colocate`
2. Create a new jj workspace: `jj ws [workspace name]`
3. Move to the workspace dir: `cd $(jj workspace root --name [workspace name])`
4. Use `jj new -m "[commit message]"` to start a new change. This will create an empty commit on top of the current one. Every time you run a `jj` command, the current change will be updated automatically.

You will not be responsible for merging your work back into the main branch.

## Tips

- Make each change an atomic and self-contained body of work
- Restart a change with `jj abandon`
- Restore a file from the previous change with `jj restore --from @- path/to/file`
- Navigate to a different change to update its atomic edits with `jj edit [revision hash]`
- Update the description of the current change with `jj describe -m '[description]'`
