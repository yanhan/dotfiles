-- Convert .tex files to .pdf on save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"*.tex"},
  command = "!pdflatex <afile>"
})

-- Based on code in https://github.com/FotiadisM/tabset.nvim/commit/996f95e4105d053a163437e19a40bd2ea10abeb2
-- We should probably just use that library
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("tabset", { clear = true }),
  callback = function()
    if vim.o.filetype == "java" then
      vim.o.tabstop = 4
      vim.o.shiftwidth = 4
      vim.o.softtabstop = 4
      vim.o.expandtab = true
    end
  end
})

-- Neither of the below work
-- Source: https://github.com/mhinz/neovim-remote/tree/1004d41696a3de12f0911b1949327c3dbe4a62ab
--vim.cmd [[ autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete ]]

-- Source: https://luabyexample.netlify.app/docs/nvim-autocmd/
--vim.api.nvim_create_autocmd({"FileType"}, {
  --pattern = { "gitcommit", "gitrebase", "gitconfig" },
  --command = "set bufhidden=delete"
--})
