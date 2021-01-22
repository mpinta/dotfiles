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
    mkdir -p $HOME/.config/ && cp -r .config/* -t $HOME/.config/
}

xorg_setup() {
    sudo mkdir -p /etc/X11/xorg.conf.d/ && cp -r .xorg/* -t /etc/X11/xorg.conf.d/
}

bin_setup() {
    mkdir -p $HOME/.bin/ && cp -r .bin/* -t $HOME/.bin/
}

xinit_setup() {
    cp .xinitrc -t $HOME/
}

bash_profile_setup() {
    cp .bash_profile -t $HOME/
}

vim_setup() {
    cp .vimrc -t $HOME/
    # create undodir
    mkdir -p $HOME/.vim/undodir/
}

tmux_setup() {
    cp .tmux.conf -t $HOME/
}

firefox_setup() { 
    ./.firefox/addons.sh
    ./.firefox/stylesheets.sh 
}

fonts_setup() {
    ./.fonts/jetbrains.sh
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
    sudo apt install git vim tmux transmission virtualbox gnome-tweak-tool -y
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
    # add helpers
    sudo pacman -S wget jq libxml2
    # pacman packages
    sudo pacman -S networkmanager xorg-server xorg-xinit i3-gaps i3status i3lock i3lock-color rxvt-unidode dmenu --noconfirm
    sudo pacman -S kitty ranger git vim unzip tar --noconfirm
    sudo pacman -S mesa xrandr pulseaudio pavucontrol playerctl bluez bluez-utils compton redshift feh flameshot scrot --noconfirm
    sudo pacman -S firefox vlc transmission-cli --noconfirm
    # fonts
    sudo pacman -S noto-fonts
    sudo pacman -S ttf-font-awesome otf-font-awesome
    sudo pacman -S ttf-font-awesome-4 otf-font-awesome-4
    fonts_setup
    # xinit
    xinit_setup
    # bash profile
    bash_profile_setup
    # .config
    config_setup
    # xorg
    xorg_setup
    # .bin
    bin_setup
    # git
    git_setup
    # vim
    vim_setup
    # default directories
    mkdir -p $HOME/{dev,downloads,faks,pictures}
    # firefox setup
    firefox_setup 
    ./.firefox/downloadDir.sh
    # remove helpers
    sudo pacman -Rns wget jq libxml2
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

