-- LSP Support (Neovim 0.11+ API)
return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    require('mason').setup()

    local servers = {
      'lua_ls',
      'marksman',
      'quick_lint_js',
    }

    require('mason-lspconfig').setup({
      ensure_installed = servers,
      automatic_enable = false,
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'java-debug-adapter',
        'java-test',
      },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    if vim.fn.has('nvim-0.11') == 1 then
      -- Neovim 0.11+ API
      for _, server_name in ipairs(servers) do
        if server_name ~= 'jdtls' then
          local opts = { capabilities = capabilities }
          if server_name == 'lua_ls' then
            opts.settings = {
              Lua = { diagnostics = { globals = { 'vim' } } },
            }
          end
          vim.lsp.config(server_name, opts)
          vim.lsp.enable(server_name)
        end
      end
    else
      -- Fallback for Neovim < 0.11
      local lspconfig = require('lspconfig')
      for _, server_name in ipairs(servers) do
        if server_name ~= 'jdtls' then
          local opts = { capabilities = capabilities }
          if server_name == 'lua_ls' then
            opts.settings = {
              Lua = { diagnostics = { globals = { 'vim' } } },
            }
          end
          lspconfig[server_name].setup(opts)
        end
      end
    end

    -- Globally configure LSP floating preview popups
    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or 'rounded'
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end,
}
