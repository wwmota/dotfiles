require('plugins')

vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true

vim.g.mapleader = ','

-- keymap
local keymap = vim.keymap
keymap.set('n', 'ss', ':split<Return><C-w>w')
keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
keymap.set('n', '<Space>', '<C-w>w')
keymap.set('n', 'sh', '<C-w>h')
keymap.set('n', 'sk', '<C-w>k')
keymap.set('n', 'sj', '<C-w>j')
keymap.set('n', 'sl', '<C-w>l')
keymap.set('n', '<C-w><C-l>', '<C-w><')
keymap.set('n', '<C-w><C-h>', '<C-w>>')
keymap.set('n', '<C-w><C-j>', '<C-w>+')
keymap.set('n', '<C-w><C-k>', '<C-w>-')

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
-- nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    disable = {},
  },
  ensure_installed = {
    "bash",
    "css",
    "dockerfile",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "sql",
    "tsx",
    "typescript",
    "yaml",
  },
}
-- numToStr/Comment.nvim
require('Comment').setup()
-- rukas-reineke/indent-blankline.nvim
require('indent_blankline').setup {
  show_current_context = true,
  show_current_context_start = true,
}
