-- This file can only be loaded by calling `lua require("plugins")` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function(use)
  -- Packer can manage itself
  use "wbthomason/packer.nvim"

  use "doums/darcula"
  use "tomasr/molokai"
  use "lifepillar/vim-solarized8"
  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"

  use "preservim/nerdcommenter"
  use "preservim/nerdtree"

  use "kana/vim-textobj-user"
  use "kana/vim-textobj-entire"
  use "tpope/vim-surround"
  use "alvan/vim-closetag"

  use "junegunn/fzf.vim"

  use "dense-analysis/ale"

  use "editorconfig/editorconfig-vim"
end)
