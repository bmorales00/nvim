-- Configs for LSP client
local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.icons").diagnostic_signs
local severity = vim.diagnostic.severity

local config = function()
	require("neoconf").setup({})

	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local capabilities = cmp_nvim_lsp.default_capabilities()

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
						-- vim.fn.stdpath("config") .. "/lua",
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

	----------------------------------- typescript
	lspconfig.ts_ls.setup({
		on_attach = on_attach,
		capabilities = capabilities,
		filetypes = {
			"typescript",
		},
		root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "git"),
	})

	--------------------------------------- python

	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			pyright = {
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

	------------------------------------------ css,sass,scss,html
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
		capabilities = capabilities,
		on_attach = on_attach,
		init_options = {
			provideFormatter = true,
		},
		filetypes = {
			"htmlangular",
			"html",
			".git",
		},
	})

	lspconfig.cssls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			css = {
				validate = true,
			},
			scss = {
				validate = true,
			},
			less = {
				validate = true,
			},
		},
	})

	------------------------------------------------ Java LSP
	lspconfig.jdtls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = {
			java = {
				configuration = {
					runtimes = {
						name = "JavaSE-21",
						path = "/opt/jdk-21",
						default = true,
					},
				},
			},
		},
	})

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
	vim.diagnostic.config({ signs = signs })

	-- linters and formatters
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	local flake8 = require("efmls-configs.linters.flake8")
	local black = require("efmls-configs.formatters.black")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier_d = require("efmls-configs.formatters.prettier_d")

	-- configure efm server

	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"python",
			"typescript",
			"json",
			"jsonc",
			"html",
			"css",
			"markdown",
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
				python = { flake8, black },
				typescript = { eslint_d, prettier_d },
				html = { prettier_d },
				css = { prettier_d },
				markdown = { prettier_d },
			},
		},
	})

	------------------------------------------------------------  angular ls

	-- lspconfig.angularls.setup({
	-- capabilities = capabilities,
	-- on_attach = on_attach,
	-- })
end

return {
	"neovim/nvim-lspconfig",
	-- event = { "BufReadPost", "BufNewFile" },
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
