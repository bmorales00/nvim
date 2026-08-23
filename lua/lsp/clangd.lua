--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("clangd", {
		capabilities = capabilities,
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--completion-style=detailed",
		},
		root_markers = {
			".clangd",
			".clang-tidy",
			".clang-format",
			"compile_commands.json",
			"compile_flags.txt",
			"configure.ac", -- AutoTools
			".git",
		},
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
	})
end
