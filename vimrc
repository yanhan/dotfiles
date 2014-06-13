set nocompatible   " be iMproved
filetype off       " required!

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required!
Plugin 'gmarik/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jlanzarotta/bufexplorer'
" Golang syntax highlighting
Plugin 'jnwhiteh/vim-golang'

" All plugins must be added before the following line
call vundle#end()

filetype plugin indent on  " required!

set bs=2
set ts=2
" soft tabstop. When deleting a line indented by spaces, deleting the spaces
" feels like deleting tabs
set sts=2
set sw=2
set expandtab
set autoindent
set number
" shows row and column number at bottom right corner
set ruler
set modeline
set modelines=1

" For solarized plugin (color scheme)
" https://github.com/altercation/vim-colors-solarized
syntax enable
set background=dark
colorscheme solarized
