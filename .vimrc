"""""""""""""""""""""""""""""""
""" daniel testa 27-06-2019 """
"""""""""""""""""""""""""""""""


" Usar configuracion por defecto /usr/share/vim/vim81/defaults.vim
source $VIMRUNTIME/defaults.vim

set number
set relativenumber


if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Add optional packages.

"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Barra de estado

set laststatus=2
