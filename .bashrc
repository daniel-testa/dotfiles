# ~/.bashrc
#  daniel testa 20-10-2020

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls -lsha'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[32m\][\u]\[\e[0m\] \W\$ '


export EDITOR='vim'
export NAVEGADOR='firefox'
export VISUAL='vim'
export TERMINAL='alacritty'
export LECTOR='mupdf'
export ARCHIVOS='ranger'

# Alias
alias cat="ccat" \
	 rd="rm -Rfv" \
	 pacman="sudo pacman" \
	 psyu="pacman -Syu" \
	 ls="exa -abghlS --group-directories-first --color-scale" \
	 ed="$EDITOR" \
	 ff="$NAVEGADOR" \
	 leer="$LECTOR" \
	 x="sxiv -f" \
	 i3rc="$EDITOR ~/.config/i3/config" \
	 xmrc="$EDITOR ~/.xmonad/xmonad.hs" \
	 zrc="$EDITOR ~/.zshrc" \
	 termrc="$EDITOR ~/.config/alacritty/alacritty.yml" \
         gdfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# colores en less > y por lo tanto en man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
