-- Convert .tex files to .pdf on save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"*.tex"},
  command = "!pdflatex <afile>"
})

-- Neither of the below work
-- Source: https://github.com/mhinz/neovim-remote/tree/1004d41696a3de12f0911b1949327c3dbe4a62ab
--vim.cmd [[ autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete ]]

-- Source: https://luabyexample.netlify.app/docs/nvim-autocmd/
--vim.api.nvim_create_autocmd({"FileType"}, {
  --pattern = { "gitcommit", "gitrebase", "gitconfig" },
  --command = "set bufhidden=delete"
--})
