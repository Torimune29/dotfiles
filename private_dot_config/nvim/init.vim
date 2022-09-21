"""""""""""""""""""""""""""""""""""""""
" common
"""""""""""""""""""""""""""""""""""""""

" for windows
set runtimepath+=$HOME/.vim,$HOME/.vim/after

set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=0
set smartindent
set list
set hidden
set showcmd
set ruler
set laststatus=2
set nobackup
set noswapfile
set writebackup
set listchars=tab:>-
set nocursorline
autocmd InsertEnter,InsertLeave * set cursorline!
set cmdheight=1
set wildmenu
set wildmode=longest:full,full
set ignorecase
set smartcase
set wrapscan
set hlsearch
set showmatch
set autochdir
set nocompatible
set number
set scrolloff=7
set nowrap
set autochdir
set fdc=2
set fdm=indent

" OS check
if has('win32')
  let ostype = "Win"
elseif has('mac')
  let ostype = "Mac"
else
  let ostype = system("uname")
endif

"""""""""""""""""""""""""""""""""""""""
" plugin manager (vim-plug)
"""""""""""""""""""""""""""""""""""""""
" fetch vim-plug if not found
if empty(glob('$HOME/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/plugged')

" plugins
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0ng/vim-hybrid'

call plug#end()


" :PlugInstall if needed
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

"""""""""""""""""""""""""""""""""""""""
" plugin settings
"""""""""""""""""""""""""""""""""""""""
" colorsheme
set background=dark
set t_Co=256
colorscheme hybrid

syntax on

