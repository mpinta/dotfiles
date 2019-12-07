#!/bin/bash
declare -r mv="/bin/mv"

declare -r jq="/usr/bin/jq"
declare -r git="/usr/bin/git"
declare -r sudo="/usr/bin/sudo"

declare -r PATH="/usr/share/gnome-shell/extensions"
declare -r -a EXTENSIONS=(
    "https://github.com/gTile/gTile.git"
    "https://github.com/mrakow/gnome-shell-web-search-provider.git"
)

for i in "${EXTENSIONS[@]}"
do	
    $git clone $i /tmp/temp 
    UUID=$($jq -r '.uuid' /tmp/temp/metadata.json)
    $sudo $mv /tmp/temp $PATH/$UUID
done