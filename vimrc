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

" remap leader key to backslash
let mapleader = '\'
" Toggle :set paste
nnoremap <leader>o :set paste!<CR>
" allows you to type input to switch buffers while showing list of buffers
nnoremap <leader>l :ls<CR>:b<space>
" Toggle NERDTree open/close
nnoremap <leader>nt :NERDTreeToggle<CR>

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

" Window switching shortcuts, including for terminal mode.
" From Modern Vim by Drew Neil
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

if has('nvim')
  " Window switching shortcuts, including for terminal mode.
  " From Modern Vim by Drew Neil
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
  tnoremap <Esc> <C-\><C-n>

  " Start shell
  command! SH tabnew<bar>terminal

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
  if executable('nvr')
    let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
  endif
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

  " Some shortcuts to work with the system clipboard.
  nnoremap <leader>c :call system('pbcopy', @")<CR>
  nnoremap <leader>x :.w ! pbcopy<CR><CR>dd
  nnoremap <leader>yy :.w ! pbcopy<CR><CR>
  nnoremap <leader>pp :r ! pbpaste<CR>

  " For copying and pasting using pbcopy in tmux.
  " We didn't actually need this for using pbcopy in tmux but we'll just add it
  " Source: https://github.com/tmux/tmux/issues/543#issuecomment-248980734
  set clipboard=unnamed
elseif has('linux')
  "colorscheme molokai
  colorscheme darcula
  set termguicolors
  let g:rehash256 = 1

  " Some shortcuts to work with the system clipboard.
  nnoremap <leader>c :call system('xclip -sel clip', @")<CR>
  nnoremap <leader>x :.w ! xclip -sel clip<CR><CR>dd
  nnoremap <leader>yy :.w ! xclip -sel clip<CR><CR>
  nnoremap <leader>pp :r ! xclip -sel clip -o<CR>
endif
"""""""""" END OF Mac specific stuff

let g:airline_theme='bubblegum'

let g:ale_linters = {
\ 'json': ['jsonlint'],
\ 'yaml': ['yamllint'],
\}
let g:ale_fixers = {
\}
" Only run linters named in g:ale_linters
let g:ale_linters_explicit = 1
" These 3 ale_lint_on_* are from:
" https://github.com/dense-analysis/ale?msclkid=69237d68bb8911eca6f5ae06dfeac5ec#5xii-how-can-i-run-linters-only-when-i-save-files
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_fix_on_save = 1
" From: https://github.com/dense-analysis/ale?msclkid=69237d68bb8911eca6f5ae06dfeac5ec#5ix-how-can-i-change-the-format-for-echo-messages
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" vim-go for Go LSP
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" Let coc.nvim handle `gd` normal mode key mapping for goto definition,
" as opposed to letting vim-go handle it
" Reference: https://github.com/fatih/vim-go/issues/2923#issuecomment-1053674199
let g:go_def_mapping_enabled=0

" ========== coc.nvim ==========
" From: https://github.com/neoclide/coc.nvim/blob/b797c032802d89c2a01b03429544a632ca2c0c5a/README.md
" NOTE: We skipped a number of lines in the documentation, mostly because they
" either do not work / unsure what they are doing / we don't need them for now

" Make user experience better. Longer updatetime (default is 4000ms) leads
" to noticeable delays
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

" Use tab to trigger completion with characters ahead and navigate.
" NOTE: There is always a completion item selected by default. You may
" want to enable no select by setting `"suggest.noselect": true` in the
" COC configuration file.
" NOTE: Use the vim command ':verbose imap <tab>' to make sure tab is not
" mapped by other plugins before putting this into your vim config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own coc
" TODO: What does the second line of the above comment even mean???
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location
" list
nmap <silent>[g <Plug>(coc-diagnostic-prev)
nmap <silent>]g <Plug>(coc-diagnostic-next)

" Shortcuts for code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlights symbol and its references when your cursor is resting on it.
" In other words, when you hover over some text and don't move for some
" time (a short while), the references to the same text will be
" highlighted with a less sharp colour than that used during searching
autocmd CursorHold * silent call CocActionAsync('highlight')

" Used to rename a symbol (such as a struct name, function name)
nmap <leader>rn <Plug>(coc-rename)

" If I'm right, this has to do with easy highlighting of entire function
" body when in select mode (for xmap).
" 'if' selects just the function body (not including the signature,
" opening and closing braces).
" 'af' selects the entire function, signature, braces and all
" NOTE: Requires 'textDocument.documentSymbol' support from the language
" server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" These are used to scroll floats that contain documentation. Such floats
" appear to the right of the completion popup menu.
" We have another set of bindings below that use <C-d> and <C-u> to scroll the
" pop up menu for the completions themselves; those are probably more useful.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use <C-d> and <C-u> to scroll the pop up menu for completions.
" The 'pum' in `coc#pum` stands for pop up menu
inoremap <silent><expr> <C-d> coc#pum#visible() ? coc#pum#scroll(1) : "\<PageDown>"
inoremap <silent><expr> <C-u> coc#pum#visible() ? coc#pum#scroll(0) : "\<PageUp>"

" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organizing imports of the current buffer.
" Requires LSP support for the language
command! -nargs=0 OR :call CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" You will need external plugins that provide custom statusline:
" lightline.vim, vim-airline
" NOTE: Not sure if this works
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for COCList
" Show all diagnostics
nnoremap <silent><nowait> <space>a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent><nowait> <space>e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent><nowait> <space>c :<C-u>CocList commands<cr>
" Find symbol in current file
nnoremap <silent><nowait> <space>o :<C-u>CocList outline<cr>
" =========== End of config for coc.nvim ==========


" Change visual mode highlight colors
" From: https://stackoverflow.com/a/45798745
" This is placed after the color scheme code
hi Visual cterm=bold ctermbg=blue ctermfg=grey
