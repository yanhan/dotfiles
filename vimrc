set nocompatible   " be iMproved
filetype off       " required!

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
set smartcase

set hidden
runtime macros/matchit.vim

" For fzf
set rtp+=~/.fzf

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BEGIN molokai colorscheme configuration
if !has('macunix') && has('unix')
  colorscheme molokai
  let g:rehash256 = 1
endif
" END molokai colorscheme configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Change visual mode highlight colors
" From: https://stackoverflow.com/a/45798745
hi Visual cterm=bold ctermbg=blue ctermfg=grey


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

" Press Ctrl-p to start FZF for fuzzy file search, same as typing :FZF
nnoremap <C-p> :<C-u>FZF<CR>

" Open tabs using leader key and digits
" From: https://vim.fandom.com/wiki/Alternative_tab_navigation
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt

" Delete buffer without closing window
" From: https://stackoverflow.com/a/8585343
nnoremap <leader>bd  :bp<bar>sp<bar>bn<bar>bd<CR>

" By default, nerdcommenter uses {- -} style comments for Haskell.
" Change that to -- style comments instead
let g:NERDAltDelims_haskell = 1

" Some shortcuts to work with the system clipboard.
" These were originally temporary commands we added for hroamer ASCIInema recording
nnoremap <leader>x :.w ! xclip -sel clip<CR><CR>dd
nnoremap <leader>yy :.w ! xclip -sel clip<CR><CR>
nnoremap <leader>pp :r ! xclip -sel clip -o<CR>

" Window switching shortcuts, including for terminal mode.
" From Modern Vim by Drew Neil
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

if has('nvim')
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
endif

" Set VISUAL env var to nvr for terminal mode in nvim. The most common use
" case for this is running git commit, which opens the nvim editor.
"
" `-cc split` opens the temporary buffer in a horizontal split.
"
" `--remote-wait` tells nvr to block until the temporary buffer is deleted;
" that prevents us from executing further commands in terminal mode.
"
" `+'set bufhidden=wipe'` handles the situation where the temporary buffer was
" hidden but not deleted. Without this, nvr will continue to block if the user
" were to say switch from the temporary buffer to a different buffer, which is
" confusing. With it, if the temporary buffer was hidden, it will be
" automatically deleted to unblock the terminal.
"
" From Modern Vim by Drew Neil
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

" Start shell
if has('nvim')
  command! SH tabnew<bar>terminal
endif

" From Practical Vim (2nd edition), Tip 87: Search for the Current Visual Selection
"
" About: Select some text in visual mode, press * or # to search for it.
" Explanation: when the colon character is pressed with a visual selection, it
" will insert the '<,'> in the EX mode text buffer. The <C-u> is used to erase
" that. Source: https://stackoverflow.com/a/13831705
"
" The <SID> is used to ensure that the VSetSearch function that is used is the
" one defined in this script, in case there are functions with the same name
" in other plugins. Source: https://vim.fandom.com/wiki/How_to_write_a_plugin
"
" The / and ? initialize the search. <C-R>=@/<CR> lets us insert the contents
" of the register named / , whose content is populated by the VSetSearch
" function call.
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  " gv repeats the previous visual selection. "sy yanks the visual selection
  " to register s.
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
" END OF From Practical Vim (2nd edition), Tip 87: Search for the Current Visual Selection


""""""""""" Mac specific stuff
if has('macunix')
  " For solarized plugin (color scheme)
  " https://github.com/altercation/vim-colors-solarized
  syntax enable
  set background=dark
  colorscheme solarized

  " For copying and pasting using pbcopy in tmux.
  " We didn't actually need this for using pbcopy in tmux but we'll just add it
  " Source: https://github.com/tmux/tmux/issues/543#issuecomment-248980734
  set clipboard=unnamed

endif
"""""""""" END OF Mac specific stuff
