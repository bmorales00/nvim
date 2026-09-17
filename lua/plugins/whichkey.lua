-- WhichKey is a popup menu that shows the keybindings available in the current mode.
return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		win = {
			width = 0.25,
			col = 0.99,
			border = "rounded",
		},
	},
}
