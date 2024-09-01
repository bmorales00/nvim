-- Git decorations used for added, removed, and changed lines
-- This plugin is used to show git decorations in the sign column
-- The sign column is the column on the left side of the buffer where line numbers are displayed
return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	config = function()
		require("gitsigns").setup()
	end,
}
