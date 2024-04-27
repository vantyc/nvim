local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
	vim.notify("JDTLS not found, install with `:LspInstall jdtls`")
	return
end

local jdtls_path = "/home/dev/.local/share/nvim/mason/packages/jdtls"
local path_to_lsp_server = jdtls_path .. "/config_linux"
local plugins_path = jdtls_path .. "/plugins/"
-- local path_to_jar = plugins_path .. "org.eclipse.equinox.launcher_1.6.700.v20231214-2017.jar"
-- local path_to_jar = plugins_path .. "org.eclipse.equinox.launcher_*.jar"
local path_to_jar = plugins_path .. "org.eclipse.equinox.launcher_1.6.800.v20240304-1850.jar"
--local path_to_jar = vim.fn.glob("/home/dev/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
local lombok_path = jdtls_path .. "/lombok.jar"

--local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_markers = { ".git", "mvn", "gradle", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
--local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
local workspace_dir = "/home/dev/java/workspace-root/" .. project_name
os.execute("mkdir -p " .. workspace_dir)

-- Main Config
local config = {
	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		-- "/opt/jdk-21.0.1/bin/java",
		-- "/opt/jdk-22/bin/java",
		"/opt/jdk-22/bin/java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. lombok_path,
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens", "java.base/java.util=ALL-UNNAMED",
		"--add-opens", "java.base/java.lang=ALL-UNNAMED",
		"-jar", path_to_jar,
		"-configuration", path_to_lsp_server,
		"-data", workspace_dir,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	root_dir = root_dir,

	-- Here you can configure eclipse.jdt.ls specific settings
	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
	-- for a list of options
	settings = {
		java = {
			--home = '/Users/ivamolaev/Library/Java/JavaVirtualMachines/temurin-18.0.1/Contents/Home/',
			-- home = "/opt/jdk-22/",
			home = "/opt/jdk-22/",
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				runtimes = {
					{
						name = "JavaSE-21",
						--path = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-18.0.1/Contents/Home",
						-- path = "/opt/jdk-22",
						path = "/opt/jdk-21/",
					},
					{
						--name = "JavaSE-17",
						--path = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-17.0.4/Contents/Home",
					},
				},
			},
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			format = {
				enabled = true,
				settings = {
					--url = vim.fn.stdpath("/home/dev/.local/share/nvim/mason/packages/jdtls/intellij-java-google-style.xml"),
					url = "/home/dev/.local/share/nvim/mason/packages/jdtls/intellij-java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
		signatureHelp = { enabled = true },
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
			importOrder = {
				"java",
				"javax",
				"com",
				"org",
			},
		},
		--extendedClientCapabilities = extendedClientCapabilities,
		capabilities = capabilities,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},

	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		bundles = {},
	},
}

config["on_attach"] = function(client, bufnr)
	require("keymaps").map_java_keys(bufnr)
	require("lsp_signature").on_attach({
		bind = true, -- This is mandatory, otherwise border config won't get registered.
		floating_window_above_cur_line = false,
		padding = "",
		handler_opts = {
			border = "rounded",
		},
	}, bufnr)
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require("jdtls").start_or_attach(config)
