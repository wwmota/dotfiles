require('plugins')

vim.g.mapleader = ','
vim.g.python3_host_prog = os.getenv('HOME') .. '/.pyenv/versions/neovim/bin/python'
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true

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

vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder)
vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder)
vim.keymap.set('n', '<Leader>wl', function()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)

keymap.set('n', '<C-e>', '<Cmd>Telescope file_browser<CR>')
keymap.set('n', '<C-p>', '<Cmd>Telescope oldfiles<CR>')
keymap.set('n', '<Leader>h', '<Cmd>HopChar1<CR>')
keymap.set('n', '<Leader>m', '<Cmd>Mason<CR>')
keymap.set('n', '<Leader>n', '<Cmd>TermExec cmd="nodemon --exec python %"<CR><C-w>k')
keymap.set('n', '<Leader>p', '<Cmd>TermExec cmd="python %"<CR><C-w>k')
keymap.set('n', '<Leader>x', '<Cmd>TroubleToggle<CR>')
keymap.set('n', '<Leader>tf', '<Cmd>Telescope find_files<CR>')
keymap.set('n', '<Leader>tl', '<Cmd>Telescope live_grep<CR>')
keymap.set('n', '<Leader>tc', '<Cmd>Telescope commands<CR>')
keymap.set('n', '<Leader>tk', '<Cmd>Telescope keymaps<CR>')
keymap.set('n', '<Leader>tg', '<Cmd>Telescope git_commits<CR>')
keymap.set('n', '<Leader>tp', '<Cmd>Telescope projects<CR>')
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
require('telescope').load_extension('file_browser')
require('telescope').load_extension('projects')
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
-- neovim/nvim-lspconfig
-- williamboman/mason.nvim
-- williamboman/mason-lspconfig.nvim
require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = {
    "bashls",
    "dockerls",
    "jsonls",
    "pyright",
    "sumneko_lua",
    "tsserver"
  }
})
mason_lspconfig.setup_handlers {
  function (server_name)
    require('lspconfig')[server_name].setup {
      on_attach = on_attach,
      handlers = {
        ['textDocument/publishDiagnostics'] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false
          }
        ),
      },
    }
  end,
}
-- folke/trouble.nvim
require('trouble').setup()
-- glepnir/lspsaga.nvim
require('lspsaga').setup({})
-- onsails/lspkind.nvim
-- hrsh7th/nvim-cmp
-- hrsh7th/cmp-nvim-lsp
-- hrsh7th/cmp-buffer
-- hrsh7th/cmp-path
-- hrsh7th/cmp-vsnip
-- hrsh7th/vim-vsnip
-- rafamadriz/friendly-snippets
local cmp = require('cmp')
local lspkind = require('lspkind')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
    { name = 'vsnip' },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50
    })
  }
})
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'path' },
		{ name = 'cmdline' },
	},
})
local opts = { silent=true }
vim.keymap.set('n', 'gh', '<Cmd>Lspsaga lsp_finder<CR>', opts)
vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
vim.keymap.set('n', 'gd', '<Cmd>Lspsaga preview_definition<CR>', opts)
vim.keymap.set('n', '<Leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
vim.keymap.set('n', '<Leader>cd', '<Cmd>Lspsaga show_line_diagnostics<CR>', opts)
vim.keymap.set('n', '[e', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
vim.keymap.set('n', ']e', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
vim.keymap.set('n', '<Leader>o', '<Cmd>LSoutlineToggle<CR>', opts)
vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
-- local action = require("lspsaga.action")
-- vim.keymap.set('n', '<C-f>', function()
--     action.smart_scroll_with_saga(1)
-- end, opts)
-- vim.keymap.set('n', '<C-b>', function()
--     action.smart_scroll_with_saga(-1)
-- end, opts)
-- ahmedkhalf/project.nvim
require('project_nvim').setup()
require('neogit').setup()
