# daniel testa 16-10-20
# Iniciar X automaticament al ingresar
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
