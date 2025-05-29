-- Package Manager for neovim that runs every time neovim is started
-- Easily installs and manages LSP Servers, DAP Servers, linters and formatters
return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
	opts = {
		ui = {
			border = "rounded",
			backdrop = 60,
			wrap = true,
			icons = {
				package_installed = "✓",
				package_pending = "➜",
				package_uninstalled = "✗",
			},
		},
	},
}
