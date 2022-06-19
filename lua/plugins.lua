local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug 'windwp/nvim-autopairs' -- Automatic paired character insersion
  -- Color schemes with some lua plugins support
  Plug 'Mofiqul/dracula.nvim' -- dark mode only color theme
  Plug 'ellisonleao/gruvbox.nvim' -- dark/light mode color theme
  Plug 'wadackel/vim-dogrun' -- dark mode only color theme
  Plug 'olimorris/onedarkpro.nvim' -- dark/light mode color theme
  Plug 'Mofiqul/vscode.nvim' -- dark/light mode color theme
  -- Solarized theme with patched to dark-dark gray background color
  Plug 'app/solarized' -- dark/light mode color theme

  Plug 'kyazdani42/nvim-web-devicons' -- status line icons; reruided by lualine.nvim
  Plug 'hoob3rt/lualine.nvim' -- status line decoration
  Plug 'nvim-lua/plenary.nvim' -- required by gitsigns.nvim from next line :)
  Plug 'lewis6991/gitsigns.nvim' -- vim-gitgutter replacement
  Plug 'numToStr/Comment.nvim' -- Better Comment
  Plug 'jparise/vim-graphql'  -- GraphQL syntax
  Plug 'nvim-treesitter/nvim-treesitter' -- Treesitter for smart selection expansion with `.`
  Plug('nvim-treesitter/nvim-treesitter', {
    ['do'] = 'TSUpdate'
  })
  Plug('heavenshell/vim-jsdoc', {
    ['for'] = 'javascript',
    ['do'] = 'make install'
  })
  -- javascript highliging and indentation
  Plug('pangloss/vim-javascript', {
    ['for'] = 'javascript'
  })
  -- jsx/typesctipt highliging and indentation
  Plug('maxmellon/vim-jsx-pretty', {
    ['for'] = 'javascript'
  })
  -- typesctipt highliging and indentation
  Plug('leafgarland/typescript-vim', {
    ['for'] = 'typescript'
  })

  -- Quick manipulations with surrounding symbols like quotes and brackets
  Plug 'machakann/vim-sandwich'

  -- Completion plugins
  Plug 'neovim/nvim-lspconfig'

  -- Autocompletion sources for autocompletion plugin
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  -- Autocompletion plugin
  Plug 'onsails/lspkind.nvim'
  Plug 'hrsh7th/nvim-cmp'

  -- Completion snippets for vsnip plugin
  Plug 'hrsh7th/cmp-vsnip'
  -- Snippet plugin
  Plug 'hrsh7th/vim-vsnip'

  Plug 'hrsh7th/vim-vsnip-integ' -- Snippets via lsp server integration
  Plug 'Nash0x7E2/awesome-flutter-snippets' -- Flutter/Dart snippets for lsp server
  Plug 'rafamadriz/friendly-snippets' -- Snippets library

  Plug 'ibhagwan/fzf-lua'
  Plug 'RRethy/vim-illuminate'

vim.call('plug#end')

-- Soursing plugins configs
require("config.autopairs").setup()

-- Color theme setup
-- Supported themes and valid values for NVIM_THEME environment variable
-- dogrun
-- dracula
-- gruvbox
-- onedarkpro
-- solarized
-- vscode
local defaultBgColor = "dark"
local defaultTheme = "solarized"
local bgColor = vim.env.NVIM_BGCOLOR ~= nil and vim.env.NVIM_BGCOLOR or defaultBgColor
local theme = vim.env.NVIM_THEME ~= nil and vim.env.NVIM_THEME or defaultTheme
vim.cmd( "set background=" .. bgColor)
vim.cmd("colorscheme " .. theme)

-- Show intro screen if no file opened on start up
local withoutFileName = (#vim.v.argv == 1)
if (withoutFileName) then
  vim.cmd "intro"
end

require("config.lualine")
require("config.gitsigns")
require("config.comment")
require("config.treesitter").setup()
vim.cmd "source ~/.config/nvim/sandwich.vim"
require("config.lspconfig")
require("config.nvim-cmp")
require("config.fzf-lua")
require("config.illuminate")
