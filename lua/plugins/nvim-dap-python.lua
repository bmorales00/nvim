-- Debugger Plugin for Python
return {
	"mfussenegger/nvim-dap-python",
	ft = "python", -- filetype
	config = function()
		require("dap-python").setup("~/.virtualenvs/myenv/bin/python")
	end,
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
}
