return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	keys = {
		{ "<leader>ha", desc = "Add buffer to Harpoon" },
		{ "<leader>hh", desc = "Show Harpoon list" },
		{ "<leader>hn", desc = "Previous Harpoon buffer" },
		{ "<leader>hp", desc = "Next Harpoon buffer" },
	},
	dependencies = { { "nvim-lua/plenary.nvim", lazy = true, module = false } },
	config = function()
		-- REQUIRED
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Add Buffer to Harpoon List" })
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Show Harpoon Buffer List" })
		--
		-- vim.keymap.set("n", "<C-left>", function()
		-- 	harpoon:list():select(1)
		-- end)
		-- vim.keymap.set("n", "<C-down>", function()
		-- 	harpoon:list():select(2)
		-- end)
		-- vim.keymap.set("n", "<C-up>", function()
		-- 	harpoon:list():select(3)
		-- end)
		-- vim.keymap.set("n", "<C-right>", function()
		-- 	harpoon:list():select(4)
		-- end)
		--
		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():prev()
		end, { desc = "Previous Harpoon buffer" })
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():next()
		end, { desc = "Next Harpoon buffer" })
	end,
}
