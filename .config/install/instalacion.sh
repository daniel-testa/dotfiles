#!/bin/bash

set -e

############ instalar paquetes desde repos oficiles
echo "... Instalando paquetes oficiales:"
sleep 1

sudo pacman -Syyuu --needed --noconfirm alacritty dmenu exa  ttf-ubuntu-font-family \
	firefox-i18n-es-ar git gtop htop lightdm lightdm-gtk-greeter \
	lightdm-gtk-greeter-settings man-db man-pages mlocate networkmanager nitrogen \
	picom powerline powerline-vim rofi vim wget xmobar xmonad xmonad-contrib \
	xorg-apps xorg-server xorg-xinit zathura zathura-pdf-mupdf zsh zsh-completions \
	zsh-syntax-highlighting

## descomentar la sig. linea si se instala en virtualbox SO invitado
sudo pacman -S --needed --noconfirm virtualbox-guest-utils

echo "...paquetes oficiales instalados"
sleep 1

############ instalar yay-bin desde AUR

echo "... Instalando yay-bin:"

sleep 1

mkdir tmp_paru && \
       	cd tmp_paru && \
	wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=paru-bin -O PKGBUILD && \
	makepkg -i --noconfirm --needed && \
	cd .. && \
	sudo rm -rf tmp_paru

############ instalar paquetes desde AUR

echo "... Instalando paquetes de AUR:"
sleep 1

paru -Syu -q --nocleanmenu --nodiffmenu --noupgrademenu --noeditmenu --noconfirm --needed exa nerd-fonts-iosevka nerd-fonts-mononoki nerd-fonts-noto-sans-regular-complete nerd-fonts-terminus ttf-font-awesome vundle


echo "...paquetes AUR instalados"
sleep 1

############# eliminar dotfiles viejos o del sistema
mkdir $HOME/backup 
mv $HOME/.config $HOME/.xmonad $HOME/.oh-my.zsh $HOME/fondos $HOME/.dotfiles .bashrc .zshrc .zshenv .Xauthority .xinitrc .vimrc $HOME/backup

############# clonar  dotfiles  ##################

echo "...clonando dotfiles desde github:"

sleep 1

git clone --bare https://github.com/daniel-testa/dotfiles.git $HOME/.dotfiles

function gdfiles {
	   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
   }

gdfiles checkout

echo "...checkout correcto:"

sleep 2

echo ".dotfiles">>.gitignore
gdfiles config --local status.showUntrackedFiles no

echo "...dotfiles clonados desde github!"
sleep 1

############# instalar Oh My ZSH!

echo "...descargando instalador de oh_my_zsh!:"
sleep 1

wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output-document=ohmyzsh_install.sh

echo "...configurando oh_my_zsh! para usar .zshrc propio:"

sleep 2

sed -i 's/RUNZSH=${RUNZSH:-yes}/RUNZSH=${RUNZSH:-no}/g' ohmyzsh_install.sh
sed -i 's/CHSH=${CHSH:-yes}/CHSH=${CHSH:-no}/g' ohmyzsh_install.sh
sed -i 's/KEEP_ZSHRC=${KEEP_ZSHRC:-no}/KEEP_ZSHRC=${KEEP_ZSHRC:-yes}/g' ohmyzsh_install.sh

echo "...instalando oh_my_zsh!:"

sleep 2

sh ohmyzsh_install.sh

rm ohmyzsh_install.sh

############ activar servicios systemd

echo "...Activando servicios:"
sleep 1

## descomentar la sig. linea si se instala en virtualbox SO invitado
sudo systemctl enable vboxservice.service &&\
sudo systemctl start vboxservice.service

sudo systemctl enable NetworkManager.service
sudo systemctl enable lightdm.service

############ reiniciar en login manager

echo "...reiniciando"
sleep 2

reboot
