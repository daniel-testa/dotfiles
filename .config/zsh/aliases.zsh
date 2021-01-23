alias -g ...=../.. \
         ....=../../.. \
         .....=../../../.. \
         ......=../../../../..

alias -- -='cd -'
        
for index ({1..9}) alias "$index"="cd +${index}"; unset  index # pila de directorios

alias diff='diff --color' \
        grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}' \
        egrep='egrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}' \
        fgrep='fgrep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox}'

alias alrc='$EDITOR $XDG_CONFIG_HOME/alacritty/alacritty.yml' \
	 i3rc='$EDITOR $XDG_CONFIG_HOME/i3/config' \
	 vimrc='$EDITOR $XDG_CONFIG_HOME/vim/vimrc' \
	 xdrc='$EDITOR $XDG_CONFIG_HOME/xmobar/xmobarrc' \
	 xmrc='$EDITOR $HOME/.xmonad/xmonad.hs' \
	 zrc='$EDITOR $ZDOTDIR/.zshrc' \
	 zshe='$EDITOR $HOME/.zshenv'

alias pacman='sudo pacman' \
	 painf='pacman -Si' \
	 pains='pacman -S' \
	 palis='pacman -Q' \
	 pasea='pacman -Ss' \
	 paupd='pacman -Syyuu' \
     pauerfanos='pacman -Qtdq' \
	 aurinf='$AUR_HELPER -Si' \
	 aurins='$AUR_HELPER -S' \
	 aurlis='$AUR_HELPER -Q' \
	 aursea='$AUR_HELPER -Ss' \
	 aurupd='$AUR_HELPER  -Syyuu --aur'
     
alias ccat='pygmentize -g' \
     gdfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' \
	 l='exa --group-directories-first' \
     la='exa -a --group-directories-first' \
     ls='exa -alhF --group-directories-first --color-scale' \
     ll='exa -aaghFl --group-directories-first --color-scale'\
     les='$PAGER' \
     md='mkdir -pv' \
     rd='rm -Rfv' \
     df='df -h' \
     du='du -h' \
     v='$EDITOR' \
     x='sxiv -f' \
     z='zathura'

# Alias sufijo
alias -s html=firefox \
        org=firefox \
        com=firefox \
        com.ar=firefox \
        pdf=zathura \
        zsh=vim \
        zsh=mom \
        zsh=ms \
        txt=vim
