-- Debugger Plugin for Python
return {
	"mfussenegger/nvim-dap-python",
	ft = "python", -- filetype
	config = function()
    local python_path = os.getenv("VIRTUAL_ENV") and os.getenv("VIRTUAL_ENV") .. "/bin/python"
		require("dap-python").setup(python_path)
	end,
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
}
