#!/bin/bash

print_help() {
    echo 'Help:'
    echo '[-h|--help] for help'
    echo '[-d|--dist "name"] to select dist'
    echo '[-a|--all] to list all dists'
}

print_dists() {
    echo 'ubuntu'
    echo 'arch'
}

config_setup() {
    mkdir -p $HOME/.config && cp -r .config/* -t $HOME/.config 
}

xorg_setup() {
    sudo mkdir -p /etc/X11/xorg.conf.d && cp -r .xorg/* -t /etc/X11/xorg.conf.d 
}

scripts_setup() {
    mkdir -p $HOME/.scripts && cp -r .scripts/* -t $HOME/.scripts
}

xinit_setup() {
    cp .xinitrc -t $HOME
}

bash_profile_setup() {
    cp .bash_profile -t $HOME
}

vim_setup() {
    cp .vimrc -t $HOME
    # create undodir
    mkdir -p $HOME/.vim/undodir
}

tmux_setup() {
    cp .tmux.conf -t $HOME
}

firefox_setup() { 
    sh .firefox/addons.sh
    sh .firefox/stylesheets.sh 
}

fonts_setup() {
    sh .fonts/jetbrains.sh
}

git_setup() {
    git config --global user.name 'Matic Pintarič'
    git config --global user.email matic.pintaric@outlook.com
}

# works with ubuntu 18.04
ubuntu_install() {
    # update and upgrade
    sudo apt update && sudo apt upgrade -y
    # apt packages
    sudo apt install git vim tmux openvpn transmission virtualbox gnome-tweak-tool -y
    # snap packages
    sudo snap install spotify discord vlc
    sudo snap install code --classic
    # firefox addons and stylesheets
    sudo apt install jq libxml2-utils -y
    firefox_setup
    sudo apt remove jq libxml2-utils -y
    # git
    git_setup
    # vim
    vim_setup
    # tmux
    tmux_setup
    # regolith i3wm
    sudo add-apt-repository ppa:regolith-linux/release -y
    sudo apt install regolith-desktop -y
    # clean 
    sudo apt autoclean -y
    sudo apt autoremove -y 
    # default directories
    mkdir -p $HOME/Documents/{dev,faks}
}

arch_install() {
    # pacman packages
    sudo pacman -S NetworkManager xorg-server xorg-xinit i3-gaps i3-status i3lock rxvt-unidode dmenu --noconfirm
    sudo pacman -S kitty ranger git vim openvpn unzip tar --noconfirm
    sudo pacman -S xrandr pulseaudio pavucontrol bluez bluez-utils compton redshift feh flameshot --noconfirm
    sudo pacman -S firefox code vlc transmission-cli --noconfirm
    # fonts
    sudo pacman -S noto-fonts
    sudo pacman -S ttf-font-awesome otf-font-awesome
    sudo pacman -S ttf-font-awesome-4 otf-font-awesome-4
    sudo pacman -S wget jq libxml2
    fonts_setup
    # xinit
    xinit_setup
    # bash profile
    bash_profile_setup
    # .config
    config_setup
    # xorg
    xorg_setup
    # scripts
    scripts_setup
    # firefox addons and stylesheets
    firefox_setup 
    sudo pacman -Rns wget jq libxml2
    # git
    git_setup
    # vim
    vim_setup
    # default directories
    mkdir -p $HOME/{dev,downloads,faks,pictures}
    # firefox download directory
    sh .firefox/downloadDir.sh
}

DIST=''
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help) print_help; exit 0;;
        -d|--dist) DIST=$2; break;;
        -a|--all) print_dists; exit 0;;
        *) echo "Unvalid parameter: $1"; exit 1;;
    esac
done

case $DIST in
    ubuntu) ubuntu_install;;
    arch) arch_install;;
    *) echo "Unvalid dist: $DIST"; exit 1;;
esac

exit 0

