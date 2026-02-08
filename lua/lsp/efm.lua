--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	-- linters and formatters
	local luacheck = require("efmls-configs.linters.luacheck")
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
      -- "c",
			"css",
			"html",
			"htmlangular",
			"lua",
			"markdown",
			"python",
			"sh",
			"typescript",
			"vue",
			"json",
			"jsonc",
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
				css = { prettier_d },
				html = { prettier_d },
				htmlangular = { prettier_d },
				lua = { luacheck, stylua },
				-- markdown = { prettier_d },
				python = { ruff_lint, ruff_form },
				sh = { shellcheck, shfmt },
				typescript = { eslint_d, prettier_d },
				vue = { prettier_d },
			},
		},
	})
end
