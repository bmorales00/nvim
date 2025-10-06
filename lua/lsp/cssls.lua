--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("cssls", {
		capabilities = capabilities,
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
end
