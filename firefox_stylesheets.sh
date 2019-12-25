#!/bin/bash
declare -r ls="/bin/ls"
declare -r cp="/bin/cp"
declare -r grep="/bin/grep"
declare -r echo="/bin/echo"
declare -r mkdir="/bin/mkdir"

declare -r PATH="$HOME/.mozilla/firefox"
declare -r VALUE='user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);'

PROFILE=$($ls $PATH | $grep 'default.*release')
$mkdir -p $PATH/$PROFILE/chrome
$cp userChrome.css -t "$PATH/$PROFILE/chrome"
$echo $VALUE >> $PATH/$PROFILE/prefs.js