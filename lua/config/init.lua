-- Init file for neovim
-- This file is responsible for setting up the configuration
-- This is based on the lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("config.globals")
require("config.options")
require("config.keymaps")
require("config.autocmds")

local plugins = "plugins"

local opts = {
	defaults = {
		lazy = true,
	},
	install = {
		colorscheme = { "mellifluous" },
	},
	rtp = {
		disabled_plugins = {
			"gzip",
			"matchit",
			"matchparen",
			"netrw",
			"netrwPlugin",
			"tarPlugin",
			"tohtml",
			"tutor",
			"zipPlugin",
		},
	},
	change_detection = {
		notify = false,
	},
	ui = {
		border = "rounded",
	},
}

require("lazy").setup(plugins, opts)
