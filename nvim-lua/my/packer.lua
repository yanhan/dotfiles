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
  use "nvim-lua/plenary.nvim"
  use "ThePrimeagen/harpoon"

  use "editorconfig/editorconfig-vim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }

  use {
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},             -- Required
      {"williamboman/mason.nvim"},           -- Optional
      {"williamboman/mason-lspconfig.nvim"}, -- Optional

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},         -- Required
      {"hrsh7th/cmp-nvim-lsp"},     -- Required
      {"hrsh7th/cmp-buffer"},       -- Optional
      {"hrsh7th/cmp-path"},         -- Optional
      {"saadparwaiz1/cmp_luasnip"}, -- Optional
      {"hrsh7th/cmp-nvim-lua"},     -- Optional

      -- Snippets
      {"L3MON4D3/LuaSnip"},             -- Required
      {"rafamadriz/friendly-snippets"}, -- Optional
    }
  }

  use "jose-elias-alvarez/null-ls.nvim"
end)
