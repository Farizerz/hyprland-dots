#
# ~/.bashrc
#

# If not running interactively, don't do anything

export SUDO_EDITOR="nvim"

[[ $- != *i* ]] && return

# PS1='[\u@\h \W]\$ '

PS1='\[\e[34m\]\[\e[0m\]\[\e[37;44m\] \u \[\e[0m\]\[\e[34;47m\]\e[34;47m\] 󰋞 \w\[\e[0m\]\[\e[37m\]\[\e[34m\] \[\e[0m\]'

if [[ $((RANDOM % 30)) -eq 0 ]]; then
  pokemon-colorscripts -r -s --no-title
else
  pokemon-colorscripts -r --no-title
fi

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ipconfig='ip addr show'
alias reboot-windows='sudo efibootmgr --bootnext 0000 && reboot'
alias execute-scripts='~/.config/scripts/system/execute-scripts.sh'
alias neofetch='fastfetch'

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

dlp() {
  yt-dlp -P ~/Videos "$@"
}
