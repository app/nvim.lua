local M = {}

function M.setup()

  local loaded, treeSitter = pcall(require, 'nvim-treesitter.configs')
  if not loaded then
    return
  end

  local config = {
    -- A list of parser names, or "all" for all available
    ensure_installed = { "c", "lua", "javascript", "html", "css", "bash", "json" },

    incremental_selection = {
      enable = true,
      keymaps = {
        node_incremental = ".",
        node_decremental = "u",
      },
    },
  }

  treeSitter.setup(config)

end

return M
