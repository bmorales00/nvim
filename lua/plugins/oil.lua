return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	---
	opts = {
		float = {
			border = "single",
		},
		confirmation = {
			border = "single",
		},
	},
	-- Optional dependencies
	dependencies = { { "mini.nvim", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" }),
}
