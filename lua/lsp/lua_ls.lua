--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						vim.env.VIMRUNTIME .. "/lua",
						vim.fn.stdpath("config") .. "/lua",
					},
				},
			},
		},
	})
end
