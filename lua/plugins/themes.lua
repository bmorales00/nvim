return {
	"bmorales00/theme.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("config.theme").setup()
	end,
}
