local loaded, fzfLua = pcall(require, "fzf-lua")
if not loaded then
  return
end

fzfLua.setup {
  winopts = {
    width = 0.90,
    preview = {
      layout='vertical',
      vertical = 'down:40%',
    },
  },

}

-- Remap leader and local leader to <Space>
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.timeoutlen = 300 -- Time in milliseconds to wait for a mapped sequence to complete.

vim.api.nvim_set_keymap( 'n', '<c-p>', ":FzfLua files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', '<c-o>', ":FzfLua git_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', '<c-b>', ":FzfLua buffers<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap( 'n', "<leader>r", ":FzfLua lsp_references<CR>", { noremap = true, silent = true })
