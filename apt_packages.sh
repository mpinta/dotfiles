#!/bin/bash
declare -r apt="/usr/bin/apt"
declare -r sudo="/usr/bin/sudo"

$sudo $apt install git vim tmux openvpn transmission virtualbox screenfetch gnome-tweak-tool jq libxml2-utils -y