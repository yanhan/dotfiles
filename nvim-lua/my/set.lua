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
vim.opt.number = true
vim.opt.ruler = true
-- shows row and column number at bottom right corner
vim.opt.syntax = "on"
-- for modelines like `# vim: ts=2 sw=2` for say python files
vim.opt.modeline = true
vim.opt.smartcase = true

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

vim.g.ale_linters = {
 ["json"] = {"jsonlint"},
 ["yaml"] = {"yamllint"}
}
vim.g.ale_fixers = {}
-- Only run linters named in g:ale_linters
vim.g.ale_linters_explicit = 1
-- These 3 ale_lint_on_* are from:
-- https://github.com/dense-analysis/ale?msclkid=69237d68bb8911eca6f5ae06dfeac5ec#5xii-how-can-i-run-linters-only-when-i-save-files
vim.g.ale_lint_on_text_changed = "always"
vim.g.ale_lint_on_insert_leave = 1
vim.g.ale_lint_on_enter = 1
vim.g.ale_fix_on_save = 1
-- From: https://github.com/dense-analysis/ale?msclkid=69237d68bb8911eca6f5ae06dfeac5ec#5ix-how-can-i-change-the-format-for-echo-messages
vim.g.ale_echo_msg_format = "[%linter%] %s [%severity%]"

-- vim-go for Go LSP
vim.g.go_def_mode = "gopls"
vim.g.go_info_mode = "gopls"
-- Let coc.nvim handle `gd` normal mode key mapping for goto definition,
-- as opposed to letting vim-go handle it
-- Reference: https://github.com/fatih/vim-go/issues/2923#issuecomment-1053674199
vim.g.go_def_mapping_enabled = 0

