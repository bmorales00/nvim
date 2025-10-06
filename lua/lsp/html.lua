--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("html", {
		capabilities = capabilities,
		filetypes = { "html", "htmlangular" },
		settings = {},
		init_options = {
			provideFormatter = true,
			embeddedLanguages = { css = true, typescript = true },
			configurationSection = { "html", "css" },
		},
	})
end
