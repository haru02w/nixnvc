local config = require('buffer_manager')
config.setup {
  line_keys = '',
  win_extra_options = {
    number = true;
    relativenumber = true;
  },
}
require('nvc.keymaps').buffer_manager()
