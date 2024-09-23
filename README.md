These are my dotfiles.
Hand-crafted and distilled for well over a decade now.
They are a lifelong work-in-progress.

## My dev setup

I'm a heavy keyboard user.
Any time I can do something without using a mouse, I will.

### Hardware

- Laptops: Lenovo ThinkPad and Dell XPS
- Keyboard: [ZSA Moonlander](https://www.zsa.io/moonlander/)
- Mouse: whatever's nearby, preferably Bluetooth-based

### Software

- **Operating system:** [Arch Linux](https://archlinux.org/) or [EndeavourOS](https://endeavouros.com/) (Arch-based)
- **Window manager:** [Hyprland](https://hyprland.org/)
- **Shell:** zsh + [antidote](https://getantidote.github.io/) + [various zsh plugins](./home/dot_zsh_plugins.txt)
- **IDE:** Neovim ([LazyVim](https://www.lazyvim.org)-based setup) + [Kitty](https://sw.kovidgoyal.net/kitty/)

#### Various utilities

- **App launcher:** [Rofi](https://github.com/davatorium/rofi)
- **Music player:** [Mopidy](https://mopidy.com/) for listening to music
- **To-do list manager:** [Taskwarrior](https://taskwarrior.org/)
- **Text expansion:** [Espanso](https://espanso.org/)
- **Backups:** [Restic](https://restic.net/) + [Rclone](https://rclone.org/)
- **Email:** [Neomutt](https://neomutt.org/) (via [mutt-wizard](https://github.com/LukeSmithxyz/mutt-wizard))
- **File syncing:** [git-annex](https://git-annex.branchable.com/)

## Installation

I manage my dotfiles using [Chezmoi](https://www.chezmoi.io/), which uses template logic to handle config differences between machines.
If you want something simpler that just symlinks things to `$HOME` for you, I highly recommend [GNU Stow](https://www.gnu.org/software/stow/).

With Chezmoi installed, running the following will clone this repo and move all the pieces into place:

```shell
chezmoi init --apply --ssh JoshMock
```

### Automatically installed dependencies

These dotfiles assume the presence of many dependencies that have to be installed from your OS's package manager.
I'm currently experimenting with using Chezmoi to handle this, by maintaining [a file listing all packages](./home/.chezmoidata.yaml) I want installed by [`yay`](https://github.com/Jguer/yay), some of which are gated by feature flags (e.g. `desktop`, `work`, `mopidy`).
This is handled by [a Python script](./home/run_onchange_01-install-packages.tmpl) that runs whenever the list of packages or my feature flags in `~/.config/chezmoi/chezmoi.toml` changes.

An example `chezmoi.toml`:

```toml
[data]
taskwarrior = true
desktop = false
work = false
mopidy = true
email = true
```

This configuration would install all listed packages that either have no `features` set&mdash;packages to be installed on every machine&mdash;or whose features match one of the flags set to `true`.

If you are not running an Arch-based distribution with `yay` installed, this script will fail pretty quickly.
Eventually it would be cool to get it working with `apt` on Debian (for logging onto Raspberry Pis, Ubuntu servers, etc.).
`brew` support for MacOS is unlikely unless a future employer requires me to use a Mac, or I get tired of all this fiddly Linux business and cave in to the Apple ecosystem.

## License

I can't license other people's submodules, obviously, but for anything that isn't already licensed, assume the [GPL license](https://www.gnu.org/licenses/gpl.html).
