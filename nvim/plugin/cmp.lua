local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- See `o.completeopt` in `lua/nvc/options.lua`

if isModuleAvailable('nvim-autopairs') then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

cmp.setup {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
  formatting = {
    format = lspkind.cmp_format {
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '…',
    },
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert(require('nvc.keymaps').cmp()),
  sources = {
    { name = 'luasnip', option = { show_autosnippets = true } },
    { name = 'nvim_lsp', keyword_length = 3 },
    -- { name = 'nvim_lsp_signature_help', keyword_length = 3 },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'rg' },
  },
}

cmp.setup.filetype('lua', {
  sources = cmp.config.sources {
    { name = 'nvim_lua' },
    { name = 'luasnip', option = { show_autosnippets = true } },
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'nvim_lsp_signature_help', keyword_length = 3 },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'rg' },
  },
})

require('luasnip.loaders.from_vscode').lazy_load()

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(), -- TODO: maybe change mappings
  sources = {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmdline_history' },
  },
  view = {
    entries = { name = 'wildmenu', separator = '|' },
  },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(), -- TODO: maybe change mappings
  sources = cmp.config.sources {
    { name = 'cmdline' },
    { name = 'cmdline_history' },
  },
})
