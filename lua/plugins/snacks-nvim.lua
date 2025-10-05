-- snack plugins for nvim

local snackKeys = {
	{
		"<leader>z",
		function()
			Snacks.zen()
		end,
		desc = "Toggle Zen Mode",
	},
	{
		"<leader>Z",
		function()
			Snacks.zen.zoom()
		end,
		desc = "Toggle Zoom",
	},
}

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Core Modules
		dashboard = { enabled = true },

		-- QoL Modules
		zen = { enabled = true, backdrop = { transparent = false } },
		indent = { enabled = true },

		-- Image Module
		image = { enabled = true },
		image = { max_height = 20, doc = { inline = false, float = true } },

		-- Styles for modules
		styles = {
			snacks_image = {
				relative = "editor",
				col = -1,
				row = -1,
				border = "rounded",
			},
		},
	},
	keys = snackKeys,
}
