vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'EdenEast/nightfox.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.0'}
  use 'nvim-telescope/telescope-file-browser.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'numToStr/Comment.nvim'
  use 'lukas-reineke/indent-blankline.nvim'
  use 'lewis6991/gitsigns.nvim'
  use {'akinsho/bufferline.nvim', tag = 'v2.*'}
  use 'folke/which-key.nvim'
  use 'windwp/nvim-autopairs'
  use 'windwp/nvim-ts-autotag'
  use 'phaazon/hop.nvim'
  use 'kylechui/nvim-surround'
  use 'norcalli/nvim-colorizer.lua'
  use {'akinsho/toggleterm.nvim', tag = 'v2.*'}
  use 'folke/todo-comments.nvim'
end)
