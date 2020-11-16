# daniel testa 16-10-20
# Iniciar X automaticament al ingresar
# desabilitado en pc de escritorio uso sddm
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx


export EDITOR='vim'
export NAVEGADOR='firefox'
export BROWSER='firefox'
export VISUAL='vim'
#export TERM='xterm-256color'
export TERMINAL='alacritty'
export LECTOR='mupdf'
export ARCHIVOS='ranger'

# variables XDG para direccionar dotfiles a ~/.config
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# limpiando ~ de dotfiles
export LESSHISTFILE='-'
export GTK2_RC_FILES=$XDG_CONFIG_HOME/gtk-2.0/gtkrc


# colores en less > y por lo tanto en man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
