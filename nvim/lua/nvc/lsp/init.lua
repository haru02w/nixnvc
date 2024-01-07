local lspconfig = require('lspconfig')

lspconfig.clangd.setup {}
lspconfig.pyright.setup {}
lspconfig.nil_ls.setup {}
require('nvc.lsp.lua_ls')
