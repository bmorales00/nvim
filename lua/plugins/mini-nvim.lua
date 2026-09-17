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
		event = {
			-- Delayed event for modules that are critical but not startup critical
			"VeryLazy",
		},

		-- Config: Desired Modules
		config = function()
			local miniclue = require("mini.clue")
			-- KeyMap Popup
			miniclue.setup({
				triggers = {
					-- Leader
					{ mode = { "n", "x" }, keys = "<Leader>" },

					-- Built-in
					{ mode = "n", keys = "[" },
					{ mode = "n", keys = "]" },
					{ mode = { "n", "x" }, keys = "g" },
					{ mode = { "n", "x" }, keys = "z" },

					--Marks
					{ mode = { "n", "x" }, keys = "'" },
					{ mode = { "n", "x" }, keys = "`" },

					-- Registers
					{ mode = { "n", "x" }, keys = '"' },
					{ mode = { "i", "c" }, keys = "<C-r>" },

					-- Window Commands
					{ mode = "n", keys = "<C-w>" },

					-- Completeion
					{ mode = "i", keys = "<C-x>" },
				},

				clues = {
					miniclue.gen_clues.square_brackets(),
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
					{ mode = "n", keys = "<Leader>b", desc = "+Buffers" },
					{ mode = "n", keys = "<Leader>g", desc = "+LSP" },
					{ mode = "n", keys = "<Leader>h", desc = "+Harpoon" },
					{ mode = "n", keys = "<Leader>n", desc = "+Diagnostics" },
					{ mode = "n", keys = "<Leader>o", desc = "+Organize" },
					{ mode = "n", keys = "<Leader>s", desc = "+Splits" },
					{ mode = "n", keys = "<Leader>t", desc = "+Trouble" },
				},
				window = {
					delay = 300,
					config = {
						anchor = "SE",
						row = "auto",
						col = "auto",
						width = "auto",
						border = "rounded",
					},
				},
			})

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
			vim.keymap.set(
				"x",
				"S",
				[[:<C-u>lua MiniSurround.add("visual")<CR>]],
				{ silent = true, desc = "Add surrounding" }
			)
			vim.keymap.set("n", "yss", "ys_", { remap = true, desc = "Surround line" })

			-- Utility
			require("mini.cursorword").setup({})
			require("mini.pairs").setup({})
			-- Icons
			require("mini.icons").setup({})
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
}
