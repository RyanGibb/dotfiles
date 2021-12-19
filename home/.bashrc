
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

set -o vi

alias ls='ls -p --color=auto'
alias pls='sudo $(fc -ln -1)'
alias nv='nvim'
alias o='xdg-open'
alias se='sudoedit'
alias su='su -p'
PS1='\[\e[36m\]\u@\h:\W\[\e[0m\] $ '

## https://wiki.archlinux.org/title/fish#Modify_.bashrc_to_drop_into_fish
#if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" && -z ${BASH_EXECUTION_STRING} ]]
#then
#	exec fish
#fi

