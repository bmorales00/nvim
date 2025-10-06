--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("marksman", {
		capabilities = capabilities,
		filetypes = { "markdown", "markdown.mdx" },
		root_markers = { ".marksman.toml", ".git" },
	})
end
