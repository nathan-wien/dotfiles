#!/bin/bash

apps=(
  'alacritty'
  'curl'
  'fzf'
  'geany'
  'i3'
  'i3status-rs'
  'krita'
  'stow'
  'sxiv'
  'tmux'
  'tmuxinator'
  'valgrind'
  'vim'
  'vlc'
  'wget'
  'zathura'
  'zsh'
)

dots=(
  'alacritty'
  'bash'
  'code'
  'i3'
  'tmux'
  'vim'
  'xmodmap'
  'zsh'
)

function apt_update() {
  sudo apt update
}

function apt_install() {
  sudo apt install $* -y
}

function snap_install() {
  sudo snap install $*
}

function install_alacritty() {
  sudo add-apt-repository ppa:aslatter/ppa
  apt_install alacritty
}

function install_clang-format() {
  apt_install clang-format
}

function install_curl() {
  apt_install curl
}

function install_ibus-bamboo() {
  sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
  apt_update
  apt_install ibus-bamboo
  ibus-daemon &
  ibus restart
}

function install_fonts-firacode() {
  apt_install fonts-firacode
}

function install_fonts-inconsolata() {
  apt_install fonts-inconsolata
}

function install_fzf() {
  apt_install fzf ripgrep universal-ctags silversearcher-ag fd-find
}

function install_geany() {
  apt_install geany libvte9
}

function install_i3() {
  apt_install i3 i3blocks rofi pasystray light blueman
  sudo chmod +s /usr/bin/light
}

function install_i3status-rs() {
  sudo apt install libdbus-1-dev
}

function install_neovim() {
  apt_install neovim
}

function install_npm() {
  apt_install npm
}

function install_papirus-icon-theme() {
  apt_install papirus-icon-theme
}

function install_spotify() {
  snap_install spotify
}

function install_stow() {
  apt_install stow
}

function install_sxiv() {
  apt_install sxiv
}

function install_subversion() {
  apt_install subversion
}

function install_tmux() {
  apt_install tmux
}

function install_tmuxinator() {
  sudo gem install tmuxinator
}

function install_valgrind() {
  apt_install valgrind
}

function install_vim() {
  apt_install vim vim-gtk3
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
}

function install_vlc() {
  apt_install vlc
}

function install_wget() {
  apt_install wget
}

function install_zathura() {
  apt_install zathura
}

function install_zeal() {
  apt_install zeal
}

function install_zsh() {
  apt_install zsh
}

echo "Actions:"
echo "  [1] Install packages"
echo "  [2] Create symlinks for dotfiles"
read -p " -> " action

case $action in
  [1])
    # apt_update
    echo "Options:"
    echo "  [1] Install all packages"
    echo "  [2] Install single packages"
    read -p " -> " option

    case $option in
      [1])
        for ((i = 0; i < ${#apps[@]}; i++));
        do
          echo "Installing "${apps}
          install_cmd=install_${apps[$i]}
          $install_cmd
        done
        echo
      ;;
      [2])
        for ((i = 0; i < ${#apps[@]}; i++));
        do
          echo -n $i: ${apps[$i]}"; "
        done
        echo

        read -p "  -> " inp
        IFS=' ' read -ra chosen_indices <<< "$inp"

        for chosen_index in "${chosen_indices[@]}"; do
          install_cmd=install_${apps[$chosen_index]}
          $install_cmd
        done
      ;;
      *)
        echo "Invalid input!"
        exit
      ;;
    esac
  ;;
  [2])
    for ((i = 0; i < ${#dots[@]}; i++));
    do
      echo -n $i: ${dots[$i]}"; "
    done
    echo

    read -p "  -> " chosen_app_index
    cmd="stow -t$HOME -v ${dots[$chosen_app_index]}"
    echo $cmd
    $cmd
  ;;
  *)
    exit
  ;;
esac