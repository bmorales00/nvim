return {
	{
		"rachartier/tiny-cmdline.nvim",
		-- cmdheight = 0 is set in config/options.lua before lazy loads plugins.
		config = function()
			require("tiny-cmdline").setup({
				native_types = {},
				title = {
					enabled = true,
				},
			})
		end,
	},
}
