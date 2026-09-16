return {
	{
		"nvim-mini/mini.nvim",
		version = false, -- Using the latest stable branch
		lazy = false, -- Only load plugins that are needed

		-- Key Triggers for desired modules
		keys = {
			-- mini.move
			{ "<A-j>", mode = { "n", "i", "v" } },
			{ "<A-k>", mode = { "n", "i", "v" } },
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
			require("mini.move").setup({})
			require("mini.surround").setup({
				mappings = {
					add = "ys",
					delete = "ds",
					find = "",
					find_left = "",
					highlight = "",
					replace = "cs",
					suffix_last = "",
					suffix_next = "",
				},
				search_method = "cover_or_next",
			})

			-- Match vim-surround's Visual `S` and linewise `yss` mappings.
			vim.keymap.del("x", "ys")
			vim.keymap.set("x", "S", [[:<C-u>lua MiniSurround.add("visual")<CR>]], { silent = true })
			vim.keymap.set("n", "yss", "ys_", { remap = true })

			-- Utility
			require("mini.cursorword").setup({})
			require("mini.pairs").setup({})
			require("mini.bufremove").setup({})
			-- Icons
			require("mini.icons").setup({})
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
}
