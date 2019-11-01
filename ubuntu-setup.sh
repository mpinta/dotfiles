#!/bin/bash
sudo apt update && sudo apt upgrade -y

apt_packages
snap_packages
firefox_addons
gnome_extensions
icon_packs
setup_directories
setup_git
setup_theme
setup_icons
remove_apt_packages

apt_packages{
  sudo apt install vim tmux virtualbox qbittorrent gnome-tweak-tool screenfetch openvpn jq libxml2-utils -y
}

snap_packages {
  sudo snap install spotify discord vlc -y
  sudo snap install code --classic -y
}

firefox_addons {
  declare -r PATH="/usr/lib/firefox/distribution/extensions"
  declare -r DOWNLOAD="https://addons.mozilla.org/firefox/downloads/file"
  declare -r -a URLS=(
    "https://addons.mozilla.org/en-US/firefox/addon/https-everywhere"
    "https://addons.mozilla.org/sl/firefox/addon/lastpass-password-manager"
    "https://addons.mozilla.org/sl/firefox/addon/simple-translate"
    "https://addons.mozilla.org/sl/firefox/addon/ublock-origin"
  )

  for i in "${URLS[@]}"
    do
    sudo wget -O /tmp/index.html $i
    JSON=$(xmllint --html --xpath '//body//script/text()' /tmp/index.html)
    VERSION=$(jq -r '.versions.byId[].platformFiles.all.id' <<< $JSON)

    sudo wget -0 /tmp/temp.zip $DOWNLOAD/$VERSION
    sudo unzip -d /tmp/temp /tmp/temp.zip
    ID=$(jq -r '.applications.gecko.id' /tmp/temp/manifest.json)

    if [ $ID = "null" ]; then
        ID=$(jq -r '.browser_specific_settings.gecko.id' /tmp/temp/manifest.json)
    fi

    sudo mv /tmp/temp.zip $PATH/$ID.xpi
    sudo rm -r -f /tmp/index.html /tmp/temp
  done
}

gnome_extensions {
  declare -r PATH="/usr/share/gnome-shell/extensions"
  declare -r -a URLS=(
    "https://github.com/home-sweet-gnome/dash-to-panel.git"
    "https://github.com/gTile/gTile.git"
    "https://github.com/mrakow/gnome-shell-web-search-provider.git"
  )

  for i in "${URLS[@]}"
  do	
    sudo git clone $i $PATH/temp 
    UUID=$(jq -r '.uuid' $PATH/temp/metadata.json)
    sudo mv $PATH/temp $PATH/$UUID
  done
}

icon_packs {
  declare -r PATH="/usr/share/icons"
  declare -r URL="https://github.com/OrancheloTeam/oranchelo-icon-theme"

  sudo git clone $URL /tmp/temp
  sudo mv /tmp/temp/{Oranchelo,Oranchelo-Beka} $PATH
  sudo rm -r -f /tmp/temp
}

setup_directories {
  mkdir -p ~/Documents/{dev/{git-repos,local-repos},faks}
}

setup_git {
  git config --global user.name Matic Pintarič
  git config --global user.email matic.pintaric@outlook.com
}

setup_theme {
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
}

setup_icons {
  gsettings set org.gnome.desktop.interface icon-theme "Oranchelo-Beka"
}

remove_apt_packages {
  sudo apt remove jq libxml2-utils -y
}
