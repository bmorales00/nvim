-- Configs for LSP client
local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.icons").diagnostic_signs
local severity = vim.diagnostic.severity

local config = function()
	require("neoconf").setup({})

	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local util = require("lspconfig.util")
	local capabilities = cmp_nvim_lsp.default_capabilities()

	local function is_angular_project(fname) --helper function to find patter file in parent root
		return util.root_pattern("angular.json")(fname)
	end

	--------------------------------- bash

	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh", "aliasrc" },
	})

	----------------------------------- lua
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.fn.expand("$VIMRUNTIME/lua"),
						vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
					},
				},
			},
		},
	})

	---------------------------------- json
	lspconfig.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "json", "jsonc" },
	})

	----------------------------------- vtsls (ts)
	--- vue_ls path
	local vue_language_server_path = vim.fn.stdpath("data")
		.. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

	lspconfig.vtsls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
			"javascript",
			"vue",
		},
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
							configNamespace = "typescript",
						},
					},
				},
			},
		},
	})

	----------------------------------- vue_ls (volar)

	--- works in hybrid mode alongside vtsls
	--- When you are editing the <script> block of a .vue file, Volar forwards the code and your actions (like asking for autocompletion)
	--- to the vtsls server. vtsls processes it and sends the result back to Volar, which then displays it in your editor.

	lspconfig.volar.setup({
		on_init = function(client)
			client.handlers["tsserver/request"] = function(_, result, context)
				local clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = "vtsls" })
				if #clients == 0 then
					vim.notify(
						"Could not find `vtsls` lsp client, vue_lsp will not work without it!",
						vim.log.levels.ERROR
					)
					return
				end
				local ts_client = clients[1]

				local param = unpack(result)
				local id, command, payload = unpack(param)
				ts_client:exec_cmd({
					title = "vue_request_forward", -- You can give title anything as it's used to represent a command in the UI, `:h Client:exec_cmd`
					command = "typescript.tsserverRequest",
					arguments = {
						command,
						payload,
					},
				}, { bufnr = context.bufnr }, function(_, r)
					local response_data = { { id, r.body } }
					---@diagnostic disable-next-line: param-type-mismatch
					client:notify("tsserver/response", response_data)
				end)
			end
		end,
		settings = {
			typescript = {
				inlayHints = {
					enumMemberValues = {
						enabled = true,
					},
					functionLikeReturnTypes = {
						enabled = true,
					},
					propertyDeclarationTypes = {
						enabled = true,
					},
					parameterTypes = {
						enabled = true,
						suppressWhenArgumentMatchesName = true,
					},
					variableTypes = {
						enabled = true,
					},
				},
			},
		},
	})

	--------------------------------------- python

	lspconfig.basedpyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			basedpyright = {
				disableOrganizeImports = false,
				analysis = {
					useLibraryCodeForTypes = true,
					autoSearchPaths = true,
					diagnosticMode = "workspace",
					autoImportCompletions = true,
					typeCheckingMode = "basic",
				},
			},
		},
	})

	------------------------------------------ emmetls
	lspconfig.emmet_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"css",
			"scss",
			"sass",
			"less",
			"html",
		},
	})

	-------------------------------- HTML LSP
	lspconfig.html.setup({
		filetypes = {
			"htmlangular",
			"html",
		},
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {},
		init_options = {
			provideFormatter = true,
			embeddedLanguages = { css = true, typescript = true },
			configurationSection = { "html", "css" },
		},
	})

	------------------------------------------ cssls
	-- lspconfig.cssls.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- 	settings = {
	-- 		css = {
	-- 			validate = true,
	-- 		},
	-- 		scss = {
	-- 			validate = true,
	-- 		},
	-- 		less = {
	-- 			validate = true,
	-- 		},
	-- 	},
	-- })
	--
	------------------------------------------ tailwindcss
	lspconfig.tailwindcss.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			tailwindCSS = {
				experimental = {
					configFile = "src/styles.scss", -- This is to allow intellisense to operate on V4
				}, -- main path to css/scss file that contains @import "tailwindcss"
			},
		},
		filetypes = {
			"templ",
			"typescript",
			"javascript",
			"html",
			"htmlangular",
		},
	})

	------------------------------------------------ Java LSP
	--- Can uncomment whenever I need to setup/use Java
	---
	-- lspconfig.jdtls.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = on_attach,
	-- 	settings = {
	-- 		java = {
	-- 			configuration = {
	-- 				runtimes = {
	-- 					name = "JavaSE-21",
	-- 					path = "/opt/jdk-21",
	-- 					default = true,
	-- 				},
	-- 			},
	-- 		},
	-- 	},
	-- })
	--

	-----------------------------------------------------  angular ls

	lspconfig.angularls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
		root_dir = util.root_pattern("angular.json"),
	})

	-----------------------------------------------------  markdown

	lspconfig.marksman.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "markdown", "markdown.mdx" },
		root_markers = { ".marksman.toml", ".git" },
	})

	-----------------------------------------------------  harper language server

	lspconfig.harper_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		enabled = true,
		filetypes = {
			"markdown",
		},
		settings = {
			["harper-ls"] = {
				userDictPath = "~/dict.txt",
				linters = {
					ToDoHyphen = false,
					SpellCheck = true,
				},
				-- isolateEnglish = true,
				diagnosticSeverity = "hint",
			},
		},
	})

	----------------------------------------- Diagnostic Icons

	-- icon display
	local signs = {
		text = {},
		linehl = {},
		numhl = {},
	}

	for type, icon in pairs(diagnostic_signs) do
		-- local hl = "DiagnosticSign" .. type
		-- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		signs.text[severity[icon.name]] = icon.text
		signs.linehl[severity[icon.name]] = ""
		signs.numhl[severity[icon.name]] = icon.hl
	end

	vim.diagnostic.config({
		signs = signs,
		float = {
			relative = "editor",
			border = "rounded",
		},
		update_in_insert = true,
	})

	--------------------------------------------------------------------------------------------------

	-- linters and formatters
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local ruff_lint = require("efmls-configs.linters.ruff")
	local ruff_form = require("efmls-configs.formatters.ruff")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier_d = require("efmls-configs.formatters.prettier_d")

	-- configure efm server

	lspconfig.efm.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = {
			"lua",
			"python",
			"typescript",
			"json",
			"jsonc",
			"html",
			-- "css",
			"markdown",
			"htmlangular",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				python = { ruff_lint, ruff_form },
				typescript = { eslint_d, prettier_d },
				html = { prettier_d },
				htmlangular = { prettier_d },
				-- css = { prettier_d },
				markdown = { prettier_d },
			},
		},
	})
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	config = config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
