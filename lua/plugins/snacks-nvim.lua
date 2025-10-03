-- lazy.nvim
return {
	"folke/snacks.nvim",
	lazy = false,
	---@type snacks.Config
	config = function()
		require("snacks").setup({
			styles = {
				snacks_image = {
					relative = "editor",
					col = -1,
				},
			},
			image = {
				enabled = true,
				doc = {
					inline = false,
					float = true,
				},
			},
			opts = {
				-- your image configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		})
	end,
}
