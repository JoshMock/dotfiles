# install all submodules
git submodule foreach git pull origin master

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# install all my dang dependencies from Homebrew
brew install ctags fzf git git-extras leiningen neovim node par python3 reattach-to-user-namespace redis source-highlight the_silver_searcher tmux wget zsh ripgrep

# install fzf fuzzy auto-completion and key bindings
$(brew --prefix)/opt/fzf/install

# install python dependencies
easy_install pip
pip install virtualenv virtualenvwrapper dotfiles neovim
pip3 install neovim python-language-server
dotfiles --sync

# install vim plugins
nvim +PlugInstall +qall
vim +PlugInstall +qall

# install global Node dependencies
npm install -g npm@latest
npm install -g grunt-cli dj-lazy eslint@3.6.1 eslint-plugin-react@6.3.0 tern javascript-typescript-langserver
