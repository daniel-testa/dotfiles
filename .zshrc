export ZSH="/home/daniel/.oh-my-zsh"

ZSH_THEME="daniel2"

DISABLE_MAGIC_FUNCTIONS="true"

COMPLETION_WAITING_DOTS="true"

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.config/zsh/history

ZSH_CUSTOM=$XDG_CONFIG_HOME/zsh

plugins=(archlinux colorize)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH/oh-my-zsh.sh

# Alias
unalias l
alias rd="rm -Rfv" \
	alrc="$EDITOR ~/.config/alacritty/alacritty.yml" \
	aurupd="$AUR_HELPER -Syyuu" \
	aurinf="$AUR_HELPER -Si" \
	aurins="$AUR_HELPER -S" \
	aursea="$AUR_HELPER -Ss" \
	aurlis="$AUR_HELPER -Q" \
	ed="$EDITOR" \
	ff="$NAVEGADOR" \
        gdfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" \
	i3rc="$EDITOR ~/.config/i3/config" \
	leer="$LECTOR" \
	lss="exa" \
	ls="lss -lhF --group-directories-first --color-scale" \
	ll="ls -ag" \
	la="ls -ag@" \
	lsg="lss -ax --grid" \
	pacman="sudo pacman" \
	pupd="pacman -Syyuu" \
	pinf="pacman -Si" \
	pins="pacman -S" \
	psea="pacman -Ss" \
	plis="pacman -Q" \
	tree="exa -alFT" \
	vimrc="$EDITOR ~/.vimrc" \
	x="sxiv -f" \
	xmbrc="$EDITOR ~/.config/xmobar/xmobarrc" \
	xmrc="$EDITOR ~/.xmonad/xmonad.hs" \
	zrc="$EDITOR ~/.zshrc" \
	zshe="$EDITOR ~/.zshenv"
