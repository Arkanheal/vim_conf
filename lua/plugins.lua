local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

return require('packer').startup(function()
  -- Automanagement
  use 'wbthomason/packer.nvim' -- The package manager

  -- Commons
  use 'myusuf3/numbers.vim' -- Relative line numbers (not LUA)
  use 'Townk/vim-autoclose' -- not LUA
  use 'kylechui/nvim-surround' -- Changes word surround
  use 'tpope/vim-vinegar' -- Move in directories (not LUA)
  use 'tpope/vim-eunuch' -- UNIX commands wrapper (not LUA)
  use 'preservim/nerdcommenter' -- Comment shortcut (not LUA)
  use 'mattn/emmet-vim' -- html stuff (not LUA)

  -- Pretty stuff
  use 'folke/tokyonight.nvim'
  -- Print small squares of colors (not LUA)
  use { 'rrethy/vim-hexokinase', run = 'make hexokinase' }
  use 'kyazdani42/nvim-web-devicons' -- pretty icons
  -- Langage parser (experimental)
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      require('nvim-treesitter.install')
          .update({ with_sync = true })
    end
  }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-lualine/lualine.nvim' -- Pretty status line

  -- Custom configurations by directory (to test with LUA)
  use 'arielrossanigo/dir-configs-override.vim'

  -- LSP (test that out)
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'hrsh7th/cmp-cmdline'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
  use 'glepnir/lspsaga.nvim'

  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.0',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- Git
  use 'tpope/vim-fugitive' -- Git commands wrapper (not LUA)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Test
  use 'vim-test/vim-test'

  -- Python
  -- Detect indent blocks
  use { 'tweekmonster/braceless.vim', ft = 'python' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
