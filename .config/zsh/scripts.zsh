#!/bin/env zsh

# busca glifos / iconos de fuentes `Nerd Fonts`
function nf_icon () {
	grep -i "$1" "$XDG_CONFIG_HOME/unicode_icons/nerd_fonts_unicode_icons"
}

# `d` como alias condicional
function d () {
        if [[ -n $1 ]]; then
                dirs "$@"
        else
                dirs -v | head -10
        fi
}

## Alt+, Alt+ y Alt+ para navegar por la pila de carpetas (folder stack (dirs -v))
#function my-redraw-prompt() {
#  {
#    builtin echoti civis
#    builtin local f
#    for f in chpwd "${chpwd_functions[@]}" precmd "${precmd_functions[@]}"; do
#      (( ! ${+functions[$f]} )) || "$f" &>/dev/null || builtin true
#    done
#    builtin zle reset-prompt
#  } always {
#    builtin echoti cnorm
#  }
#}
#
#function my-cd-rotate() {
#  () {
#    builtin emulate -L zsh
#    while (( $#dirstack )) && ! builtin pushd -q $1 &>/dev/null; do
#      builtin popd -q $1
#    done
#    (( $#dirstack ))
#  } "$@" && my-redraw-prompt
#}
#
#function my-cd-up()      { builtin cd -q .. && my-redraw-prompt; }
#function my-cd-back()    { my-cd-rotate +1; }
#function my-cd-forward() { my-cd-rotate -0; }
#
#builtin zle -N my-cd-up
#builtin zle -N my-cd-back
#builtin zle -N my-cd-forward
#
#() {
#  builtin local keymap
#  for keymap in emacs viins vicmd; do
#    builtin bindkey '^[^[[A'  my-cd-up
#    builtin bindkey '^[[1;3A' my-cd-up
#    builtin bindkey '^[[1;9A' my-cd-up
#    builtin bindkey '^[^[[D'  my-cd-back
#    builtin bindkey '^[[1;3D' my-cd-back
#    builtin bindkey '^[[1;9D' my-cd-back
#    builtin bindkey '^[^[[C'  my-cd-forward
#    builtin bindkey '^[[1;3C' my-cd-forward
#    builtin bindkey '^[[1;9C' my-cd-forward
#  done
#}
#
#setopt auto_pushd
