local loaded, comment = pcall(require, 'Comment')
if not loaded then
  return
end

local config = {
  mappings = {
    basic = true,
    extra = false,
    extended = false,
  },
}

comment.setup(config)
-- Additional keys mapping
vim.api.nvim_set_keymap("n", "cc", "gcc", {})
vim.api.nvim_set_keymap("v", "cc", "gc", {})
vim.api.nvim_set_keymap("n", "cb", "gbc", {})
vim.api.nvim_set_keymap("v", "cb", "gbc", {})
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", {})
vim.api.nvim_set_keymap("v", "<C-_>", "gc", {})

local ft = require('Comment.ft')
local api = require('Comment.api')

function mixedContentComment()
  if not vim.bo.filetype == 'javascript'
    and not vim.bo.filetype == 'html' then
    return ft.lang(vim.bo.filetype)
  end
  local config = require('Comment.config'):get()
  config.pre_hook = function(ctx)
    if vim.bo.filetype == 'javascript' then
      return '{/* %s */}'
    elseif vim.bo.filetype == 'html' then
      return '// %s'
    end
  end
  local mode = vim.api.nvim_get_mode().mode
  if mode == 'n' then -- normal mode
    api.toggle_current_linewise(config)
  else -- visual mode
    -- Swith to Normal mode to make Current selection to be Last selection
    vim.cmd(vim.api.nvim_replace_termcodes('normal <ESC>', true, true, true))
    -- comment last selected block
    api.toggle_linewise_op(vim.fn.visualmode(),config)
  end
end

vim.api.nvim_set_keymap("n", "<leader>c", "", {
  callback = mixedContentComment,
})
vim.api.nvim_set_keymap("v", "<leader>c", "", {
  callback = mixedContentComment,
})
