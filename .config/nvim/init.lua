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

keymap.set('n', '<C-e>', '<Cmd>Telescope file_browser<CR>')
keymap.set('n', '<C-p>', '<Cmd>Telescope oldfiles<CR>')
keymap.set('n', '<Leader>h', '<Cmd>HopChar1<CR>')
keymap.set('n', '<Leader>n', '<Cmd>TermExec cmd="nodemon --exec python %"<CR><C-w>k')
keymap.set('n', '<Leader>p', '<Cmd>TermExec cmd="python %"<CR><C-w>k')
keymap.set('n', '<Leader>tf', '<Cmd>Telescope find_files<CR>')
keymap.set('n', '<Leader>tl', '<Cmd>Telescope live_grep<CR>')
keymap.set('n', '<Leader>tc', '<Cmd>Telescope commands<CR>')
keymap.set('n', '<Leader>tk', '<Cmd>Telescope keymaps<CR>')
keymap.set('n', '<Leader>tg', '<Cmd>Telescope git_commits<CR>')
keymap.set('n', '<Leader>tt', '<Cmd>TodoTelescope<CR>')
keymap.set('n', '<Leader>w', '<Cmd>WhichKey<CR>')
keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>')
keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>')

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
-- lewis6991/gitsigns.nvim
require('gitsigns').setup()
-- akinsho/bufferline.nvim
require('bufferline').setup {
  options = {
    separator_style = 'slant',
    always_show_bufferline = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
  }
}
-- folke/which-key.nvim
require('which-key').setup()
-- windwp/nvim-autopairs
require('nvim-autopairs').setup()
-- windwp/nvim-ts-autotag
require('nvim-ts-autotag').setup()
-- phaazon/hop.nvim
require('hop').setup()
-- kylechui/nvim-surround
require('nvim-surround').setup()
-- norcalli/nvim-colorizer.lua
require('colorizer').setup()
-- akinsho/toggleterm.nvim
require('toggleterm').setup()
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>h', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
-- folke/todo-comments.nvim
require('todo-comments').setup()
