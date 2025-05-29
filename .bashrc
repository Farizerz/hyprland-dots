#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

PS1=' \[\e[34m\]\[\e[0m\]\[\e[37;44m\]   \[\e[0m\]\[\e[34;47m\]\[\e[34;47m\] 󰋞 \w\[\e[0m\]\[\e[37m\]\[\e[34m\] \[\e[0m\]'

if [[ $((RANDOM % 30)) -eq 0 ]]; then
  pokemon-colorscripts -r -s --no-title
else
  pokemon-colorscripts -r --no-title
fi
