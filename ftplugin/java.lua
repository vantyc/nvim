-- JDTLS (Java LSP) configuration
local jdtls = require('jdtls')

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.env.HOME .. '/jdtls-workspace/' .. project_name

local bundles = {
  vim.fn.glob(vim.env.HOME .. '/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar'),
}

vim.list_extend(bundles, vim.split(vim.fn.glob(vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar", true), "\n"))

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. vim.env.HOME .. '/.local/share/nvim/mason/share/jdtls/lombok.jar',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.env.HOME .. '/.local/share/nvim/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar',
    '-configuration', vim.env.HOME .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
    '-data', workspace_dir
  },

  root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'pom.xml', 'build.gradle' }),

  settings = {
    java = {
      home = os.getenv("JAVA_HOME"),
      eclipse = { downloadSources = true },
      configuration = { updateBuildConfiguration = "interactive" },
      maven = { downloadSources = true },
      implementationsCodeLens = { enabled = true },
      referencesCodeLens = { enabled = true },
      references = { includeDecompiledSources = true },
      signatureHelp = { enabled = true },
      format = { enabled = true },
    },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = { "java", "javax", "com", "org" },
    },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
  },

  capabilities = capabilities,
  flags = { allow_incremental_sync = true },
  init_options = { bundles = bundles },
}

config.on_attach = function(client, bufnr)
  jdtls.setup_dap({ hotcodereplace = 'auto' })

  -- 🔥 Desactivado porque provoca:
  -- No LSP client found that supports vscode.java.resolveMainClass
  -- require('jdtls.dap').setup_dap_main_class_configs()

  vim.keymap.set('n', '<leader>df', function() require('jdtls').test_class() end, { buffer = bufnr })
  vim.keymap.set('n', '<leader>dn', function() require('jdtls').test_nearest_method() end, { buffer = bufnr })
end

vim.schedule(function()
  jdtls.start_or_attach(config)
end)
