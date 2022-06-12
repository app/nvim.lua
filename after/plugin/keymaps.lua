local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

--Highlight off
keymap("n", "<silent> <C-l>", ":nohlsearch<CR><C-l>", default_opts)

-- Display hidden symbols
vim.g.listExtended = false
keymap("n", "<leader>l", "", {
  noremap = true,
  callback = function()
    if vim.g.listExtended then
      vim.wo.cursorcolumn = true
      vim.opt.listchars = {
        space = ".",
        eol = "↵",
        nbsp = "+",
        tab = "> ",
        trail = "-"
      }
    else
      vim.wo.cursorcolumn = false
      vim.opt.listchars = {
        nbsp = "+",
        tab = "> ",
        trail = "-"
      }
    end
    vim.g.listExtended = not vim.g.listExtended
  end,
})

--Add new line below in Insert mode
keymap("i", "<C-o>", "<esc>o",default_opts)

--Use CTRL-S for saving, also in Insert mode
keymap("n", "<C-S>", ":w<CR>",default_opts)
keymap("v", "<C-S>", "<C-C>:w<CR>",default_opts)
keymap("i", "<C-S>", "<ESC>:w<CR>",default_opts)

-- Quit from vim
keymap("n", "<C-Q>", ":q<CR>",default_opts)

-- Close curent buffer
keymap("n", "<Leader>q", ":bd<CR>",default_opts)

