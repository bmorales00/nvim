-- This file contains the configuration for the LSP client

local M = {}

M.on_attach = function(client, bufnr)
	local keymap = vim.keymap
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- native neovim keymaps
	keymap.set("n", "<leader>gD", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- goto def
	keymap.set("n", "<leader>gS", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts) -- goto def in vsplit
	keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts) -- code actions
	keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts) -- rename
	keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts) -- cursor diagnostic
	keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float({scope='line'})<CR>", opts) -- line diagnostic
	keymap.set("n", "<leader>pd", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts) -- prev diagnostic
	keymap.set("n", "<leader>nd", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts) -- next diagnostic
	keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts) -- hover doc
	keymap.set("n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts) -- list references
	keymap.set("n", "<leader>go", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts) -- list doc symbol

	if client.name == "basedpyright" then
		keymap.set("n", "<leader>oi", "<cmd>PyrightOrganizeImports<CR>", opts)
	end
end
return M
