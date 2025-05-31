-- Trouble is a plugin that shows diagnostics, references, telescope results, quickfix and location lists to help you solve all the trouble your code is causing.
local diagnostics_signs = require("util.icons").debugging_signs
local maplazykey = require("util.keymapper").maplazykey
return {
	"folke/trouble.nvim",
  lazy =false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
	},
  keys = {
      maplazykey("<leader>xx", function()
        require("trouble").toggle()
      end, "Toggle Trouble"),
      maplazykey("<leader>xw", function()
        require("trouble").toggle("workspace_diagnostics")
      end, "Show Workspace Diagnostics"),
      maplazykey("<leader>xd", function()
        require("trouble").toggle("document_diagnostics")
      end, "Show Document Diagnostics"),
      maplazykey("<leader>xq", function()
        require("trouble").toggle("quickfix")
      end, "Toggle Quickfix List"),
      maplazykey("<leader>xl", function()
        require("trouble").toggle("loclist")
      end, "Toggle Location List"),
      maplazykey("gR", function()
        require("trouble").toggle("lsp_references")
      end, "Toggle LSP References"),
    },
}
