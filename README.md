These are my dotfiles, y'all. Nothing special, really.

## My dev stack

- zsh + [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/)
- [Neovim](https://neovim.io/) + [tmux](https://github.com/tmux/tmux) as my IDE
- [vim-plug](https://github.com/junegunn/vim-plug) for Vim plugin management
- A ton of Vim plugins (check my [init.vim](./config/nvim/init.vim) for a current list)

## Installation

I manage my dotfiles using [GNU Stow](https://www.gnu.org/software/stow/), which
is extremely handy for setting up all your `$HOME` symlinks for you and keeping
them in sync.

There's also a lot of dependencies that have to be installed from Homebrew
(though, switching to Nix for cross-platform support and because Homebrew is
getting annoying) and other places. [This is a script](./install.sh) that,
experimentally, does all that jazz. It's probably not safe to run, but it's
a decent way to get a sense of what needs to be installed.

## License

I can't license other people's submodules, obviously, but for anything that
isn't already licensed, assume the [GPL license](https://www.gnu.org/licenses/gpl.html).
