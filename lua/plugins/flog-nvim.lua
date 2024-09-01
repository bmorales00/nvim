-- Flog is a git branch viewer for Vim.
return {
	"rbong/vim-flog",
	lazy = true,
	cmd = {
		"Flog",
		"Flogsplit",
		"Floggit",
	},
	dependencies = {
		"tpop/vim-fugitive",
	},
}
