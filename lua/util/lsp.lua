-- This file contains the configuration for the LSP client

local M = {}

M.on_attach = function(client, bufnr)
	local keymap = vim.keymap
	local map = function(lhs, rhs, desc)
		keymap.set("n", lhs, rhs, {
			noremap = true,
			silent = true,
			buffer = bufnr,
			desc = desc,
		})
	end

	-- native neovim keymaps
	map("<leader>gD", "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition")
	map("<leader>gS", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", "Definition in vertical split")
	map("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action")
	map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol")
	map("<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", "Cursor diagnostics")
	map("<leader>D", "<cmd>lua vim.diagnostic.open_float({scope='line'})<CR>", "Line diagnostics")
	map("<leader>pd", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous diagnostic")
	map("<leader>nd", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next diagnostic")
	map("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "LSP hover")
	map("<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", "List references")
	map("<leader>go", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document symbols")

	if client.name == "basedpyright" then
		map("<leader>oi", "<cmd>LspPyrightOrganizeImports<CR>", "Organize imports")
	end
end
return M
