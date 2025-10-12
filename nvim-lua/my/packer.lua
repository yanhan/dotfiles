-- This file can only be loaded by calling `require("my.packer")` from nvim-lua/my/init.lua

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
  use "nvim-lua/plenary.nvim"
  use "ThePrimeagen/harpoon"

  use "editorconfig/editorconfig-vim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use "windwp/nvim-ts-autotag"
end)
