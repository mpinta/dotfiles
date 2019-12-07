#!/bin/bash
declare -r sudo="/usr/bin/sudo"
declare -r snap="/usr/bin/snap"

$sudo $snap install spotify discord vlc
$sudo $snap install code --classic