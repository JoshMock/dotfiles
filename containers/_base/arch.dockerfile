FROM quay.io/toolbx/arch-toolbox:latest

RUN pacman -S --needed --noconfirm reflector && \
  reflector --save /etc/pacman.d/mirrorlist --protocol https --country US --score 15 --sort age && \
  pacman -S --needed --noconfirm \
  atuin \
  direnv \
  exa \
  fd \
  fzf \
  neovim \
  nodejs \
  npm \
  ripgrep \
  starship \
  traceroute \
  wget \
  which \
  zellij \
  zsh && \
  git clone --depth=1 https://github.com/mattmc3/antidote.git /usr/share/zsh-antidote
