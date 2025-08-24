FROM quay.io/toolbx/arch-toolbox:latest

ARG user=makepkg
RUN useradd --system --create-home $user \
  && echo "$user ALL=(ALL:ALL) NOPASSWD:ALL" > /etc/sudoers.d/$user
USER $user
WORKDIR /home/$user

RUN curl -s 'https://archlinux.org/mirrorlist/?country=US&protocol=https&use_mirror_status=on' | sed 's/^#Server/Server/' | grep -v '^#' | sudo tee /etc/pacman.d/mirrorlist

RUN git clone https://aur.archlinux.org/yay.git \
  && cd yay \
  && makepkg -sri --needed --noconfirm \
  && cd \
  && rm -rf .cache yay

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
