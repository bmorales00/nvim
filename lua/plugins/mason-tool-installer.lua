-- Mason Tool Installer that will install and or upgrade all of the third party tools
-- such as linters, formatters, dap, etc
-- Not LSP's
local opts = {
	ensure_installed = {
		"black",
		"debugpy",
		"flake8",
	},
}
return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	opts = opts,
}
