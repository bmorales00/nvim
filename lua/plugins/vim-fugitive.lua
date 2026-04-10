-- Fugitive is a git wrapper for vim that allows you to run git commands from vim.
return {
	lazy = false,
	"tpope/vim-fugitive",
	config = function()
		local map = vim.keymap.set
		map("n", "<leader>gb", ":Git blame<CR>", { desc = "Git Blame" })
		map("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git Diff Split" })
	end,
}
