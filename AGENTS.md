## Environment

These dotfiles are built for a developer-optimized laptop running latest Arch Linux. Check the README to understand my preferred toolset.

## Applying changes

- **NEVER** run `chezmoi` commands unless explicitly instructed.
- **NEVER** attempt to install packages yourself.
- After completing changes, show a list of commands and other necessary instructions to apply the changes you just made.

## Configuration change requirements

- **ALWAYS** search the web or documentation to correctly configure a tool based on the version that is currently in use.
- **NEVER** depend on your own trained knowledge without verifying an external source.
- If a new package is required, it should be added to [.chezmoidata.yaml](./home/.chezmoidata.yaml)

## Machine-local overrides

`~/.config/hypr/hyprland.lua` loads `~/.config/hypr/custom.d/*.lua` last, so
anything there wins over the tracked config. That directory is deliberately not
managed or tracked by this repo: create it and drop files in it to try binds,
window rules or settings without editing `hyprland.lua` and without a
`chezmoi apply`.

```shell
mkdir -p ~/.config/hypr/custom.d
$EDITOR ~/.config/hypr/custom.d/10-experiment.lua
```

Hyprland reloads on save, so changes land immediately. Move anything worth
keeping into the tracked config and delete it from `custom.d` afterwards.
