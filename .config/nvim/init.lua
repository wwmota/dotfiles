require('plugins')

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true

vim.g.mapleader = ','

-- keymap
vim.keymap.set('n', '<C-e>', '<Cmd>Telescope file_browser<CR>')
vim.keymap.set('n', '<C-p>', '<Cmd>Telescope oldfiles<CR>')
vim.keymap.set('n', '<Leader>tf', '<Cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>tl', '<Cmd>Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>tc', '<Cmd>Telescope commands<CR>')
vim.keymap.set('n', '<Leader>tk', '<Cmd>Telescope keymaps<CR>')
vim.keymap.set('n', '<Leader>tg', '<Cmd>Telescope git_commits<CR>')

-- EdenEast/nightfox.nvim
vim.cmd('colorscheme nightfox')

-- plugins
-- nvim-lualine/lualine.nvim
require('lualine').setup()
-- nvim-telescope/telescope.nvim
require('telescope').setup()
require('telescope').load_extension 'file_browser'

