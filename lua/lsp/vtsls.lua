--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	local npm = require("util.npm")
	local vue_plugin_path = npm.package_search_path("vue-language-server", "@vue/typescript-plugin")

	vim.lsp.config("vtsls", {
		capabilities = capabilities,
		filetypes = { "typescript", "javascript", "vue", "typescriptreact", "javascriptreact" },
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = {
						{
							name = "@vue/typescript-plugin",
							location = vue_plugin_path,
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
					includeCompletionsForModuleExports = false,
					includeCompletionsForImportStatements = true,
				},
			},
		},
	})
end
