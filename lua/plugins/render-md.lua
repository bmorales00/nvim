return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-mini/mini.nvim" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	ft = { "markdown", "markdown.mdx" },
	opts = {
		latex = { enabled = false },
		completions = { lsp = { enabled = true } },
	},
}
