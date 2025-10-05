return {
	{
		"nvim-mini/mini.nvim",
		version = false, -- Using the latest stable branch
		lazy = false, -- Only load plugins that are needed

		-- Key Triggers for desired modules
		keys = {
			-- mini.ai
			{ "i", mode = "o" },
			{ "a", mode = "o" },

			-- mini.comment
			{ "gc", mode = { "n", "v" } },

			-- mini.move
			{ "<A-j>", mode = { "n", "i", "v" } },
			{ "<A-k>", mode = { "n", "i", "v" } },

			-- mini.surround
			{ "s", mode = { "n", "v" } },
		},
		cmd = {
			-- mini.bufremove
			"Bdelete",
		},
		event = {
			-- Delayed event for modules that are critical but not startup critical
			"VeryLazy",
		},

		-- Config: Desired Modules
		config = function()
			-- Core
			require("mini.ai").setup({})
			require("mini.comment").setup({ mappings = { comment = "gc" } })
			require("mini.move").setup({})
			require("mini.surround").setup({})

			-- Utility
			require("mini.cursorword").setup({})
			require("mini.indentscope").setup({ animation = { enable = false, duration = 10, easing = "linear" } })
			require("mini.pairs").setup({})
			require("mini.bufremove").setup({})
			-- Icons
			require("mini.icons").setup({})
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
}
