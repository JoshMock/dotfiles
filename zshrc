# speed up ZSH init time?
skip_global_compinit=1

# Oh My Zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom
ZSH_THEME="joshmock"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"
plugins=(z history git gitfast git-extras osx npm zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# Get $PATH from ~/.profile
source ~/.profile

# virtualenv stuff
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# make vim play nice when editing cron jobs
alias crontab="VIM_CRONTAB=true crontab"

# include external files
[ -r ~/.elastic ] && source ~/.elastic # work-sensitive things I don't want on Github

# refresh git submodules
alias refresh_submodules='git submodule foreach git pull origin master'

# easy server
alias server='python -m SimpleHTTPServer'

# use `exa` for fancy `ls` replacement
alias l="exa --long --header --all"

# oh-my-zsh already adds .. and ..., this just takes it a step further
alias ....='cd ../../..'
alias .....='cd ../../../..'

# takes JSON in your clipboard, pretty-formats it, copies it back to clipboard
alias prettyjson='pbpaste | python -m json.tool | pbcopy'

# `sshkey <name of host>` will put my ssh key on that host so I can log into it
# in the future without a password
sshkey() {
    ssh "$*" mkdir -p .ssh;
    cat ~/.ssh/id_rsa.pub | ssh "$*" 'cat >> .ssh/authorized_keys';
}

# set default editors
export VISUAL=/usr/local/bin/nvim
export EDITOR=/usr/local/bin/nvim

# syntax highlighting when using `less` on the command line
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# NVM settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# configure ripgrep
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# fzf fuzzy completion and key binding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
