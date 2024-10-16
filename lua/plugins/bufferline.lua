return {
	"akinsho/bufferline.nvim",
	tag = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	lazy = false,
	config = function()
		vim.opt.termguicolors = true
		require("bufferline").setup({

			options = {
				offsets = {
					{
						filetype = "NvimTree",
						text = " File Explorer",
						separator = true,
						text_align = "left",
					},
				},
				diagnostics = "nvim_lsp",
				separator_style = { "", "" },
				modified_icon = "●",
				show_close_icon = false,
				show_buffer_close_icons = false,
			},
		})
	end,
}
