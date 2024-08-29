-- Debugger Plugin for Python
return {
	"mfussenegger/nvim-dap-python",
	ft = "python", -- filetype
	config = function()
		require("dap-python").setup("~/.virtualenvs/debugpy/bin/python3")
	end,
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
}
