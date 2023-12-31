local o = vim.opt -- rename

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

-- show popup menu and don't auto select
o.completeopt = 'menuone,noselect'
-- Enable indent at wrapped lines 
o.breakindent = true 
-- enable mouse support
o.mouse = 'a'
-- line reserved for commands
-- o.cmdheight = 1
-- update current directory based on the opened file
-- o.autochdir = false 
-- read changes to file automatically
o.autoread = true
-- 0-never, 1-more than two windows, 2-always, 3-only the last
-- o.laststatus = 3
-- disable case sensitiviness on search
o.ignorecase = true
-- enable back when a capital letter is written
o.smartcase = true
-- enable numbers
o.number = true
-- enable relative numbers
o.relativenumber = true 
-- Keep signcolumn on by default
o.signcolumn = 'yes'
-- set indent options
o.shiftround = true -- round tabs to shiftwidth
o.smartindent = true

o.wrap = true;

o.swapfile = false
o.backup = false
o.undofile = true

o.hlsearch = true      --keep highlights enabled (see keymaps to fast disable)
o.incsearch = true     --see the search evaluation

o.termguicolors = true -- good colors

o.scrolloff = 8        -- centralize the cursor a little

-- wait for next key
o.timeout = true
o.timeoutlen = 300
-- good code fit in less than 80 columns
o.colorcolumn = '80'
-- find the cursor easier
o.cursorline = true
