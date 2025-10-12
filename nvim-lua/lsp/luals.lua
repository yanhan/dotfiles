-- Lua LSP configuration
-- Note that this requires that the lua-language-server binary is installed.
-- That can be done using asdf: https://github.com/bellini666/asdf-lua-language-server
--
-- The configuration is a combination of:
-- https://vonheikemen.github.io/learn-nvim/feature/lsp-setup.html
-- https://luals.github.io/wiki/configuration/#neovim
-- https://blog.viktomas.com/graph/neovim-native-built-in-lsp-autocomplete/
return {
  cmd = {'lua-language-server'},
  filetypes = {'lua'},
  root_markers = {'.luarc.json', '.luarc.jsonc'},
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      }
    }
  },
  on_attach = function(client, bufnr)
    vim.lsp.completion.enable(true, client.id, bufnr, {
      autotrigger = true,
      convert = function(item)
        return { abbr = item.label:gsub("%b()", "") }
      end,
    })
    vim.keymap.set("i", "<C-space>", vim.lsp.completion.get, { desc = "trigger autocompletion" })
  end
}
