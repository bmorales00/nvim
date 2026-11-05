--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return boolean vue_plugin_available
--- @return string? error
return function(capabilities)
	local npm = require("util.npm")
	local vue_plugin_path, vue_plugin_error =
		npm.try_package_search_path("vue-language-server", "@vue/typescript-plugin")
	local filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }
	local global_plugins = {}

	if vue_plugin_path then
		table.insert(filetypes, "vue")
		table.insert(global_plugins, {
			name = "@vue/typescript-plugin",
			location = vue_plugin_path,
			languages = { "vue" },
			configNamespace = "typescript",
			enableForWorkspaceTypeScriptVersions = true,
		})
	end

	vim.lsp.config("vtsls", {
		capabilities = capabilities,
		filetypes = filetypes,
		settings = {
			vtsls = {
				tsserver = {
					globalPlugins = global_plugins,
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

	return vue_plugin_path ~= nil, vue_plugin_error
end
