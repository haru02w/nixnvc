local lspconfig = require('lspconfig')

lspconfig.pyright.setup {}
lspconfig.nil_ls.setup {}
require('nvc.lsp.clangd')
require('nvc.lsp.lua_ls')
