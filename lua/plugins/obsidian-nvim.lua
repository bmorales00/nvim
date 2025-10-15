return {
	"obsidian-nvim/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
	--   -- refer to `:h file-pattern` for more examples
	--   "BufReadPre path/to/my-vault/*.md",
	--   "BufNewFile path/to/my-vault/*.md",
	-- },
	---@module 'obsidian'
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "MyVault",
					path = vim.fn.expand("~") .. "/Desktop/MyVault",
				},
				{
					name = "buf-parent",
					path = function()
						return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
					end,
				},
			},
			ui = { enabled = false },
			legacy_commands = false,

			attachments = {
				img_folder = "./folder-name",
			},

			---@param url string
			follow_url_func = function(url)
				vim.fn.jobstart({ "xdg-open", url })
			end,

			completion = {
				nvim_cmp = true,
				min_chars = 1,
			},
			lsp = false,
		})
	end,
}
