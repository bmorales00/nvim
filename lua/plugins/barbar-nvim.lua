return {
	"romgrk/barbar.nvim",
	opts = {},
	lazy = true,
	config = function()
		vim.g.barbar_auto_setup = false
		require("barbar").setup({
			tabpages = true,

			sidebar_filetypes = {
				-- Use the default values: {event = 'BufWinLeave', text = nil}
				NvimTree = true,
				-- Or, specify the text used for the offset:
				undotree = { text = "undotree" },
				-- Or, specify the event which the sidebar executes when leaving:
				["neo-tree"] = { event = "BufWipeout" },
				-- Or, specify both
				Outline = { event = "BufWinLeave", text = "symbols-outline" },
			},
		})
	end,
}
