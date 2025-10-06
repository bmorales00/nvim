-- A file explorer tree for neovim
return {
	"nvim-tree/nvim-tree.lua",
	lazy = false,
	dependencies = { "mini.nvim" },
	config = function()
		vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
		require("nvim-tree").setup({
			filters = {
				dotfiles = false,
			},
			view = {
				adaptive_size = true,
			},
			git = {
				ignore = false,
			},
		})
	end,
}
