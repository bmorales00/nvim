--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("tailwindcss", {
		capabilities = capabilities,
	})
end
