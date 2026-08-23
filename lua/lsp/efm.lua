--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	-- linters and formatters
	local stylua = require("efmls-configs.formatters.stylua")
	local ruff_lint = require("efmls-configs.linters.ruff")
	local ruff_form = require("efmls-configs.formatters.ruff")
	local eslint_d = require("efmls-configs.linters.eslint_d")
	local prettier_d = require("efmls-configs.formatters.prettier_d")
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	vim.lsp.config("efm", {
		capabilities = capabilities,
		filetypes = {
			"css",
			"html",
			"javascript",
			"javascriptreact",
			"json",
			"jsonc",
			"less",
			"lua",
			"python",
			"scss",
			"sh",
			"typescript",
			"typescriptreact",
			"vue",
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
		},
		settings = {
			languages = {
				css = { prettier_d },
				html = { prettier_d },
				javascript = { eslint_d, prettier_d },
				javascriptreact = { eslint_d, prettier_d },
				json = { prettier_d },
				jsonc = { prettier_d },
				less = { prettier_d },
				lua = { stylua },
				python = { ruff_lint, ruff_form },
				scss = { prettier_d },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				typescriptreact = { eslint_d, prettier_d },
				vue = { prettier_d },
			},
		},
	})
end
