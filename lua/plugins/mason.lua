return {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
	opts = {
		ui = {
			border = "single",
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
