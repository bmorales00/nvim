-- Plugin used to view diffs between files in a split window
return {
	"sindrets/diffview.nvim",
	lazy = true,
	config = function()
		require("diffview").setup()
	end,
}
