#
# ~/.bashrc
#

# If not running interactively, don't do anything

export SUDO_EDITOR="nvim"

[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

PS1='\[\e[36m\]\[\e[0m\]\[\e[37;46m\]   \[\e[0m\]\[\e[36;47m\]\[\e[36;47m\] 󰋞 \w\[\e[0m\]\[\e[37m\]\[\e[36m\] \[\e[0m\]'

if [[ $((RANDOM % 30)) -eq 0 ]]; then
  pokemon-colorscripts -r -s --no-title
else
  pokemon-colorscripts -r --no-title
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ipconfig='ip addr show'
alias rebootwindows='sudo efibootmgr --bootnext 0000 && reboot'

add() {
  sudo pacman -S "$@" --noconfirm
}

remove() {
  sudo pacman -Rns "$@"
}

update() {
  sudo pacman -Syu --noconfirm
}

addy() {
  yay -S "$@" --noconfirm
}

removey() {
  yay -Rns "$@"
}

updatey() {
  yay -Syu --noconfirm
}
