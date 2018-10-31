# speed up ZSH init time?
skip_global_compinit=1

# Oh My Zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom
ZSH_THEME="joshmock"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
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
[ -r ~/.echonest ] && source ~/.echonest # Echo Nest key as envvar
[ -r ~/.djlazy ] && source ~/.djlazy # DJ Lazy envvars https://github.com/jemise111/dj-lazy

# refresh git submodules
alias refresh_submodules='git submodule foreach git pull origin master'

# easy server
alias server='python -m SimpleHTTPServer'

# Detect which `ls` flavor is in use (stolen from Paul Irish)
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi
alias l="ls -la ${colorflag}"

# oh-my-zsh already adds .. and ..., this just takes it a step further
alias ....='cd ../../..'
alias .....='cd ../../../..'

# takes JSON in your clipboard, pretty-formats it, copies it back to clipboard
alias prettyjson='pbpaste | python -m json.tool | pbcopy'

# find my Raspberry Pi on current network based on its known MAC addresses
alias rpi_ip="arp -a | grep 'b8:27:eb|00:13:ef:d0:22:94' | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'"

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

# the saddest alias
alias sigh="rm -rf ./node_modules && npm i"

# ignore noisy files in the_silver_searcher
alias ag="ag --path-to-ignore ~/.agignore"

# configure ripgrep
export RIPGREP_CONFIG_PATH=~/.ripgreprc

# fzf fuzzy completion and key binding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
