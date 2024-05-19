return {
	{
		"williamboman/mason.nvim",
        lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
        lazy = false,
        opts = {
            auto_install = true,
        },
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "jdtls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
        lazy = false,
		config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

			local lspconfig = require("lspconfig")
            local util = require("lspconfig/util")

            lspconfig.gopls.setup{
                on_attach = on_attach,
                capabilities = capabilities,
                cmd = {"gopls"},
                filetypes = {"go", "gomod", "goowrk", "gotmpl"},
                root_dir = util.root_pattern("go.work","go.mod","git"),
            }
			--lspconfig.jdtls.setup({
             --  capabilities = capabilities
            --})
			lspconfig.lua_ls.setup({
                capabilities = capabilities
            })


			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
