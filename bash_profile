# "Include" external dotfiles if they exist. Stolen from Paul Irish:
# https://github.com/paulirish/dotfiles/blob/master/.bash_profile
[ -r ~/.work_stuff ] && source ~/.work_stuff

alias crontab="VIM_CRONTAB=true crontab"

export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

source ~/.git-completion.sh
export GIT_PS1_SHOWDIRTYSTATE=1

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
PS1='\[$(tput setaf 1)\]$(__git_ps1 "(%s) ")\[$(tput setaf 2)\]\w $ \[$(tput sgr0)\]'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
