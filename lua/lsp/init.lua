local capabilities = require("cmp_nvim_lsp").default_capabilities()

 -- LSP
require("lsp.angularls")(capabilities)
require("lsp.basedpyright")(capabilities)
require("lsp.bashls")(capabilities)
require("lsp.cssls")(capabilities)
require("lsp.emmet_ls")(capabilities)
require("lsp.harper_ls")(capabilities)
require("lsp.html")(capabilities)
require("lsp.jdtls")(capabilities)
require("lsp.jsonls")(capabilities)
require("lsp.lua_ls")(capabilities)
require("lsp.marksman")(capabilities)
require("lsp.tailwindcss")(capabilities)
require("lsp.volar")(capabilities)
require("lsp.vtsls")(capabilities)

-- Linter and Formatters
require("lsp.efm")(capabilities)

vim.lsp.enable({
  'angularls',
  'basedpyright',
  'bashls',
  'cssls',
  'emmet_ls',
  'harper_ls',
  'html',
  -- 'jdtls', -- Enable java lsp after enabling java plugin
  'jsonls',
  'lua_ls',
  'marksman',
  'tailwindcss',
  'volar',
  'vtsls',
  'efm',
})
