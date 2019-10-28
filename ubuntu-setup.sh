#!/bin/bash
sudo apt update && sudo apt upgrade -y

# Install apt packages
sudo apt install vim tmux virtualbox qbittorrent gnome-tweak-tool screenfetch jq -y

# Install snap packages
sudo snap install spotify discord vlc -y
sudo snap install code --classic -y

# Setup git
git config --global user.name Matic Pintarič
git config --global user.email matic.pintaric@outlook.com

# Create default directories
mkdir -p ~/Documents/{dev/{git-repos,local-repos},faks}

# Install gnome extensions
declare -r EXTENSIONS_PATH="/usr/share/gnome-shell/extensions"
declare -r -a EXTENSIONS_URLS=(
  "https://github.com/home-sweet-gnome/dash-to-panel.git"
  "https://github.com/gTile/gTile.git"
  "https://github.com/mrakow/gnome-shell-web-search-provider.git"
)

for i in "${EXTENSIONS_URLS[@]}"
do	
  sudo git clone $i $EXTENSIONS_PATH/temp 
  UUID=$(jq -r '.uuid' $EXTENSIONS_PATH/temp/metadata.json)
  sudo mv $EXTENSIONS_PATH/temp $EXTENSIONS_PATH/$UUID
done

# Install icon packs
declare -r icons_path="/usr/share/icons"
declare -r icons_url="https://github.com/OrancheloTeam/oranchelo-icon-theme"

sudo git clone $icons_url $icons_path/temp
sudo mv $icons_path/temp/{Oranchelo,Oranchelo-Beka} $icons_path
sudo rm -r -f $icons_path/temp

# Setup theme and icons
gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"
gsettings set org.gnome.desktop.interface icon-theme "Oranchelo-Beka"
