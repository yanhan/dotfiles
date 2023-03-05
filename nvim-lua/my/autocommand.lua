-- Convert .tex files to .pdf on save
vim.api.nvim_create_autocmd({"BufWritePost"}, {
  pattern = {"*.tex"},
  command = "!pdflatex <afile>"
})
