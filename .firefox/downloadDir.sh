#!/bin/bash

ROUTE="$HOME/.mozilla/firefox"
PROFILE=$(ls $ROUTE | grep 'default.*release')
VALUE1='user_pref("browser.download.folderList", 2);'
VALUE2='user_pref("browser.download.dir", '$HOME'/downloads)'
VALUE3='user_pref("browser.download.lastDir", '$HOME'/downloads)'

sed -i '/browser.download.folderList/d' $ROUTE/$PROFILE/prefs.js
sed -i '/browser.download.dir/d' $ROUTE/$PROFILE/prefs.js
sed -i '/browser.download.lastDir/d' $ROUTE/$PROFILE/prefs.js

echo $VALUE1 >> $ROUTE/$PROFILE/prefs.js
echo $VALUE2 >> $ROUTE/$PROFILE/prefs.js
echo $VALUE3 >> $ROUTE/$PROFILE/prefs.js

