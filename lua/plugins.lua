local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

  Plug 'windwp/nvim-autopairs' -- Automatic paired character insersion
  -- Solarized theme with dark-dark gray background color
  Plug 'app/solarized' -- 'solarized' color scheme with some lua plugins support
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

-- vim.cmd "colorscheme solarized"
vim.cmd [[
  try
    colorscheme solarized
  catch
    echo "Warning: Please check 'app/solarized' plugin installed"
  endtry
]]
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
