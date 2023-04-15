local lsp = require("lsp-zero").preset({
  name = "minimal",
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- Change number of characters required to trigger autocompletion
-- Sources:
-- https://github.com/VonHeikemen/lsp-zero.nvim/issues/131
-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/07e43a593241bce72c0854398b16f51e0b46486e/advance-usage.md#setting-up-sources
lsp.setup_nvim_cmp({
  sources = {
    {name = "path"},
    -- Require 2 characters to trigger autocompletion using LSP
    {name = "nvim_lsp", keyword_length = 2},
    -- Only require 1 character to trigger autocompletion using words in
    -- the current buffer
    {name = "buffer", keyword_length = 1},
    -- Still trying to figure this one out or how to use it.
    -- Some help:
    -- https://github.com/L3MON4D3/LuaSnip
    -- https://github.com/L3MON4D3/LuaSnip/blob/b5a72f1fbde545be101fcd10b70bcd51ea4367de/Examples/snippets.lua
    -- https://jdhao.github.io/2020/05/27/why_you_should_use_snippets_in_vim/
    {name = "luasnip", keyword_length = 3},
  }
})

-- Names are from: https://github.com/williamboman/mason-lspconfig.nvim
-- What the :Mason command provides is inaccurate
lsp.ensure_installed({
  "bashls",
  "dockerls",
  "gopls",
  "lua_ls",
  "pyright",
  "tsserver",
})

-- (Optional) Configure lua lanage server for neovim
lsp.nvim_workspace()

lsp.setup()

-- Shows "virtual text" on right hand side of LSP diagnostics
-- From: https://github.com/VonHeikemen/lsp-zero.nvim/blob/07e43a593241bce72c0854398b16f51e0b46486e/advance-usage.md#configure-errors-messages
--
-- TODO: Add keymap to toggle this on and off?
-- Refer to https://neovim.io/doc/user/diagnostic.html#vim.diagnostic.config()
vim.diagnostic.config({
  virtual_text = true,
})
