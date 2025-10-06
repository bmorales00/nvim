local config = function()
	require("java").setup({})
end

return {
	"nvim-java/nvim-java",
	lazy = true,
	config = config,
}
