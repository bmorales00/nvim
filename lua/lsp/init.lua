local capabilities = require("blink-cmp").get_lsp_capabilities()

-- LSP
require("lsp.ansiblels")(capabilities)
require("lsp.basedpyright")(capabilities)
require("lsp.bashls")(capabilities)
require("lsp.cssls")(capabilities)
require("lsp.emmet_language_server")(capabilities)
require("lsp.gopls")(capabilities)
require("lsp.harper_ls")(capabilities)
require("lsp.html")(capabilities)
require("lsp.jsonls")(capabilities)
require("lsp.lua_ls")(capabilities)
require("lsp.marksman")(capabilities)
require("lsp.tailwindcss")(capabilities)
local vue_plugin_ok, vue_error = require("lsp.vtsls")(capabilities)
local vue_ok = false
if vue_plugin_ok then
	vue_ok, vue_error = require("lsp.vue_ls")(capabilities)
end
require("lsp.clangd")(capabilities)
require("lsp.yamlls")(capabilities)

-- Linter and Formatters
require("lsp.efm")(capabilities)

local enabled_servers = {
	"ansiblels",
	"clangd",
	"basedpyright",
	"bashls",
	"cssls",
	"emmet_language_server",
	"gopls",
	"harper_ls",
	"html",
	"jsonls",
	"lua_ls",
	"marksman",
	"tailwindcss",
	"vtsls",
	"efm",
	"yamlls",
}

if vue_ok then
	table.insert(enabled_servers, "vue_ls")
elseif vue_error then
	vim.notify_once("Vue LSP disabled: " .. vue_error, vim.log.levels.WARN)
end

vim.lsp.enable(enabled_servers)
