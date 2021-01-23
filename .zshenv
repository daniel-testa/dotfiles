# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┒
# ┃ ___   _____ __ __ __ _____ __     ______ _____ _____ ______ _____ ┃
# ┃|    \|  _  |   \ |__|   __|  |   |      |   __|   __|      |  _  |┃
# ┃| |   |     |     |  |   __|  --; '_    _'   __|__   '_    _'     |┃
# ┃|____/|__|__|__\__|__|_____|____|   |__| |_____|_____| |__| |__|__|┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃daniel.testa.t@gmail.com 16.10.2020                                ┃
# ┃extraído de arch: extra/pkgfile(command-not-found.zsh), modificado ┃
# ┃mínimamente, salida a terminal  con color y subrayado.             ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

# variables XDG para direccionar dotfiles a ~/.config
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

# limpiando ~ de dotfiles
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export LESSHISTFILE='-'
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | so $MYVIMRC'
export EDITOR='vim'
export VISUAL='vim'
export MANPAGER='vim -M +MANPAGER -'
export PAGER='/usr/share/vim/vim82/macros/less.sh'

export ARCHIVOS='ranger'
export AUR_HELPER='paru'
export BROWSER='firefox'
export READER='zhatura'
export NAVEGADOR='firefox'
export TERMINAL='alacritty'

# zsh  ***
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="$ZDOTDIR/history"      # archivo historia de comandos
export HISTSIZE=10000                   # maximo cantidad de eventos historia interna
export SAVEHIST=10000                   # maxima cantidad de eventos en el archivo history

#export LOCAL_BIN="$HOME/.local/bin"
#export PATH="LOCAL_BIN:$PATH"


# colores en less > y por lo tanto en man
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## iconos para el administrador de archivos 'lf'
export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.a=:\
*.o=:\
*.so=:\
*.c=ﭰ:\
*.cc=ﭱ:\
*.clj=:\
*.coffee=:\
*.cpp=ﭱ:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=ﭰ:\
*.hh=ﭱ:\
*.hpp=ﭱ:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.arc=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.zip=:\
*.z=:\
*.gz=:\
*.xz=:\
*.zst=:\
*.bz2=:\
*.bz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.rar=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

##### http://www.bigsoft.co.uk/blog/2008/04/11/configuring-ls_colors
#
#no......NORMAL, NORM 	Global default, although everything should be something
#fi......FILE 	Normal file
#di......DIR 	Directory
#ln......SYMLINK, LINK, LNK 	Symbolic link. If you set this to 'target'
#        instead of a numerical value, the colour is as for the file pointed to.
#pi......FIFO, PIPE 	Named pipe
#do......DOOR 	Door
#bd......BLOCK, BLK 	Block device
#cd......CHAR, CHR 	Character device
#or......ORPHAN 	Symbolic link pointing to a non-existent file
#so......SOCK 	Socket
#su......SETUID 	File that is setuid (u+s)
#sg......SETGID 	File that is setgid (g+s)
#tw......STICKY_OTHER_WRITABLE 	Directory that is sticky and other-writable (+t,o+w)
#ow......OTHER_WRITABLE 	Directory that is other-writable (o+w) and not sticky
#st......STICKY 	Directory with the sticky bit set (+t) and not other-writable
#ex......EXEC 	Executable file (i.e. has 'x' set in permissions)
#mi......MISSING 	Non-existent file pointed to by a symbolic link (visible when you type ls -l)
#lc......LEFTCODE, LEFT 	Opening terminal code
#rc......RIGHTCODE, RIGHT 	Closing terminal code
#ec......ENDCODE, END 	Non-filename text
#*.ext......Every file using this extension e.g. *.jpg 
