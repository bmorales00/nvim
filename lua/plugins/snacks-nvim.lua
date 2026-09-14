return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- QoL Modules
		indent = { enabled = true },

		-- Image Module
		image = { enabled = true, max_height = 20, doc = { inline = false, float = true } },

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
