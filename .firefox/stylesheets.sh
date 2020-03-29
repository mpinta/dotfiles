#!/bin/bash

ROUTE="$HOME/.mozilla/firefox"
PROFILE=$(ls $ROUTE | grep "default.*release")
VALUE='user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);'

mkdir -p $ROUTE/$PROFILE/chrome
cp userChrome.css -t "$ROUTE/$PROFILE/chrome"
echo $VALUE >> $ROUTE/$PROFILE/prefs.js