#
# ~/.bashrc
#

[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias sudo='sudo '
alias nv='nvim'

C1="\[\033[38;5;11m\]"
C2="\[\033[38;5;14m\]"
C3="\[\033[38;5;12m\]"
C4="\[\033[38;5;13m\]"
R="\[$(tput sgr0)\]"

PS1="$C1\u$R@$C2\h$R $C3\W$R $C4\$$R "

export LANG=en_IN.UTF-8

