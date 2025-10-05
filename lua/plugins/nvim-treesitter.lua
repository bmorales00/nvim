-- Treesitter is a plugin that provides a better way to display syntax highlighting in Neovim.
local config = function()
	require("nvim-treesitter.configs").setup({
		indent = {
			enable = true,
		},
		ensure_installed = {
			"rust",
			"json",
			"javascript",
			"typescript",
			"yaml",
			"html",
			"css",
			"markdown",
			"bash",
			"lua",
			"luadoc",
			"dockerfile",
			"solidity",
			"gitignore",
			"python",
			"regex",
			"vim",
			"vimdoc",
			"diff",
			"c",
			"angular",
			"vue",
      "toml",
		},
		auto_install = true,
    sync_install = false,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-s>",
				node_incremental = "<C-s>",
				scope_incremental = "<TAB>",
				node_decremental = "<BS>",
			},
		},
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = {"BufReadPost", "BufNewFile"},
	lazy = false,
	config = config,
}
