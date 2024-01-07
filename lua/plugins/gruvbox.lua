return {
	"ellisonleao/gruvbox.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		--	vim.o.background = "hard"
		require("gruvbox").setup({
			terminal_colors = true,
			bold = true,
			--	contrast = "hard",
		})
		vim.cmd("colorscheme gruvbox")
	end,
}
