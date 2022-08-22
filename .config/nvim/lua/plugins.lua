vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'EdenEast/nightfox.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'nvim-lua/plenary.nvim'
  use {'nvim-telescope/telescope.nvim', tag = '0.1.0'}
  use 'nvim-telescope/telescope-file-browser.nvim'
end)

