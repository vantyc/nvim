-- Auto-completion / Snippets
return {
  -- https://github.com/hrsh7th/nvim-cmp
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet engine & associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    -- LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    -- Additional user-friendly snippets
    'rafamadriz/friendly-snippets',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup({})

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
        ['<C-b>'] = cmp.mapping.scroll_docs(-4), -- scroll backward
        ['<C-f>'] = cmp.mapping.scroll_docs(4), -- scroll forward
        ['<C-Space>'] = cmp.mapping.complete {}, -- show completion suggestions
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = cmp.config.sources({
        { name = "supermaven" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = function(entry, vim_item)
          vim_item.menu = ({
            nvim_lsp = "[LSP]",
            luasnip = "[Snippet]",
            buffer = "[Buffer]",
            path = "[Path]",
            supermaven = "[Supermaven]",
          })[entry.source.name]
          return vim_item
        end,
      },
    })

    -- 🔥 Toggle Supermaven
    local supermaven_enabled = true
    vim.keymap.set('n', '<leader>sm', function()
      if supermaven_enabled then
        cmp.setup.buffer({
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          }
        })
        print("🛑 Supermaven Desactivado")
      else
        cmp.setup.buffer({
          sources = {
            { name = "supermaven" },
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          }
        })
        print("✅ Supermaven Activado")
      end
      supermaven_enabled = not supermaven_enabled
    end, { noremap = true, silent = true, desc = "Toggle Supermaven" })

    -- 🔥 Toggle Snippets
    local snippets_enabled = true
    vim.keymap.set('n', '<leader>ss', function()
      if snippets_enabled then
        cmp.setup.buffer({
          sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
          }
        })
        print("🛑 Snippets Desactivados")
      else
        cmp.setup.buffer({
          sources = {
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "buffer" },
            { name = "path" },
          }
        })
        print("✅ Snippets Activados")
      end
      snippets_enabled = not snippets_enabled
    end, { noremap = true, silent = true, desc = "Toggle Snippets" })

  end -- 👈 ESTE ES EL END QUE FALTABA PARA CERRAR FUNCTION
}

