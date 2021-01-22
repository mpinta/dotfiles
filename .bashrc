#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

Y="\[\033[38;5;11m\]"
C="\[\033[38;5;14m\]"
B="\[\033[38;5;12m\]"
P="\[\033[38;5;13m\]"
R="\[$(tput sgr0)\]"

PS1="$Y\u$R@$C\h$R $B\W$R $P\$$R "

# Add .bin scripts to path
export PATH="$HOME/.bin:$PATH"

