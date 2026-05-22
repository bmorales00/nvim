-- lualine is a fast and light statusline plugin for Neovim.
local config = function()
	require("lualine").setup({
		options = {
			theme = "auto",
			globalstatus = true,
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { { "mode", icon = "𒉭", separator = { left = "", right = "" } } },
			lualine_b = {
				{ "filename", file_status = false, path = 1 },
				{ "diagnostics", update_in_insert = true },
			},
			lualine_c = { "" },
			lualine_x = { "encoding", "fileformat", "filetype" },
			lualine_y = { "progress" },
			lualine_z = { { "location", separator = { left = "", right = "" } } },
		},
	})
end

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	config = config,
}
