# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┒
# ┃ ___   _____ __ __ __ _____ __     ______ _____ _____ ______ _____ ┃
# ┃|    \|  _  |   \ |__|   __|  |   |      |   __|   __|      |  _  |┃
# ┃| |   |     |     |  |   __|  --; '_    _'   __|__   '_    _'     |┃
# ┃|____/|__|__|__\__|__|_____|____|   |__| |_____|_____| |__| |__|__|┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃daniel.testa.t@gmail.com 09.12.2020                                ┃
# ┃extraído de arch: extra/pkgfile(command-not-found.zsh), modificado ┃
# ┃mínimamente, salida a terminal  con color y subrayado.             ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

command_not_found_handler() {
	local pkgs cmd="$1"

	pkgs=(${(f)"$(pkgfile -b -v -- "$cmd" 2>/dev/null)"})
	if [[ -n "$pkgs" ]]; then
		print -P "%U%F{blue}$cmd%u%f%s puede encontrarse en los siguientes paquetes:"
		print -f " %s\n" $pkgs[@]
	else
		print -f "zsh: commando no encontrado: %s"
		print -P "%U%F{red}$cmd%u%f"
	fi 1>&2
	return 127
}
