return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		-- this will download prebuild binary or try to use existing rustup toolchain to build from source
		-- (if you are using lazy you can use gb for rebuilding a plugin if needed)
		require("fff.download").download_or_build_binary()
	end,
	-- if you are using nixos
	-- build = "nix run .#release",
	opts = { -- (optional)
		debug = {
			enabled = true, -- we expect your collaboration at least during the beta
			show_scores = true, -- to help us optimize the scoring system, feel free to share your scores!
		},
    hl={
      matched="FFFGitSignModified",
    },
	},
	-- No need to lazy-load with lazy.nvim.
	-- This plugin initializes itself lazily.
	-- lazy = false,
	keys = {
		{
			"ff", -- try it if you didn't it is a banger keybinding for a picker
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		{
			"fg",
			function()
				require("fff").live_grep()
			end,
			desc = "LiFFFe grep",
		},
		{
			"fz",
			function()
				require("fff").live_grep({
					grep = {
						modes = { "fuzzy", "plain" },
					},
				})
			end,
			desc = "Live fffuzy grep",
		},
	},
}

-- local keys = {
-- 	{ "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer search" },
-- 	{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
-- 	{ "<leader>fc", "<cmd>Telescope git_commits<cr>", desc = "Commits" },
-- 	{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find All Files" },
-- 	{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
-- 	{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
-- 	{ "<leader>fj", "<cmd>Telescope command_history<cr>", desc = "History" },
-- 	{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
-- 	{ "<leader>fl", "<cmd>Telescope lsp_references<cr>", desc = "Lsp References" },
-- 	{ "<leader>fo", "<cmd>Telescope oldfiles<cr>", desc = "Old files" },
-- 	{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Ripgrep" },
-- 	{ "<leader>fs", "<cmd>Telescope grep_string<cr>", desc = "Grep String" },
-- 	{ "<leader>ft", "<cmd>Telescope treesitter<cr>", desc = "Treesitter" },
-- }
