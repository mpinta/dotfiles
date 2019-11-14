#!/bin/bash
declare -r mv="/bin/mv"
declare -r rm="/bin/rm"
declare -r mkdir="/bin/mkdir"

declare -r sudo="/usr/bin/sudo"
declare -r apt="/usr/bin/apt"
declare -r snap="/usr/bin/snap"
declare -r wget="/usr/bin/wget"
declare -r unzip="/usr/bin/unzip"
declare -r git="/usr/bin/git"
declare -r jq="/usr/bin/jq"
declare -r xmllint="/usr/bin/xmllint"

declare -r -a ADDONS=(
  "https://addons.mozilla.org/en-US/firefox/addon/https-everywhere"
  "https://addons.mozilla.org/en-US/firefox/addon/lastpass-password-manager"
  "https://addons.mozilla.org/en-US/firefox/addon/simple-translate"
  "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin"
)

declare -r -a EXTENSIONS=(
  "https://github.com/home-sweet-gnome/dash-to-panel.git"
  "https://github.com/gTile/gTile.git"
  "https://github.com/mrakow/gnome-shell-web-search-provider.git"
)

declare -r -a ICONS=(
  "https://github.com/OrancheloTeam/oranchelo-icon-theme"
  "https://github.com/bikass/korla"
)

get_apt_packages(){
  $sudo $apt install git vim tmux openvpn transmission virtualbox screenfetch gnome-tweak-tool jq libxml2-utils -y
}

get_snap_packages(){
  $sudo $snap install spotify discord vlc
  $sudo $snap install code --classic
}

get_firefox_addons(){
  declare -r PATH="/usr/lib/firefox/distribution/extensions"
  declare -r DOWNLOAD_URL="https://addons.mozilla.org/firefox/downloads/file"

  for i in "${ADDONS[@]}"
    do
    $wget -O /tmp/index.html $i
    JSON=$($xmllint --html --xpath '//body//script/text()' /tmp/index.html)
    VERSION=$($jq -r '.versions.byId[].platformFiles.all.id' <<< $JSON)

    $wget -O /tmp/temp.zip $DOWNLOAD_URL/$VERSION
    $unzip -d /tmp/temp /tmp/temp.zip
    ID=$($jq -r '.applications.gecko.id' /tmp/temp/manifest.json)

    if [ $ID = "null" ]; then
        ID=$($jq -r '.browser_specific_settings.gecko.id' /tmp/temp/manifest.json)
    fi

    $sudo $mv /tmp/temp.zip $PATH/$ID.xpi
    $rm -r -f /tmp/index.html /tmp/temp
  done
}

get_gnome_extensions(){
  declare -r PATH="/usr/share/gnome-shell/extensions"

  for i in "${EXTENSIONS[@]}"
  do	
    $git clone $i /tmp/temp 
    UUID=$($jq -r '.uuid' /tmp/temp/metadata.json)
    $sudo $mv /tmp/temp $PATH/$UUID
  done
}

get_icon_packs(){
  declare -r PATH="/usr/share/icons"

  for i in "${ICONS[@]}"
  do	
    $git clone $i /tmp/temp
    $sudo $mv /tmp/temp/*/ $PATH
    $rm -r -f /tmp/temp
  done
}

set_directories(){
  $mkdir -p ~/Documents/{dev/{git-repos,local-repos},faks}
}

set_git(){
  $git config --global user.name "Matic Pintarič"
  $git config --global user.email matic.pintaric@outlook.com
}

remove_apt_packages(){
  $sudo $apt remove jq libxml2-utils -y
}

$sudo $apt update && sudo apt upgrade -y

get_apt_packages
get_snap_packages
get_firefox_addons
get_gnome_extensions
get_icon_packs
set_directories
set_git
set_theme
remove_apt_packages
