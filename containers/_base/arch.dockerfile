FROM quay.io/toolbx/arch-toolbox:latest

ARG user=makepkg
RUN useradd --system --create-home $user \
  && echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
USER $user
WORKDIR /home/$user

RUN git clone https://aur.archlinux.org/yay.git \
  && cd yay \
  && makepkg -sri --needed --noconfirm \
  && cd \
  && rm -rf .cache yay

RUN yay -Syyu --noconfirm reflector && \
  sudo reflector --save /etc/pacman.d/mirrorlist --protocol https --country US --score 15 --sort age

RUN yay -S --noconfirm \
  atuin \
  direnv \
  exa \
  fd \
  fzf \
  neovim \
  ripgrep \
  starship \
  traceroute \
  wget \
  which \
  zellij \
  zsh \
  zsh-antidote
