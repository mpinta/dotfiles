#!/bin/bash
declare -r mv="/bin/mv"
declare -r rm="/bin/rm"

declare -r git="/usr/bin/git"
declare -r sudo="/usr/bin/sudo"

declare -r PATH="/usr/share/icons"
declare -r -a ICONS=(
    "https://github.com/OrancheloTeam/oranchelo-icon-theme"
)

for i in "${ICONS[@]}"
do	
    $git clone $i /tmp/temp
    $sudo $mv /tmp/temp/*/ $PATH
    $rm -r -f /tmp/temp
done