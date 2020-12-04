# speed up ZSH init time?
skip_global_compinit=1

# virtualenvwrapper setup
#export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
alias python='python3'

# Oh My Zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"
plugins=(z git gitfast git-extras osx node npm zsh-autosuggestions docker)
source $ZSH/oh-my-zsh.sh

# set $PATH
source $HOME/.profile

# nix
[ -r $HOME/.nix-profile/etc/profile.d/nix.sh ] && source $HOME/.nix-profile/etc/profile.d/nix.sh

# make vim play nice when editing cron jobs
alias crontab="VIM_CRONTAB=true crontab"

# include external files
[ -r $HOME/.elastic ] && source $HOME/.elastic # work-sensitive things I don't want on Github

# refresh git submodules
alias refresh_submodules='git submodule foreach git pull origin master'

# easy server
alias server='python -m SimpleHTTPServer'

# use `exa` for fancy `ls` replacement
EXA_COLORS="da=1;34;nnn:di=32;1:*.log=37;41;1"
alias l="exa --long --header --all"

# oh-my-zsh already adds .. and ..., this just takes it a step further
alias ....='cd ../../..'
alias .....='cd ../../../..'

# takes JSON in your clipboard, pretty-formats it, copies it back to clipboard
alias prettyjson='pbpaste | python -m json.tool | pbcopy'

# set default editors
export VISUAL=nvim
export EDITOR=nvim
alias n='NVIM_LISTEN_ADDRESS=/tmp/nvimsocket nvim'

# syntax highlighting when using `less` on the command line
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '

# NVM settings
export NVM_DIR="$HOME/.nvm"
alias loadnvm='[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"'

# configure ripgrep
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# fzf fuzzy completion and key binding
source "/usr/share/fzf/key-bindings.zsh"

# iTerm integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

nfind() {
  # drop search results into fzf, selected files open in nvim
  nvim $(rg "$1" -l | fzf -m)
}

# check out a git branch
alias gb='git checkout $(git --no-pager branch --no-color | awk "{print $1}" | grep -v \* | fzf)'

# kitty git diffs
alias gd='git difftool --no-symlinks --dir-diff'

# direnv
eval "$(direnv hook zsh)"

# starship
eval "$(starship init zsh)"
