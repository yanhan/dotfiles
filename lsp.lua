local lsp = require("lsp-zero").preset({
  name = "minimal",
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- Names are from: https://github.com/williamboman/mason-lspconfig.nvim
-- What the :Mason command provides is inaccurate
lsp.ensure_installed({
  "bashls",
  "dockerls",
  "gopls",
  "lua_ls",
  "pyright",
})

-- (Optional) Configure lua lanage server for neovim
lsp.nvim_workspace()

lsp.setup()
