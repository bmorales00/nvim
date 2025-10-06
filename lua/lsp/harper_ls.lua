--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("harper_ls", {
		capabilities = capabilities,
		enabled = true,
		filetypes = {
			"markdown",
		},
		settings = {
			["harper-ls"] = {
				userDictPath = "~/dict.txt",
				linters = {
					ToDoHyphen = false,
					SpellCheck = true,
				},
				-- isolateEnglish = true,
				diagnosticSeverity = "hint",
			},
		},
	})
end
