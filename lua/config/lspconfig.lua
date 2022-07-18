local loaded, nvim_lsp = pcall(require, "lspconfig")
if not loaded then
  return
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false
    }
  )

  -- Setup solid borders of diagnostic messages float window
  vim.diagnostic.open_float = (function(orig)
    return function(opts)
      if not opts then opts = {} end
      local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
      -- A more robust solution would check the "scope" value in `opts` to
      -- determine where to get diagnostics from, but if you're only using
      -- this for your own purposes you can make it as simple as you like
      local diagnostics = vim.diagnostic.get(opts.bufnr or 0, {lnum = lnum})
      opts.border = {
        { "╭" },
        { "─" },
        { "╮" },
        { "│" },
        { "╯" },
        { "─" },
        { "╰" },
        { "│" },
      }
      orig(opts)
    end
  end)(vim.diagnostic.open_float)

  -- formatting with motion
  function format_range_operator()
    local old_func = vim.go.operatorfunc
    _G.op_func_formatting = function()
      local start = vim.api.nvim_buf_get_mark(0, '[')
      local finish = vim.api.nvim_buf_get_mark(0, ']')
      vim.lsp.buf.range_formatting({}, start, finish)
      vim.go.operatorfunc = old_func
      _G.op_func_formatting = nil
    end
    vim.go.operatorfunc = 'v:lua.op_func_formatting'
    vim.api.nvim_feedkeys('g@', 'n', false)
  end

  -- formatting selected
  -- function format_range_visual()
  --   local ls = vim.fn.line("'<")
  --   local le = vim.fn.line("'>")
  --   local cs = vim.fn.col("'<")
  --   local ce = vim.fn.col("'>")
  --   vim.lsp.buf.range_formatting({}, {ls,cs}, {le,ce})
  -- end

  vim.api.nvim_set_keymap("n", "<leader>=", "<cmd>lua format_range_operator()<CR>", {noremap = true})
  -- vim.api.nvim_set_keymap("v", "<leader>=", "<C-[><cmd>lua format_range_visual()<CR>", {noremap = true})
  vim.api.nvim_set_keymap("v", "<leader>=", "<C-[><cmd>lua vim.lsp.buf.range_formatting()<CR>", {noremap = true})

  -- Format on save
  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_command [[augroup Format]]
    vim.api.nvim_command [[autocmd! * <buffer>]]
    vim.api.nvim_command [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()]]
    vim.api.nvim_command [[augroup END]]
  end
end

-- typescript/javascript language server
-- Installed as node package
-- npm -g i typescript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  }
}

--Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true

-- html language server
-- Installed as node package
-- npm i -g vscode-langservers-extracted
nvim_lsp.html.setup {
  on_attach = on_attach,
  -- capabilities = capabilities,
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  init_options = {
    provideFormatter = true,
    -- configurationSection = { "html", "css", "javascript" },
    configurationSection = { "html", "javascript" },
    embeddedLanguages = {
      css = false,
      javascript = true
    }
  },
}

-- diagnostic-languageserver
-- Installed as node package
-- yarn global add diagnostic-languageserver
nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = {
    'javascript',
    'javascriptreact',
    'json',
    'typescript',
    'typescriptreact',
    'less',
    'markdown',
    'pandoc',
    'dart',
    'python',
    'html' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
      json = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'prettier',
      javascript = 'prettier',
      -- javascriptreact = 'eslint_d',
      -- javascriptreact = 'eslint_d',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      -- typescript = 'eslint_d',
      -- typescriptreact = 'eslint_d',
      typescript = 'prettier',
      typescriptreact = 'prettier',
      json = 'prettier',
      markdown = 'prettier',
    }
  }
}

