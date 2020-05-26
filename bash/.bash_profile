# "Include" external dotfiles if they exist. Stolen from Paul Irish:
# https://github.com/paulirish/dotfiles/blob/master/.bash_profile
[ -r ~/.emma ] && source ~/.emma

alias crontab="VIM_CRONTAB=true crontab"

export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

source ~/.git-completion.sh
export GIT_PS1_SHOWDIRTYSTATE=1

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
PS1='\[$(tput setaf 1)\]$(__git_ps1 "(%s) ")\[$(tput setaf 2)\]\w $ \[$(tput sgr0)\]'

# get $PATH from ~/.profile
source ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"
if [ -e /Users/joshmock/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/joshmock/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
