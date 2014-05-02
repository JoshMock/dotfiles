# Oh My Zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="fletcherm"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(z git gitfast vagrant python osx lein)
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

# auto-open certain filetypes in vim
alias -s py=vim
alias -s html=vim
alias -s js=vim

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
