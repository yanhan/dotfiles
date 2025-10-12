-- This should be in the ~/.config/nvim dir
require("my")

-- Prevent builtin vim.lsp.completion autotrigger from selecting 1st item
-- Source: https://blog.viktomas.com/graph/neovim-native-built-in-lsp-autocomplete/
vim.opt.completeopt = {"menuone", "noselect", "popup"}

vim.lsp.enable('luals')
