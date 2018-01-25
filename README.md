These are my dotfiles, y'all. Nothing special, really.

## My dev stack

- zsh + [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/)
- [Neovim](https://neovim.io/) + [tmux](https://github.com/tmux/tmux) as my IDE
- [vim-plug](https://github.com/junegunn/vim-plug) for Vim plugin management
- A ton of Vim plugins (check my [init.vim](./config/nvim/init.vim) for a current list)

## Installation

I manage my dotfiles using the conveniently-named Python package
[dotfiles](http://pypi.python.org/pypi/dotfiles), which is extremely handy for
setting up all your $HOME symlinks for you and keeping them in sync.

There's also a lot of dependencies that have to be installed from Homebrew and
other places. [This is a script that](./install.sh), experimentally, does all that jazz.

## License

I can't license other people's submodules, obviously, but for anything that
isn't already licensed, assume the [WTFPL license](http://sam.zoy.org/wtfpl/).
