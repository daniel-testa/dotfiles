# vim:ft=zsh ts=2 sw=2 sts=2
#
# daniel testa 04-12-20
# basado en el tema "frontcube.zsh-theme
#

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[red]%}%{$fg_bold[blue]%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} %{$fg[red]%}✖ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[red]%} %{$fg[green]%}✔%{$reset_color%}"
ZSH_THEME_RUBY_PROMPT_PREFIX="%{$fg[green]%}"
ZSH_THEME_RUBY_PROMPT_SUFFIX="%{$reset_color%}"

PROMPT='
%{$fg_bold[blue]%}%{$fg_bold[red]%}%m%{$fg_bold[blue]%}%{$fg_bold[magenta]%}  %{$fg_bold[red]%}%{$fg_bold[green]%}%~%{$fg_bold[blue]%}%{$fg_bold[blue]%}%{$fg_bold[red]%}%{$reset_color%}
%{$fg[cyan]%}   %{$reset_color%'

RPROMPT='$(git_prompt_info) $(ruby_prompt_info)'
