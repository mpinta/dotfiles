#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

GREEN="\[$(tput setaf 100)\]"
RESET="\[$(tput sgr0)\]"

PS1="$GREEN[$RESET\u@\h \W$GREEN]$RESET\$ "

