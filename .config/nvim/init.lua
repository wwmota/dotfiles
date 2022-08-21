require('plugins')

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true

-- EdenEast/nightfox.nvim
vim.cmd('colorscheme nightfox')

-- plugins
-- nvim-lualine/lualine.nvim
require('lualine').setup()
