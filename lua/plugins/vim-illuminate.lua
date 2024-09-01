-- Illuminate is a plugin for Vim/Neovim to make it easier to work with multiple
-- selections and to highlight other uses of the current word under the cursor.
return {
	"RRethy/vim-illuminate",
	lazy = false,
	config = function()
		-- default config
		require("illuminate").configure({})
	end,
}
