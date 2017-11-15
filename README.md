These are my dotfiles, y'all. Nothing special, really.

## My dev stack

- zsh + [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh/)
- [Neovim](https://neovim.io/) + [tmux](https://github.com/tmux/tmux) as my IDE
- [Vundle](https://github.com/gmarik/vundle) for Vim plugin management
- A ton of Vim plugins (check my [.vimrc](./vimrc) for a current list)

## Installation

I manage my dotfiles using the conveniently-named Python package
[dotfiles](http://pypi.python.org/pypi/dotfiles), which is extremely handy for
setting up all your $HOME symlinks for you and keeping them in sync.

There's also a lot of dependencies that have to be installed from Homebrew.
I should probably put those all in a script at some point so it's officially
documented somewhere.

## License

I can't license other people's submodules obviously, but for anything that
isn't already licensed, assume the [WTFPL license](http://sam.zoy.org/wtfpl/).
