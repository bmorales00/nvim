-- Themes for neovim
return {
	----------------------- Mellifluous (Default)
	{
		"ramojus/mellifluous.nvim",
		version = "v0.*",
		priority = 1000,
		lazy = false,
		config = function()
			require("mellifluous").setup({
				dim_inactive = false,
				color_set = "mellifluous",
				flat_background = {
					line_numbers = true,
					floating_windows = true,
					file_tree = true,
					cursor_line_number = true,
				},
				plugins = {
					cmp = true,
					gitsigns = true,
					indent_blankline = true,
					nvim_tree = {
						enabled = false,
						show_root = false,
					},
					neo_tree = {
						enabled = false,
					},
					telescope = {
						enabled = true,
						nvchad_like = false,
					},
				},
				mellifluous = {
					color_overrides = {
						dark = {
							bg = "#080808",
						},
					},
					neutral = true,
					bg_contrast = "hard",
				},
			})
			vim.cmd("colorscheme mellifluous")
		end,
	},

  --------------------------------- Black Metal -----------------------------------------------
  -- {
  --   "metalelf0/black-metal-theme-neovim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require("black-metal").setup({
  --       theme = "bathory",
  --       -- optional configuration here
  --     })
  --     require("black-metal").load()
  --   end,
  -- },
}
