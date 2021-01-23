# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃ ___   _____ __ __ __ _____ __     ______ _____ _____ ______ _____ ┃
# ┃|    \|  _  |   \ |__|   __|  |   |      |   __|   __|      |  _  |┃
# ┃| |   |     |     |  |   __|  --; '_    _'   __|__   '_    _'     |┃
# ┃|____/|__|__|__\__|__|_____|____|   |__| |_____|_____| |__| |__|__|┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃  daniel.testa.t@gmail.com                                         ┃
# ┃  basado fundamentalmente en el el repositorio :                   ┃
# ┃  `https://github.com/Phantas0s/.dotfiles` con el objetivo de      ┃
# ┃  crear un ambiente zsh completo sin la complejidad de ohmyzsh     ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

fpath=($ZDOTDIR/plugins $fpath) # agregar plugins/ a fpath

# ┏━━━━━━━━━━━━━━┓
# ┃  navegar FS  ┃
# ┗━━━━━━━━━━━━━━┛

setopt AUTO_CD              # Go to folder path without using cd.

setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.

setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.

#autoload -Uz bd; bd

# ┏━━━━━━━━━━━┓
# ┃  history  ┃
# ┗━━━━━━━━━━━┛

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# ┏━━━━━━━━━━━┓
# ┃  colores  ┃
# ┗━━━━━━━━━━━┛
# Sobreescribir colores
eval "$(dircolors -b $ZDOTDIR/dircolors)"

# ┏━━━━━━━━━┓
# ┃  alias  ┃
# ┗━━━━━━━━━┛
# Carga alias desde archivo externo
source $ZDOTDIR/aliases.zsh 

# ┏━━━━━━━━━━━┓
# ┃  Scripts  ┃
# ┗━━━━━━━━━━━┛
# *** para hacer: crear scripts.zsh con todas las funciones sueltas 
source $ZDOTDIR/scripts.zsh


# ┏━━━━━━━━━━┓
# ┃  Prompt  ┃
# ┗━━━━━━━━━━┛

fpath=($ZDOTDIR/prompt $fpath)
autoload -Uz prompt_purification_setup; prompt_purification_setup


# ┏━━━━━━━━━━━━━━┓
# ┃  Completion  ┃
# ┗━━━━━━━━━━━━━━┛

autoload -U compinit; compinit
_comp_options+=(globdots)             # completion en `dotfiles`
source $ZDOTDIR/plugins/completion.zsh

# ┏━━━━━━━┓
# ┃  Vim  ┃
# ┗━━━━━━━┛
# Linea de comando en modo emulacion vim `viins`(insert)
bindkey -v
export KEYTIMEOUT=1
bindkey "^[[3~" delete-char           # evita entrar en modo `vicmd` al usar la tecla `Delete`

# eliminado, cambia el cursor en vim tambien
### Cambia el cursor al pasar de viins a vicmd
##autoload -Uz cursor_mode; cursor_mode

# Uso de teclas vim en el menu completions
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Editar la linea de comandos actual con vim,`escape`(vicmd) y despues `v`
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# En Modo viins, buscar en la historia de comandos a partir del textol ingresado 
bindkey '^[[A' up-line-or-search        # cursor arriba
bindkey '^[[B' down-line-or-search      # cursor abajo

# Cambia tecla escape con CapsLock (no se puede usar en notebook lenovo)
#xmodmap -e "keycode 9 = Caps_Lock NoSymbol Caps_Lock"   #Usar escape como CapsLock
#xmodmap -e "keycode 66 = Escape NoSymbol Escape"        #Usar CapsLock como escape

# ┏━━━━━━━━━━━━━━━━━━┓
# ┃  Cargar Plugins  ┃
# ┗━━━━━━━━━━━━━━━━━━┛

[[ -e $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
        source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -e $ZDOTDIR/plugins/command-not-found.zsh ]] && \
       source  $ZDOTDIR/plugins/command-not-found.zsh
