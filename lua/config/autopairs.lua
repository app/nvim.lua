local M = {}

function M.setup()
  local loaded, autopairs = pcall(require, "nvim-autopairs")
  if not loaded then
    return
  end

  autopairs.setup()
end

return M
