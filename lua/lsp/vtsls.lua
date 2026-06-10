--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	--- vue_ls path
	local vue_language_server_path = vim.fn.expand("$MASON/packages")
		.. "/vue-language-server"
		.. "/node_modules/@vue/language-server"

	vim.lsp.config("vtsls", {
		capabilities = capabilities,
		filetypes = { "typescript", "javascript", "vue", "typescriptreact", "javascriptreact" },
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_language_server_path,
							languages = { "vue" },
							configNamespace = "typescript",
							enableForWorkspaceTypeScriptVersions = true,
						},
					},
				},
			},
			typescript = {
				updateImportsOnFileMove = { enabled = "always" },
				suggest = {
					autoImportSuggestions = true,
					completeFunctionCalls = true,
					includeCompletionsForModuleExports = true,
					includeCompletionsForImportStatements = true,
				},
				preferences = {
					importModuleSpecifier = "non-relative",
					preferTypeOnlyAutoImports = true,
				},
			},
			javascript = {
				preferences = {
					importModuleSpecifier = "non-relative",
				},
			},
		},
	})
end
