" for windows
set runtimepath+=$HOME/.vim,$HOME/.vim/after

" common
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

" display
set background=dark
set t_Co=256
if filereadable( $HOME . "/.vim/colors/hybrid.vim" )
  colorscheme hybrid
else
  colorscheme desert
endif
syntax on

" keybind
nnoremap <C-n> gt
nnoremap <C-p> gT
nnoremap cn :cn<ESC>
nnoremap cp :cp<ESC>
let mapleader = "\<Space>"
nnoremap <F3> :<C-u>setlocal relativenumber!<CR>

" OS check
if has('win32')
  let ostype = "Win"
elseif has('mac')
  let ostype = "Mac"
else
  let ostype = system("uname")
endif

" ctags
nnoremap <C-]> g<C-]>

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug '~/my-prototype-plugin'
call plug#end()

" utility functions
:source ~/.vim/cmd/match.vim
