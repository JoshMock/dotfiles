# speed up ZSH init time?
skip_global_compinit=1

# Oh My Zsh settings
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh-custom
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_DISABLE_COMPFIX="true"
plugins=(z git gitfast git-extras zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# include external files
[ -r $HOME/.elastic ] && source $HOME/.elastic # work-sensitive things I don't want on Github
[ -r $HOME/.personal ] && source $HOME/.personal # personal machine things

# refresh git submodules
alias refresh_submodules='git submodule foreach git pull origin master'

# easy server
alias server='python -m SimpleHTTPServer'

# use `exa` for fancy `ls` replacement
EXA_COLORS="da=1;34;nnn:di=32;1:*.log=37;41;1"
alias l="exa --long --header --all --icons"

# oh-my-zsh already adds .. and ..., this just takes it a step further
alias ....='cd ../../..'
alias .....='cd ../../../..'

# system clipboard shortcuts
if [[ -z "${WAYLAND_DISPLAY}" ]]
then
  alias ccopy='wl-copy'
  alias cpaste='wl-paste'
else
  alias ccopy='xclip -selection clipboard'
  alias cpaste='xclip -selection clipboard -o'
fi

# takes JSON in your clipboard, pretty-formats it, copies it back to clipboard
alias prettyjson='cpaste | jq | ccopy'

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

# use bat as default pager
export PAGER="bat -p"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# hack to make Docker commands work in makefiles
alias make='SHELL=/bin/bash make'

# nnn config
export NNN_FIFO="/tmp/nnn.fifo"
export NNN_PLUG='p:preview-tui;a:!git annex get --jobs=4 "$nnn"'

# mcfly support
export MCFLY_FUZZY=2
eval "$(mcfly init zsh)"
