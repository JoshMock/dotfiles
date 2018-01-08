# install all submodules
git submodule foreach git pull origin master

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install all my dang dependencies from Homebrew
brew install ctags fzf git git-extras leiningen neovim node nvm python3 reattach-to-user-namespace redis source-highlight the_silver_searcher tmux wget zsh

# install python dependencies
easy_install pip
pip install virtualenv virtualenvwrapper
pip install dotfiles && dotfiles --sync

# install vim plugins
nvim +PluginInstall +qall
vim +PluginInstall +qall

# install global Node dependencies
npm install -g npm@latest
npm install -g grunt-cli dj-lazy eslint@3.6.1 eslint-plugin-react@6.3.0 tern
