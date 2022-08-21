vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'EdenEast/nightfox.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'kyazdani42/nvim-web-devicons'
end)

