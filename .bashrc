#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# Sudo alias
alias sudo='sudo '
# Nvim alias
alias nv='nvim'

C1="\[\033[38;5;11m\]"
C2="\[\033[38;5;14m\]"
C3="\[\033[38;5;12m\]"
C4="\[\033[38;5;13m\]"
R="\[$(tput sgr0)\]"

PS1="$C1\u$R@$C2\h$R $C3\W$R $C4\$$R "

# Add .bin scripts to path
export PATH="$HOME/.bin:$PATH"

