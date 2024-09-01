-- lualine is a fast and light statusline plugin for Neovim.
local config = function()
	require("lualine").setup({
		options = {
			theme = "16color",
			globalstatus = true,
			--	component_separators = { left = "|", right = "|" },
			--section_separators = { left = "", right = "" },
			--section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "buffers" }, -- Changed this eventually
			lualine_c = { "" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	config = config,
}
