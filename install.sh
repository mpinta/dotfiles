#!/bin/bash

config_setup() {
    mkdir -p $HOME/.config/ && cp -r .config/* -t $HOME/.config/
}

xorg_setup() {
    sudo mkdir -p /etc/X11/xorg.conf.d/ && cp -r .xorg/* -t /etc/X11/xorg.conf.d/
}

modprobe_setup() {
    sudo mkdir -p /etc/modprobe.d/ && cp -r .modprobe.d/* -r /etc/modprobe.d/
}

bin_setup() {
    mkdir -p $HOME/.bin/ && cp -r .bin/* -t $HOME/.bin/
}

xinit_setup() {
    cp .xinitrc -t $HOME/
}

zsh_setup() {
    cp .zsh/* -t $HOME/
}

bash_setup() {
    cp .bash/* -t $HOME/
}

tmux_setup() {
    cp .tmux.conf -t $HOME/
}

git_setup() {
    cp .gitconfig -t $HOME/
}

install() {
    # pacman packages
    sudo pacman -S networkmanager xorg-server xorg-xinit i3-gaps i3status i3lock i3lock-color rxvt-unidode dmenu --noconfirm
    sudo pacman -S kitty ranger git vim unzip tar --noconfirm
    sudo pacman -S mesa xrandr pulseaudio pavucontrol playerctl bluez bluez-utils compton redshift feh flameshot scrot --noconfirm
    sudo pacman -S firefox vlc transmission-cli --noconfirm
    # fonts
    sudo pacman -S noto-fonts
    sudo pacman -S ttf-fira-code
    sudo pacman -S ttf-font-awesome otf-font-awesome
    sudo pacman -S ttf-font-awesome-4 otf-font-awesome-4
    # xinit
    xinit_setup
    # config
    config_setup
    # xorg
    xorg_setup
    # modprobe
    modprobe_setup
    # bin
    bin_setup
    # git
    git_setup
    # zsh
    zsh_setup
    # tmux
    tmux_setup
}

install

