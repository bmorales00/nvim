--- @param capabilities table LSP client capabilities (for blink-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("ansiblels", {
		capabilities = capabilities,
	})
end
