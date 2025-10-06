--- @param capabilities table LSP client capabilities (this references nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	local util = require("lspconfig.util")

	local function is_angular_project(fname) --helper function to find patter file in parent root
		return util.root_pattern("angular.json")(fname)
	end

	vim.lsp.config("angularls", {
		capabilities = capabilities,
		filetypes = { "typescript", "html", "typescriptreact", "htmlangular" },
		root_dir = util.root_pattern("angular.json"),
	})
end
