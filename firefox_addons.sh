#!/bin/bash
declare -r mv="/bin/mv"
declare -r rm="/bin/rm"

declare -r jq="/usr/bin/jq"
declare -r sudo="/usr/bin/sudo"
declare -r wget="/usr/bin/wget"
declare -r unzip="/usr/bin/unzip"
declare -r xmllint="/usr/bin/xmllint"

declare -r PATH="/usr/lib/firefox/distribution/extensions"
declare -r DOWNLOAD_URL="https://addons.mozilla.org/firefox/downloads/file"
declare -r -a ADDONS=(
    "https://addons.mozilla.org/en-US/firefox/addon/https-everywhere"
    "https://addons.mozilla.org/en-US/firefox/addon/lastpass-password-manager"
    "https://addons.mozilla.org/en-US/firefox/addon/simple-translate"
    "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin"
)

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