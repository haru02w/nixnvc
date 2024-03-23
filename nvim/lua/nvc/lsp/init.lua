local lspconfig = require('lspconfig')

lspconfig.nil_ls.setup {}
require('nvc.lsp.pylyzer')
require('nvc.lsp.clangd')
require('nvc.lsp.lua_ls')
