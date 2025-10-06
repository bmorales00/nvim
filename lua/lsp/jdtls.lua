--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	vim.lsp.config("jdtls", {
		capabilities = capabilities,
		settings = {
			java = {
				configuration = {
					runtimes = {
						name = "JavaSE-21",
						path = "/opt/jdk-21",
						default = true,
					},
				},
			},
		},
	})
end
