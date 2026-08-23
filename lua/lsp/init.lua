local capabilities = require("blink-cmp").get_lsp_capabilities()

-- LSP
require("lsp.basedpyright")(capabilities)
require("lsp.bashls")(capabilities)
require("lsp.cssls")(capabilities)
require("lsp.emmet_language_server")(capabilities)
require("lsp.harper_ls")(capabilities)
require("lsp.html")(capabilities)
require("lsp.jsonls")(capabilities)
require("lsp.lua_ls")(capabilities)
require("lsp.marksman")(capabilities)
require("lsp.tailwindcss")(capabilities)
require("lsp.vue_ls")(capabilities)
require("lsp.vtsls")(capabilities)
require("lsp.clangd")(capabilities)

-- Linter and Formatters
require("lsp.efm")(capabilities)

vim.lsp.enable({
	"clangd",
	"basedpyright",
	"bashls",
	"cssls",
	"emmet_language_server",
	"harper_ls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"tailwindcss",
	"vue_ls",
	"vtsls",
	"efm",
})
