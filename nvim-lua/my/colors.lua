if (vim.fn.has("Linux"))
then
  vim.cmd("colorscheme darcula")
  vim.opt.termguicolors = true
  vim.g.rehash256 = 1
elseif (vim.fn.has("macunix"))
then
  vim.opt.background = "dark"
  -- set termguicolors for solarized8
  -- From: https://github.com/lifepillar/vim-solarized8/issues/38#issuecomment-381257464
  vim.opt.termguicolors = true
  vim.cmd("colorscheme solarized8")
elseif (vim.fn.has("win32"))
then
  vim.cmd("colorscheme molokai")
end
