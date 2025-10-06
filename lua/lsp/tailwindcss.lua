--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("tailwindcss", {
		capabilities = capabilities,
		settings = {
			tailwindCSS = {
				experimental = {
					configFile = "src/assets/main.css",
					-- This is to allow intellisense to operate on V4
					-- main path to css/scss file that contains @import "tailwindcss"
					-- Add a path to the import tailwind file here
				},
			},
		},
		filetypes = {
			"templ",
			"typescript",
			"javascript",
			"html",
			"htmlangular",
			"vue",
		},
	})
end
