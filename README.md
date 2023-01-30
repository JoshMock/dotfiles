These are my dotfiles.
Hand-crafted and distilled for well over a decade now.

## My dev setup

- [Arch Linux](https://archlinux.org/), currently on Lenovo ThinkPads
- [i3wm](https://i3wm.org/) or (Sway)[https://swaywm.org/]
- [ZSA Moonlander](https://www.zsa.io/moonlander/) keyboard
- zsh + [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/)
- [LunarVim](https://www.lunarvim.org/) + [Kitty](https://sw.kovidgoyal.net/kitty/) as my IDE
- [Several Vim plugins](/neovim/.config/lvim/config.lua#L130-L147) not packaged with LunarVim

## Installation

I manage my dotfiles using [GNU Stow](https://www.gnu.org/software/stow/), which is extremely handy for setting up all your `$HOME` symlinks for you and keeping them in sync.

There are also many dependencies that have to be installed from your OS's package manager.
It's an exercise for the reader to figure out what those might be; at the time of this writing, `pacman` says I have 268 explicitly-installed packages.
Here is a non-exhaustive list of things that aren't language-specific or Linux-specific:

- Command line utilities:
  - [bat](https://github.com/sharkdp/bat/)
  - [direnv](https://github.com/direnv/direnv)
  - [exa](https://github.com/ogham/exa)
  - [fd](https://github.com/sharkdp/fd)
  - [fzf](https://github.com/junegunn/fzf)
  - [git-extras](https://github.com/tj/git-extras/)
  - [GitHub CLI](https://cli.github.com/)
  - [jq](https://stedolan.github.io/jq/)
  - [McFly](https://github.com/cantino/mcfly)
  - [nnn](https://github.com/jarun/nnn/)
  - [ripgrep](https://github.com/BurntSushi/ripgrep)
  - [Starship](https://starship.rs/)
  - [tmux](https://github.com/tmux/tmux)
  - [yq](https://github.com/mikefarah/yq)
- Task management:
  - [Taskwarrior](https://taskwarrior.org/)
  - [Bugwarrior](https://bugwarrior.readthedocs.io/en/latest/)
  - [Timewarrior](https://timewarrior.net/)
  - [vit](https://github.com/vit-project/vit/)
- Not having to open Google apps:
  - [gcalcli](https://github.com/insanum/gcalcli)
  - [gmailctl](https://github.com/mbrt/gmailctl)
  - In theory I should put something like [Neomutt](https://neomutt.org/) here, but I just haven't gotten to it, ok?
- Etc:
  - Language version management: [asdf](https://asdf-vm.com/)
  - Text expansion: [Espanso](https://espanso.org/)
  - File archival: [git-annex](https://git-annex.branchable.com/)
  - Backups: [restic](https://restic.readthedocs.io/en/stable/)

Additionally, LunarVim handles the heavy lifting of managing [language servers](https://langserver.org/) for me.
It's fantastic.

## License

I can't license other people's submodules, obviously, but for anything that
isn't already licensed, assume the [GPL license](https://www.gnu.org/licenses/gpl.html).
