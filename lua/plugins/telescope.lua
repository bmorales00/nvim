local keymap = vim.keymap

local config = function()
	local telescope = require("telescope")
	telescope.setup({
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		pickers = {
			find_files = {
				file_ignore_patterns = { "node_modules", ".venv" },
				additional_args = function(_)
					return { "--hidden", "--no-ignore-vcs" }
				end,
				no_ignore = true,
				hidden = true,
			},
			live_grep = {
				file_ignore_patterns = { "node_modules", ".venv" },
				additional_args = function(_)
					return { "--hidden", "--no-ignore-vcs" }
				end,
				hidden = true,
				no_ignore = true,
			},
		},
    extensions = {
      "fzf",
    },
	})
  telescope.load_extension("fzf")
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.3",
	lazy = false,
	dependencies ={{ "nvim-lua/plenary.nvim" },
    {"nvim-telescope/telescope-fzf-native.nvim", build = "make"},},
	config = config,
	keys = {
		keymap.set("n", "<leader>fk", ":Telescope keymaps<CR>"),
		keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>"),
		keymap.set("n", "<leader>ff", ":Telescope find_files<CR>"),
		keymap.set("n", "<leader>fa", ":Telescope <CR>"),
		keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>"),
		keymap.set("n", "<leader>fb", ":Telescope buffers<CR>"),
	},
}
