local null_ls = require("null-ls")

-- We learnt how to configure this from:
-- https://smarttech101.com/nvim-lsp-set-up-null-ls-for-beginners/
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/787d250107b5f6a2535245c4060cc7a5b0b87884/doc/BUILTINS.md
null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.ansiblelint,
    null_ls.builtins.diagnostics.jsonlint,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.diagnostics.yamllint,
  },
})
