vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'EdenEast/nightfox.nvim'
end)
