--- works in hybrid mode alongside vtsls
--- When you are editing the <script> block of a .vue file,
--- Volar forwards the code and your actions (like asking for autocompletion)
--- to the vtsls server. vtsls processes it and sends the result back to Vue_ls, which then displays it in your editor.

--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return boolean configured
--- @return string? error
return function(capabilities)
	local npm = require("util.npm")
	if vim.fn.executable("vue-language-server") == 0 then
		return false, "executable not found: vue-language-server"
	end

	local typescript_path, err = npm.try_package_root("vtsls", "typescript")
	if not typescript_path then
		return false, err
	end
	local tsdk_path = vim.fs.joinpath(typescript_path, "lib")

	vim.lsp.config("vue_ls", {
		capabilities = capabilities,
		cmd = { "vue-language-server", "--stdio", "--tsdk=" .. tsdk_path },
		settings = {
			typescript = {
				inlayHints = {
					enumMemberValues = {
						enabled = true,
					},
					functionLikeReturnTypes = {
						enabled = true,
					},
					propertyDeclarationTypes = {
						enabled = true,
					},
					parameterTypes = {
						enabled = true,
						suppressWhenArgumentMatchesName = true,
					},
					variableTypes = {
						enabled = true,
					},
				},
			},
		},
	})

	return true
end
