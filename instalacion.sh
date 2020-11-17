#!/bin/bash

set -e

############ instalar paquetes desde repos oficiles
echo "... Instalando paquetes oficiales:"

sudo pacman -S --needed --noconfirm alacritty dmenu exa firefox-i18n-es-ar git gtop htop lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings man-db man-pages mlocate networkmanager nitrogen picom powerline powerline-vim rofi vim wget xmobar xmonad xmonad-contrib xorg-apps xorg-server xorg-xinit zathura zathura-pdf-mupdf zsh zsh-completions zsh-syntax-highlighting

## descomentar la sig. linea si se instala en virtualbox SO invitado
#sudo pacman -S --needed --noconfirm virtualbox-guest-utils


############ instalar yay-bin desde AUR

echo "... Instalando yay AUR helper: "

wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay-bin -O PKGBUILD
makepkg
sudo pacman -U yay-bin-10.1.0-1-x86_64.pkg.tar.zst


############ instalar paquetes desde AUR

echo "... Instalando paquetes de AUR:"

yay -S exa nerd-fonts-iosevka nerd-fonts-mononoki nerd-fonts-noto-sans-regular-complete nerd-fonts-terminus ttf-font-awesome


############# instalar Oh My ZSH!

echo "...Instalando oh-my-zsh:"

sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"


############ activar servicios systemd

echo "...Activando servicios:"

sudo systemctl enable lightdm.service NetwokManager

## descomentar la sig. linea si se instala en virtualbox SO invitado
#sudo systemctl enable vboxservice.service


############# copia de seguridad de dotfiles y evitar conflictos con 'git checkout'

echo "...Haciendo copia de seguridad de .bashrc y .zshrc:"

mkdir .backup
mv .zshrc .backup
mv .bashrc .backup


############# clonar  dotfiles  ##################

echo "...Clonando dotfiles desde github:"

alias gdfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

echo ".dotfiles">>.gitignore

git clone --bare https://github.com/daniel-testa/dotfiles.git $HOME/.dotfiles

gdfiles checkout

gdfiles config --local status.showUntrackedFiles no

############ reiniciar en login manager

reboot
