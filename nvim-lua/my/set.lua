vim.opt.filetype = "on"
vim.opt.filetype.indent = "on"
vim.opt.filetype.plugin = "on"

vim.opt.bs = "2"
vim.opt.tabstop = 2
-- soft tabstop. When deleting a line indented by spaces, deleting the spaces
-- feels like deleting tabs
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.ruler = true
-- shows row and column number at bottom right corner
vim.opt.syntax = "on"
-- for modelines like `# vim: ts=2 sw=2` for say python files
vim.opt.modeline = true
vim.opt.smartcase = true

vim.opt.incsearch = true

-- Ensure at least 8 lines before and after cursor when scrolling longer files
vim.opt.scrolloff = 8
-- Extra space to the left of line numbers to allow vim to display
-- some info, such as indicating syntax errors
vim.opt.signcolumn = "yes"
-- The entirety of column 80 will be colored slightly differently
vim.opt.colorcolumn = "80"

vim.opt.hidden = true
--runtime macros/matchit.vim

-- remap leader key to backslash
vim.g.mapleader = "\\"

-- Start shell
vim.api.nvim_create_user_command("SH", "tabnew<bar>terminal", {})

----- OS specific
if (vim.fn.has("macunix"))
then
  -- For copying and pasting using pbcopy in tmux.
  -- We didn't actually need this for using pbcopy in tmux but we'll just add it
  -- Source: https://github.com/tmux/tmux/issues/543#issuecomment-248980734
  vim.opt.clipboard = "unnamed"
elseif (vim.fn.has("win32"))
then
  vim.opt.bomb = false
end

-- Start shell
vim.api.nvim_create_user_command("SH", "tabnew<bar>terminal", {})


----- Plugin configuration

-- For fzf
vim.cmd [[ set rtp+=~/.fzf ]]

vim.g.airline_theme = "bubblegum"

-- vim-go for Go LSP
vim.g.go_def_mode = "gopls"
vim.g.go_info_mode = "gopls"
-- Let coc.nvim handle `gd` normal mode key mapping for goto definition,
-- as opposed to letting vim-go handle it
-- Reference: https://github.com/fatih/vim-go/issues/2923#issuecomment-1053674199
vim.g.go_def_mapping_enabled = 0
