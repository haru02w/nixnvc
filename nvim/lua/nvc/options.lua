-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

local options = {
  -- Copy to system clipboard by default
  clipboard = 'unnamedplus',

  encoding = 'utf-8',
  fileencoding = 'utf-8',

  -- show popup menu and don't auto select
  completeopt = 'menuone,noselect',
  -- Enable indent at wrapped lines
  breakindent = true,
  -- enable mouse support
  mouse = 'a',
  -- line reserved for commands
  -- cmdheight = 1
  -- update current directory based on the opened file
  -- autochdir = false
  -- read changes to file automatically
  autoread = true,
  -- 0-never, 1-more than two windows, 2-always, 3-only the last
  -- laststatus = 3
  -- disable case sensitiviness on search
  ignorecase = true,
  -- enable back when a capital letter is written
  smartcase = true,
  -- enable numbers
  number = true,
  -- enable relative numbers
  relativenumber = true,
  -- Keep signcolumn on by default
  signcolumn = 'yes',
  -- set indent options
  shiftround = true, -- round tabs to shiftwidth
  autoindent = true,
  smartindent = true,

  wrap = false,

  splitbelow = true,
  splitright = true,

  swapfile = false,
  backup = false,
  writebackup = false,
  undofile = true,

  hlsearch = true,      --keep highlights enabled (see keymaps to fast disable)
  incsearch = true,     --see the search evaluation

  termguicolors = true, -- good colors

  scrolloff = 8,        -- centralize the cursor a little

  -- wait for next key
  timeout = true,
  timeoutlen = 300,
  -- good code fit in less than 80 columns
  colorcolumn = '80',
  -- find the cursor easier
  cursorline = true,
}

for option, value in pairs(options) do
  vim.opt[option] = value
end
