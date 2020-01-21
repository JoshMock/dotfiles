# install all submodules
git submodule foreach git pull origin master

# install nix
curl https://nixos.org/nix/install | sh

# install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# install all my dang dependencies from Homebrew and Nix
nix-env -iA nixpkgs.myPackages
brew install node python@2 python3 tmux zsh
brew unlink python && brew link python@2
brew cask install java

# install python dependencies
easy_install pip
pip install virtualenv virtualenvwrapper dotfiles pynvim python-language-server pylint
pip3 install virtualenv virtualenvwrapper dotfiles pynvim python-language-server black pyls-black neovim-remote pylint vit
dotfiles --sync

# install vim plugins
nvim +PlugInstall +qall
vim +PlugInstall +qall

# install global Node dependencies
nvm install 11 && nvm alias default 11 && nvm use 11
npm install -g npm@latest
npm install -g eslint eslint-plugin-react tern javascript-typescript-langserver
