"""""""""""""""""""""""""""""""
""" daniel testa 27-06-2019 """
"""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, necesario 
filetype off                  " necesario

" establece la ruta para incluir e iniciar Vundle
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()             " necesario, los plugins deben aparecer después de esta línea.

Plugin 'gmarik/Vundle.vim'      " vundle
Plugin 'ap/vim-css-color'       " Color previews for CSS
Plugin 'Valloric/YouCompleteMe'

call vundle#end()		" necesario, los plugins deben aparecer antes de esta línea.

filetype plugin indent on       " necesario

" To ignore plugin indent changes, instead use:
"filetype plugin on
" 
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more detailsd or wiki for FAQ
" Put your non-Plugin stuff after this line


" Usar configuracion por defecto /usr/share/vim/vim82/defaults.vim
source $VIMRUNTIME/defaults.vim
au BufNewFile,BufRead *xmobarrc  setf haskell
set number
set relativenumber
set background=dark
colorscheme gruvbox
highlight Comment cterm=italic

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
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
