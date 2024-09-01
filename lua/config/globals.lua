-- This is a globals file for neovim configuration
-- Such as adding clipboard support, setting leader key, etc.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.clipboard = {
	name = "wl-clipboard",
	copy = {
		["+"] = "wl-copy",
		["*"] = "wl-copy",
	},
	paste = {
		["+"] = "wl-paste",
		["*"] = "wl-paste",
	},
	cache_enabled = 1,
}
