#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias l='ls -lsha'
#PS1='[\u@\h \W]\$ '
PS1='\[\e[32m\][\u]\[\e[0m\] \W\$ '

#Línea para cambiar la resolución del monitor
#
#xrandr --newmode 1920x1080_60.00 173.00 1920 2048 2248 2576 1080 1083 1088 1220 -hsync +vsync && xrandr --addmode Virtual1 1920x1080_60.00 && xrandr --output Virtual1 --mode 1920x1080_60.00


export EDITOR='vim'
export NAVEGADOR='firefox'
export VISUAL='vim'
export TERMINAL='uxrvt'
export LECTOR='mupdf'
export ARCHIVOS='ranger'

# Alias
alias cat="cat" \
	 rd="rm -Rfv" \
	 pacman="sudo pacman" \
	 psyu="pacman -Syu" \
	 ls="ls -F --color=tty --group-directories-first" \
	 ed="$EDITOR" \
	 ff="$NAVEGADOR" \
	 leer="$LECTOR" \
	 x="sxiv -f" \
	 i3rc="$EDITOR ~/.config/i3/config" \
	 zrc="$EDITOR ~/.zshrc"\
         gdfiles="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"


# colores en less > y por lo tanto en man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'



# lfs 9.1 variables 12-4-20
export LFS='/mnt/lfs'
