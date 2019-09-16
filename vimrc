set nocompatible   " be iMproved
filetype off       " required!

" For vim-plug: this specifies a directory for plugins
call plug#begin('~/.vim/plugged')

Plug 'jlanzarotta/bufexplorer'
Plug 'tomasr/molokai'
Plug 'scrooloose/nerdcommenter'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'

" Initialize plugin system
call plug#end()

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
" for modelines like `# vim: ts=2 sw=2` for say python files
set modeline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN molokai colorscheme configuration
colorscheme molokai
let g:rehash256 = 1
" END molokai colorscheme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" remap leader key to backslash
let mapleader = '\'
" Toggle :set paste
nnoremap <leader>o :set paste!<CR>
" allows you to type input to switch buffers while showing list of buffers
nnoremap <leader>l :ls<CR>:b<space>
" Toggle NERDTree open/close
nnoremap <leader>nt :NERDTreeToggle<CR>
" Use F3 to copy from the default register
nnoremap <leader>c :call system('xclip -sel clip', @")<CR>

" Convert .tex files to .pdf on save
autocmd BufWritePost *.tex !pdflatex <afile>

" Syntastic minimal recommended config
" From https://github.com/vim-syntastic/syntastic#3-recommended-settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" Use ESLint for syntastic
" This is a combination of settings from:
" - https://github.com/mantoni/eslint_d.js#linting
" - https://github.com/vim-syntastic/syntastic/issues/1692#issuecomment-350153207
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_generic = 1
let g:syntastic_javascript_eslint_exec = '/bin/ls'
let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
let g:syntastic_javascript_eslint_args = '-f compact'

" By default, nerdcommenter uses {- -} style comments for Haskell.
" Change that to -- style comments instead
let g:NERDAltDelims_haskell = 1

" Some shortcuts to work with the system clipboard.
" These were originally temporary commands we added for hroamer ASCIInema recording
nnoremap <leader>x :.w ! xclip -sel clip<CR><CR>dd
nnoremap <leader>yy :.w ! xclip -sel clip<CR><CR>
nnoremap <leader>pp :r ! xclip -sel clip -o<CR>

au BufRead,BufNewFile ~/books-impt/how-google-tests-software/how-google-tests-software.md call HowGoogleTestsSoftwareAbbrevs()
function HowGoogleTestsSoftwareAbbrevs()
  ab dev developer
  ab devs developers
  ab cap capability
  ab caps capabilities
  ab g+ Google+
  ab info information
  ab thru through
  ab prefs preferences
  ab env environment
  ab envs environments
  ab infra infrastructure
  ab JS JavaScript
  ab elem element
  ab elems elements
  ab eng engineering
  ab Eng Engineering
  ab attr attribute
  ab db database
  ab repo repository
  ab wtf what the fuck
endfunction
