-- Configs for LSP client

return {
	"neovim/nvim-lspconfig",
	config = function()
		require("util.icons").setup()
		require("lsp")
	end,
	dependencies = {
		"saghen/blink.cmp",
		"creativenull/efmls-configs-nvim",
	},
}
