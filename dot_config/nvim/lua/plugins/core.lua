return {
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = true,
  },
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "numToStr/Comment.nvim",
    config = true,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "lewis6991/gitsigns.nvim",
  },
  {
    "akinsho/bufferline.nvim", version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        separator_style = "slant",
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  }
  -- -- the colorscheme should be available when starting Neovim
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },

  -- -- I have a separate config.mappings file where I require which-key.
  -- -- With lazy the plugin will be automatically loaded when it is required somewhere
  -- { "folke/which-key.nvim", lazy = true },

  -- {
  --   "nvim-neorg/neorg",
  --   -- lazy-load on filetype
  --   ft = "norg",
  --   -- options for neorg. This will automatically call `require("neorg").setup(opts)`
  --   opts = {
  --     load = {
  --       ["core.defaults"] = {},
  --     },
  --   },
  -- },

  -- {
  --   "dstein64/vim-startuptime",
  --   -- lazy-load on a command
  --   cmd = "StartupTime",
  --   -- init is called during startup. Configuration for vim plugins typically should be set in an init function
  --   init = function()
  --     vim.g.startuptime_tries = 10
  --   end,
  -- },

  -- {
  --   "hrsh7th/nvim-cmp",
  --   -- load cmp on InsertEnter
  --   event = "InsertEnter",
  --   -- these dependencies will only be loaded when cmp loads
  --   -- dependencies are always lazy-loaded unless specified otherwise
  --   dependencies = {
  --     "hrsh7th/cmp-nvim-lsp",
  --     "hrsh7th/cmp-buffer",
  --   },
  --   config = function()
  --     -- ...
  --   end,
  -- },

  -- -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
  -- -- So for api plugins like devicons, we can always set lazy=true
  -- { "nvim-tree/nvim-web-devicons", lazy = true },

  -- -- you can use the VeryLazy event for things that can
  -- -- load later and are not important for the initial UI
  -- { "stevearc/dressing.nvim", event = "VeryLazy" },

  -- {
  --   "Wansmer/treesj",
  --   keys = {
  --     { "J", "<cmd>TSJToggle<cr>", desc = "Join Toggle" },
  --   },
  --   opts = { use_default_keymaps = false, max_join_length = 150 },
  -- },

  -- {
  --   "monaqa/dial.nvim",
  --   -- lazy-load on keys
  --   -- mode is `n` by default. For more advanced options, check the section on key mappings
  --   keys = { "<C-a>", { "<C-x>", mode = "n" } },
  -- },

  -- -- local plugins need to be explicitly configured with dir
  -- { dir = "~/projects/secret.nvim" },

  -- -- you can use a custom url to fetch a plugin
  -- { url = "git@github.com:folke/noice.nvim.git" },

  -- -- local plugins can also be configured with the dev option.
  -- -- This will use {config.dev.path}/noice.nvim/ instead of fetching it from GitHub
  -- -- With the dev option, you can easily switch between the local and installed version of a plugin
  -- { "folke/noice.nvim", dev = true },
}

-- vim.cmd [[packadd packer.nvim]]

    -- return require('packer').startup(function(use)
    --   use 'EdenEast/nightfox.nvim'
    --   use 'nvim-lualine/lualine.nvim'
    --   use 'kyazdani42/nvim-web-devicons'
    --   use 'nvim-lua/plenary.nvim'
    --   use {'nvim-telescope/telescope.nvim', tag = '0.1.0'}
    --   use 'nvim-telescope/telescope-file-browser.nvim'
    --   use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    --   use 'numToStr/Comment.nvim'
    --   use 'lukas-reineke/indent-blankline.nvim'
    --   use 'lewis6991/gitsigns.nvim'
    --   use {'akinsho/bufferline.nvim', tag = 'v2.*'}
--   use 'folke/which-key.nvim'
--   use 'windwp/nvim-autopairs'
--   use 'windwp/nvim-ts-autotag'
--   use 'phaazon/hop.nvim'
--   use 'kylechui/nvim-surround'
--   use 'norcalli/nvim-colorizer.lua'
--   use {'akinsho/toggleterm.nvim', tag = 'v2.*'}
--   use 'folke/todo-comments.nvim'
--   use 'neovim/nvim-lspconfig'
--   use 'williamboman/mason.nvim'
--   use 'williamboman/mason-lspconfig.nvim'
--   use 'folke/trouble.nvim'
--   use {'glepnir/lspsaga.nvim', branch = 'main'}
--   use 'onsails/lspkind.nvim'
--   use 'hrsh7th/nvim-cmp'
--   use 'hrsh7th/cmp-nvim-lsp'
--   use 'hrsh7th/cmp-buffer'
--   use 'hrsh7th/cmp-path'
--   use 'hrsh7th/cmp-cmdline'
--   use 'hrsh7th/cmp-vsnip'
--   use 'hrsh7th/vim-vsnip'
--   use 'rafamadriz/friendly-snippets'
--   use 'ahmedkhalf/project.nvim'
--   use 'RRethy/vim-illuminate'
--   use 'TimUntersberger/neogit'
--   use 'editorconfig/editorconfig-vim'
-- end)
