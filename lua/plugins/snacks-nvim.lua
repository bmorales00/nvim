-- lazy.nvim
return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- Core Modeules
		dashboard = { enabled = true },

		-- QoL Modules
		zen = { enabled = true },
		indent = { enabled = true },

		-- Image
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
}
