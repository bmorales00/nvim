-- toggle term for nvim
return {
	"akinsho/toggleterm.nvim",
	lazy = true,
	version = "*",
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-\>]],
			shade_terminals = false,
			shell = "zsh --login",
		})
	end,
	keys = {
		{ [[<C-\>]] },
		{ "<leader>cf", "<cmd>ToggleTerm siize=40 direction=float<cr>", desc = "Open Float Terminal" },
	},
}
