# install all submodules
git submodule foreach git pull origin master

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# install all my dang dependencies from Homebrew
brew install ctags exa fzf git git-extras leiningen neovim node par python@2 python3 reattach-to-user-namespace redis source-highlight tmux wget zsh ripgrep
brew unlink python && brew link python@2
brew cask install java
brew cask install kdiff3

# install fzf fuzzy auto-completion and key bindings
$(brew --prefix)/opt/fzf/install

# install python dependencies
easy_install pip
pip install virtualenv virtualenvwrapper dotfiles pynvim python-language-server
pip3 install virtualenv virtualenvwrapper dotfiles pynvim python-language-server
dotfiles --sync

# install vim plugins
nvim +PlugInstall +qall
vim +PlugInstall +qall

# install global Node dependencies
nvm install 10 && nvm alias default 10 && nvm use 10
npm install -g npm@latest
npm install -g eslint eslint-plugin-react tern javascript-typescript-langserver
