-- Configs for LSP client

-- local on_attach = require("util.lsp").on_attach

return {
	"neovim/nvim-lspconfig",
	config = function ()
    require("util.icons").setup()
    require("lsp")
end,
	dependencies = {
    {"mason-org/mason.nvim", opts = {}},
		"creativenull/efmls-configs-nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
}
