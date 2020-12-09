#!/usr/bin/env bash
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┒
# ┃ ___   _____ __ __ __ _____ __     ______ _____ _____ ______ _____ ┃
# ┃|    \|  _  |   \ |__|   __|  |   |      |   __|   __|      |  _  |┃
# ┃| |   |     |     |  |   __|  --; '_    _'   __|__   '_    _'     |┃
# ┃|____/|__|__|__\__|__|_____|____|   |__| |_____|_____| |__| |__|__|┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃daniel.testa.t@gmail.com 25.11.2020                                ┃
# ┃Simple script de instalación de servidor grafico, programas básicos┃
# ┃windows manager(xmonad) y copia de mis dotfiles del repositorio en ┃
# ┃Github.                                                            ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

set -e

ROJO='\033[1;31m'
AZUL='\033[0;34m'
VERDE='\033[1;32m'
BLANCO='\033[1;37m'
SIN_COLOR='\033[0m'

############ instalar paquetes desde repos oficiles
printf "${AZUL} Instalando paquetes oficiales...${SIN_COLOR}\n\n"

sudo pacman -Syyuu --needed --noconfirm alacritty dmenu exa  ttf-ubuntu-font-family \
	firefox-i18n-es-ar git gtop htop lightdm lightdm-gtk-greeter \
	lightdm-gtk-greeter-settings man-db man-pages mlocate networkmanager nitrogen \
	picom python-pygments powerline powerline-vim rofi rsync vim wget xmobar xmonad xmonad-contrib \
	xorg-apps xorg-server xorg-xinit zathura zathura-pdf-mupdf zsh zsh-completions \
	zsh-syntax-highlighting virtualbox-guest-utils && \
	printf "${VERDE} Paquetes oficiales instalados...${SIN_COLOR}\n\n"
sleep 1

############ instalar yay-bin desde AUR

printf "${AZUL} Instalando paru-bin...${SIN_COLOR}\n\n"

sleep 1

mkdir tmp_paru && \
       	cd tmp_paru && \
	wget https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=paru-bin -O PKGBUILD && \
	makepkg -i --noconfirm --needed && \
	cd .. && \
	sudo rm -rf tmp_paru && \
	printf "${VERDE} paru AUR helper instalado...${SIN_COLOR}\n\n"

############ instalar paquetes desde AUR

printf "${AZUL} Instalando paquetes de AUR...${SIN_COLOR}\n\n"
sleep 1

paru -Syu --quiet --cleanafter --nouseask --noconfirm --needed exa nerd-fonts-iosevka nerd-fonts-mononoki \
	nerd-fonts-noto-sans-regular-complete nerd-fonts-terminus ttf-font-awesome \
       	vim-colorschemes vundle && \
	printf "${VERDE} Paquetes AUR instalados.${SIN_COLOR}\n\n"

sleep 1

############# clonar  dotfiles  ##################

printf "${AZUL}Clonando dotfiles desde github...${SIN_COLOR}\n"
sleep 1

git clone --bare https://github.com/daniel-testa/dotfiles.git $HOME/.dotfiles
if [[ $? == 0 ]]
then
        printf "\n${VERDE}Clonacion correcta!!${SIN_COLOR}\n\n"
fi

function gdfiles {
        /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
printf "${AZUL}Checkingout dotfiles...${SIN_COLOR}\n\n"
mkdir -p bkp
#gdfiles checkout    # para corregir, incluir comando en loops if, while, listas && ||, siempre que no sea
                     # el último comando de la lista

if [[ $(gdfiles checkout) == 0 ]]     # intento de corregir problema con set -e detiene el script con este error
then
        printf "${VERDE}Checkout correcto!!${SIN_COLOR}\n" && \
		rm -rf bkp
else
        printf " \n${ROJO}Atención!.. en el sistema hay archivos de configuracion previos!!${SIN_COLOR}\n"
        printf " \n${AZUL}Haciendo copia de seguridad de dot files preexistentes...${SIN_COLOR}\n"
        printf "${BLANCO}%s${SIN_COLOR}\n" "."
        printf "${BLANCO}%s${SIN_COLOR}\n" "."
        sleep 2
        gdfiles checkout 2>&1 | egrep "\s+\.|\/" | awk '{print $1}' | xargs -I '{}' rsync -a '{}' bkp/ && \
        gdfiles checkout 2>&1 | egrep "\s+\.|\/" | awk '{print $1}' | xargs -I '{}' rm -rf '{}'
        
        if [[ $? == 0 ]]
        then
                printf "${VERDE}Se hizo copia de dotfiles preexistentes en la carpeta ${AZUL}$PWD/bkp ${SIN_COLOR}\n\n"
                sleep 3
                printf "${AZUL}Checkingout dotfiles...${SIN_COLOR}\n\n"

        gdfiles checkout && \
                printf "${VERDE}Checkout correcto!!${SIN_COLOR}\n"
        fi
fi

############# instalar Oh My ZSH!

printf "${AZUL} Descargando script instalador de oh_my_zsh!...${SIN_COLOR}\n\n"
sleep 1

wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output-document=ohmyzsh_install.sh && \
	printf "${VERDE} Descarga correcta${SIN_COLOR}\n\n"

printf "${AZUL} Aplicando patch a script de oh_my_zsh! para evitar la sobreescritura de .zshrc${SIN_COLOR}\n\n"
sleep 2

sed -i 's/RUNZSH=${RUNZSH:-yes}/RUNZSH=${RUNZSH:-no}/g' ohmyzsh_install.sh
sed -i 's/CHSH=${CHSH:-yes}/CHSH=${CHSH:-no}/g' ohmyzsh_install.sh
sed -i 's/KEEP_ZSHRC=${KEEP_ZSHRC:-no}/KEEP_ZSHRC=${KEEP_ZSHRC:-yes}/g' ohmyzsh_install.sh

printf "${AZUL} Instalando oh_my_zsh!...${SIN_COLOR}\n\n"
sleep 2

sh ohmyzsh_install.sh && \
	printf "${VERDE} Oh_my_zsh! instacilado!${SIN_COLOR}\n\n"

rm ohmyzsh_install.sh

############ activar servicios systemd

printf "${AZUL} Activando Servicios${SIN_COLOR}\n\n"
sleep 2

## descomentar la sig. linea si se instala en virtualbox SO invitado
sudo systemctl enable vboxservice.service &&\
sudo systemctl start vboxservice.service

sudo systemctl enable NetworkManager.service
sudo systemctl enable lightdm.service

############ reiniciar en login manager

printf "${AZUL} REINICIANDO!${SIN_COLOR}\n\n"
sleep 2

reboot
