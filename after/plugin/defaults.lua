local api = vim.api
local g = vim.g
local opt = vim.opt

-- Remap leader and local leader to <Space>
api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

-- Russian keyboard layous support
opt.keymap="russian-jcukenwin"
opt.iminsert=0
opt.imsearch=0
vim.cmd "highlight lCursor guifg=NONE guibg=Cyan"
opt.langmap="ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

opt.clipboard = "unnamedplus" -- Access system clipboard
opt.cursorline = true
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.list = true
opt.signcolumn="yes:1"
opt.termguicolors = true -- Enable colors in terminal
opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete.
opt.updatetime = 500 -- Let plugins show effects after 500ms, not 4s
opt.splitbelow = true -- new window will appears below current window

vim.api.nvim_create_autocmd({"BufEnter","FocusGained","InsertLeave"}, {
  pattern = "*",
  callback = function()
    opt.relativenumber = true
  end,
  desc = "Relative line numbers for Normal mode",
})

vim.api.nvim_create_autocmd({"BufLeave","FocusLost","InsertEnter"}, {
  pattern = "*",
  callback = function()
    opt.relativenumber = false
  end,
  desc = "Absolute line numbers for Insert mode",
})

vim.api.nvim_create_autocmd({"BufReadPost"}, {
  pattern = "*",
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd [[normal g`"]]
    end
  end,
  desc = "Restore cursor position in reopened file",
})

-- tmux window title with current filename
vim.api.nvim_create_autocmd({"BufEnter"}, {
  pattern = "*",
  callback = function()
    if vim.env.TMUX ~= nil then
      vim.cmd [[call system("tmux rename-window '" . expand("%:t") . "'")]]
    end
  end,
  desc = "tmux window title with current filename",
})

-- tmux window title to default
vim.api.nvim_create_autocmd({"VimLeave"}, {
  pattern = "*",
  callback = function()
    if vim.env.TMUX ~= nil then
      vim.cmd [[call system("tmux setw automatic-rename")]]
    end
  end,
  desc = "tmux window title to default",
})

