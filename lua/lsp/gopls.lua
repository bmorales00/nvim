--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("gopls", {
		capabilities = capabilities,
		settings = {
			gopls = {
				gofumpt = true, -- replaces efm gofumpt
				staticcheck = true, -- replaces golangci-lint (default in new gopls, keep explicit)
				usePlaceholders = true, -- struct/param completion inserts placeholders
				directoryFilters = { "-vendor" },
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
			},
		},
	})
end
