local on_attach = require("util.lsp").on_attach

-- Auto-Format on Save
local lsp_fmt_group = vim.api.nvim_create_augroup("FormatOnSaveGroup", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	group = lsp_fmt_group,
	callback = function()
		local ft = vim.bo.filetype
		local lsp_formatters = {
			c = "clangd",
		}
		local formatter = lsp_formatters[ft] or "efm"
		local clients = vim.lsp.get_clients({ name = formatter })

		if vim.tbl_isempty(clients) then
			return
		end

		vim.lsp.buf.format({ name = formatter, async = true })
	end,
})

-- Highlights text with Yank
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYankGroup", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = highlight_yank_group,
	pattern = "*",
	callback = function()
		vim.hl.on_yank({
			higroup = "IncSearch",
			timeout = 200,
		})
	end,
})

-- Restore cursor to file position in previous editing session
local return_last_pos = vim.api.nvim_create_augroup("LastPosGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	group = return_last_pos,
	callback = function(args)
		local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
		local line_count = vim.api.nvim_buf_line_count(args.buf)
		if mark[1] > 0 and mark[1] <= line_count then
			vim.cmd('normal! g`"zz')
		end
	end,
})

-- on attach function
local lsp_on_attach_group = vim.api.nvim_create_augroup("LspMappings", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_on_attach_group,
	callback = on_attach,
})
