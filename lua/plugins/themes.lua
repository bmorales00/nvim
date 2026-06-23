-- -- Themes for neovim

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
				normal = "none", -- transparent
				-- normal = "#000000", -- hexcode
				-- normal = color.green, -- lackluster color
				menu = "none", -- nvim_cmp, wildmenu ... (bad idea to transparent)
				popup = "none", -- lazy, mason, whichkey ... (bad idea to transparent)
			},
			tweak_highlight = {
				["@comment"] = {
					italic = true,
				},
			},
		})
		-- vim.cmd.colorscheme("lackluster")
		-- vim.cmd.colorscheme("lackluster-mint")
		vim.cmd.colorscheme("lackluster-hack") -- my favorite
	end,
}
