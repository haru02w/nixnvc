require('telescope').setup {
  defaults = {
    mappings = require('nvc.keymaps').telescope()
  },
}
require('telescope').load_extension('fzf')
