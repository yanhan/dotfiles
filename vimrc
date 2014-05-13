set nocompatible   " be iMproved
filetype off       " required!

" Set the runtime to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'guns/vim-clojure-static'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'vim-scripts/paredit.vim'
Plugin 'tomasr/molokai'

" All of your Plugins must be added before the following line
call vundle#end() " required

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
syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN vim-clojure-static plugin configuration
"
" Refer to
"
"     https://github.com/guns/vim-clojure-static
"
" for more information on configuration options

" Syntax highlighting options
"
" `deftest`, `is` are from Chas Emerick's clojurescript.test
let g:clojure_syntax_keywords = {
  \ 'clojureMacro': ["deftest", "is"],
  \ 'clojureFunc':  ["clj->js", "js->clj", "js-delete", "js-obj", "js/alert", "js/confirm"],
  \ 'clojureVariable': ["js/console", "js/document", "js/window", "js/jQuery", "js/JSON"]
  \ }

" Align multiline strings to the column after opening quote
let g:clojure_align_multiline_strings = 1

" END vim-clojure-static plugin configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN rainbow_parentheses.vim configuration

" removed:
" \ ['darkgray',    'DarkOrchid3']
" \ ['black',       'SeaGreen3']
"
" added:
" \ ['magenta',     'DarkViolet']
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['magenta',     'DarkViolet'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 15

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" END rainbow_parentheses.vim configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN molokai colorscheme configuration
colorscheme molokai
let g:rehash256 = 1
" END molokai colorscheme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
