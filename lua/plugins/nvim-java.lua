local config = function()
	require("java").setup({})
	require("lspconfig").jdtls.setup({})
end

return {
	"nvim-java/nvim-java",
	lazy = false,
	config = config,
}
