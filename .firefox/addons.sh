#!/bin/bash

ROUTE="$HOME/.mozilla/firefox"
PROFILE=$(ls $ROUTE | grep 'default.*release')
URL='https://addons.mozilla.org/firefox/downloads/file/'
declare -a ADDONS=(
    'https://addons.mozilla.org/en-US/firefox/addon/lastpass-password-manager/'
    'https://addons.mozilla.org/en-US/firefox/addon/simple-translate/'
    'https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/'
    'https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/'
)

for i in "${ADDONS[@]}"
    do
    wget -O /tmp/index.html $i
    JSON=$(xmllint --html --xpath '//body//script/text()' /tmp/index.html)
    JSON=${JSON:9:-18}
    VERSION=$(jq -r '.versions.byId[].platformFiles.all.id' <<< $JSON)
    wget -O /tmp/temp.zip $URL/$VERSION
    unzip -d /tmp/temp /tmp/temp.zip
    ID=$(jq -r '.applications.gecko.id' /tmp/temp/manifest.json)
    
    if [ $ID = "null" ]; then
        ID=$(jq -r '.browser_specific_settings.gecko.id' /tmp/temp/manifest.json)
    fi
    
    sudo mv /tmp/temp.zip $ROUTE/$PROFILE/extensions/$ID.xpi
    rm -r -f /tmp/index.html /tmp/temp
done

