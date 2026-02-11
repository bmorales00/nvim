-- -- Themes for neovim
-- return {
-- 	----------------------- Mellifluous
-- 	{
-- 		"ramojus/mellifluous.nvim",
-- 		version = "v0.*",
-- 		priority = 1000,
-- 		lazy = false,
-- 		config = function()
-- 			require("mellifluous").setup({
-- 				dim_inactive = false,
-- 				color_set = "mellifluous",
-- 				flat_background = {
-- 					line_numbers = true,
-- 					floating_windows = true,
-- 					file_tree = true,
-- 					cursor_line_number = true,
-- 				},
-- 				plugins = {
-- 					cmp = true,
-- 					gitsigns = true,
-- 					indent_blankline = true,
-- 					nvim_tree = {
-- 						enabled = false,
-- 						show_root = false,
-- 					},
-- 					neo_tree = {
-- 						enabled = false,
-- 					},
-- 					telescope = {
-- 						enabled = true,
-- 						nvchad_like = false,
-- 					},
-- 				},
-- 				mellifluous = {
-- 					color_overrides = {
-- 						dark = {
-- 							bg = "#080808",
-- 						},
-- 					},
-- 					neutral = true,
-- 					bg_contrast = "hard",
-- 				},
-- 			})
-- 			vim.cmd("colorscheme mellifluous")
-- 		end,
-- 	},

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
-- end,
-- },
--
--

return {
	"slugbyte/lackluster.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local lackluster = require("lackluster")
		lackluster.setup({
			tweak_syntax = {
				keyword = lackluster.color.green,
				comment = lackluster.color.gray4, -- or gray5
			},
			tweak_background = {
				-- normal = "default", -- main background
				-- normal = "none", -- transparent
				normal = "#000000", -- hexcode
				-- normal = color.green, -- lackluster color
				telescope = "#000000", -- telescope
				menu = "default", -- nvim_cmp, wildmenu ... (bad idea to transparent)
				popup = "#000000", -- lazy, mason, whichkey ... (bad idea to transparent)
			},
			tweak_highlight = {
				["@comment"] = {
					italic = true,
				},
			},
		})
		-- vim.cmd.colorscheme("lackluster")
		-- vim.cmd.colorscheme("lackluster-mint")
		vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = lackluster.color.lack })
		vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = lackluster.color.lack })
		vim.cmd.colorscheme("lackluster-hack") -- my favorite
	end,
}
