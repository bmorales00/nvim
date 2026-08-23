--- works in hybrid mode alongside vtsls
--- When you are editing the <script> block of a .vue file,
--- Volar forwards the code and your actions (like asking for autocompletion)
--- to the vtsls server. vtsls processes it and sends the result back to Vue_ls, which then displays it in your editor.

--- @param capabilities table LSP client capabilities (for nvim-cmp or something similar)
--- @return nil
return function(capabilities)
	local npm = require("util.npm")
	local typescript_path = npm.package_root("vtsls", "typescript")
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
end
