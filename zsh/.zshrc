source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

# autoload functions
export ZDOTDIR=$HOME/.zsh-custom
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(.:t)

# tool setup
eval "$(direnv hook zsh)" # direnv
eval "$(starship init zsh)" #starship
source "/usr/share/fzf/key-bindings.zsh" # fzf
export NNN_FIFO="/tmp/nnn.fifo" NNN_PLUG='a:!git annex get --jobs=4 "$nnn"*;q:!add-to-mopidy --path "$nnn"*;p:preview-tui;d:dragdrop' # nnn
eval "$(atuin init zsh --disable-up-arrow)" # atuin

# source external files that aren't source-controlled (or always available)
for f in $HOME/.elastic/elasticrc $HOME/.personal; do
  [ -r $f ] && source $f
done

# use `exa` for fancy `ls` replacement
export EXA_COLORS="da=1;34;nnn:di=32;1:*.log=37;41;1"
alias l="exa --long --header --all --icons"

# system clipboard shortcuts
if [[ -z "${WAYLAND_DISPLAY}" ]]
then
  alias ccopy='xclip -selection clipboard'
  alias cpaste='xclip -selection clipboard -o'
else
  alias ccopy='wl-copy'
  alias cpaste='wl-paste'
fi

alias prettyjson='cpaste | jq | ccopy'

# hack to make Docker commands work in makefiles
# alias make='SHELL=/bin/bash make'

# home taskwarrior alt
alias htask='TASKRC=$HOME/.taskrc-home task'
