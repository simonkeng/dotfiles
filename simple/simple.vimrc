" Ultra simple vim config for working on remote 
" machines (that you don't plan to use for long).
" Usage:
" Clone or copy this file to your $HOME directory 
" and rename it ".vimrc"

syntax on
set number

filetype plugin on
filetype indent on

set so=7

let $LANG='en' 
set langmenu=en

set ruler
set cmdheight=2
set hid
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase 
set smartcase
set hlsearch
set incsearch 
set lazyredraw 
set magic
set showmatch 
set mat=2

set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax enable
set encoding=utf8
set background=dark

set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set lbr
set tw=500

set ai
set si
set wrap