#!/bin/bash
declare -r bash="/bin/bash"
declare -r echo="/bin/echo"

TEMP=`getopt help ubuntu kdeneon -- '' "$@"`
USAGE="
Usage:\n
    [--ubuntu] for Ubuntu setup\n
    [--kdeneon] for KDE neon setup
"

case "$1" in
    --ubuntu) 
        $bash apt_update_upgrade.sh
        $bash apt_packages.sh
        $bash ubuntu_docker.sh
        $bash snap_packages.sh
        $bash firefox_addons.sh
        $bash firefox_stylesheets.sh
        $bash gnome_extensions.sh
        $bash gnome_icons.sh
        $bash directories.sh
        $bash git.sh
        $bash vim.sh
        $bash tmux.sh
        $bash apt_packages_remove.sh
    ;;
    --kdeneon)
        # TODO
    ;;
    --usage)
        $echo -e $USAGE
    ;;
    *)
        $echo -e $USAGE
    ;;
esac
