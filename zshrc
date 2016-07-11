# speed up ZSH init time?
skip_global_compinit=1

# Oh My Zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom
ZSH_THEME="joshmock"

DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(z git gitfast osx npm vundle vim-interaction)
source $ZSH/oh-my-zsh.sh

# Get $PATH from ~/.profile
source ~/.profile

# virtualenv stuff
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

# make vim play nice when editing cron jobs
alias crontab="VIM_CRONTAB=true crontab"

# include external files
[ -r ~/.emma ] && source ~/.emma # work-sensitive things I don't want on Github
[ -r ~/.echonest ] && source ~/.echonest # Echo Nest key as envvar
[ -r ~/.djlazy ] && source ~/.djlazy # DJ Lazy envvars https://github.com/jemise111/dj-lazy

# `prunelocal` will get rid of all git branches that have been merged into your current branch
alias prunelocal='git branch -d `git branch --merged | grep -v "^*"`'

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

# necessary alias for Bower to play nice with oh-my-zsh
alias bower='noglob bower'

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

# make an animated GIF from inputted .mov file: makegif path/to/file.mov
# requires installation of imagemagick and ffmpeg 2+
makegif() {
    mkdir -p /tmp/gifout;
    rm /tmp/gifout/*;
    ffmpeg -i "$*" -vf scale=320:-1 -r 10 /tmp/gifout/ffout%3d.png;
    convert -delay 8 -loop 0 /tmp/gifout/ffout*.png animation.gif;
    echo "animation.gif created";
    rm -r /tmp/gifout;
}

# make number keypad work again
# 0 . Enter
bindkey -s "^[Op" "0"
bindkey -s "^[Ol" "."
bindkey -s "^[OM" "^M"
# 1 2 3
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
# 4 5 6
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
# 7 8 9
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# + -  * /
bindkey -s "^[Ok" "+"
bindkey -s "^[Om" "-"
bindkey -s "^[Oj" "*"
bindkey -s "^[Oo" "/"

# make an alias for Dash.app searches
alias dash="open dash\://$*"

# set default editors
export VISUAL=/usr/local/bin/nvim
export EDITOR=/usr/local/bin/nvim

# syntax highlighting when using `less` on the command line (required: brew install source-highlight)
export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# use greadlink for the vim-interaction plugin
# requires `brew install coreutils`
alias readlink=greadlink

# NVM settings
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
