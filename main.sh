#!/bin/bash

print_help() {
  echo "Help:"
  echo "[-h|--help] for help"
  echo "[-d|--dist 'name'] to select dist"
}

firefox_setup() {
  sudo apt install jq libxml2-utils -y
  bash .firefox/addons.sh
  bash .firefox/stylesheets.sh
  sudo apt remove jq libxml2-utils -y
}

git_setup() {
  git config --global user.name "Matic Pintarič"
  git config --global user.email matic.pintaric@outlook.com
}

vim_setup() {
  cp .vimrc -t "$HOME/"
}

tmux_setup() {
  cp .tmux.conf -t "$HOME/"
}

directories_setup() {
  mkdir -p ~/Documents/{dev,faks}
}

clean() {
  sudo apt autoclean -y
  sudo apt autoremove -y
}

ubuntu_install() {
  # update and upgrade
  sudo apt update && sudo apt upgrade -y
  # apt packages
  sudo apt install git vim tmux openvpn transmission virtualbox gnome-tweak-tool -y
  # snap packages
  sudo snap install spotify discord vlc
  sudo snap install code --classic
  # firefox
  firefox_setup
  # git
  git_setup
  # vim
  vim_setup
  # tmux
  tmux_setup
  # default directories
  directories_setup
  # regolith i3wm
  sudo add-apt-repository ppa:regolith-linux/release -y
  sudo apt install regolith-desktop -y
  # clean
  clean
}

DIST=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help) print_help; exit 0;;
    -d|--dist) DIST=$2; break;;
    *) echo "Unvalid parameter: $1"; exit 1;;
  esac
done

case $DIST in
  ubuntu) ubuntu_install;;
  *) echo "Unvalid dist: $DIST"; exit 1;;
esac

exit 0
