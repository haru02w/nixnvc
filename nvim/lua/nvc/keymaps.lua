local M = {} -- ignore for now

-- rename keymap
local keymap = vim.keymap.set

-- map leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- easier save and quit
keymap('n', '<leader>q', '<cmd>wq<cr>', { desc = 'save and quit' })

-- Split panes
keymap('n', '<leader>\\', vim.cmd.sp, { desc = 'horizontal split' })
keymap('n', '<leader>|', vim.cmd.vs, { desc = 'vertical split' })

-- Move lines around
keymap('v', '<C-j>', ':m \'>+1<CR>gv=gv', { desc = 'move text down' })
keymap('v', '<C-k>', ':m \'<-2<CR>gv=gv', { desc = 'move text up' })

-- Append next line without moving cursor
keymap('n', 'J', 'mzJ`z', { desc = 'append next line' })

-- Move half page around keeping cursor in the middle
keymap('n', '<C-d>', '<C-d>zz', { desc = 'move cursor half page down' })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'move cursor half page up' })

-- Next search term kepping cursor in the middle
keymap('n', 'n', 'nzzzv', { desc = 'next search term' })
keymap('n', 'N', 'Nzzzv', { desc = 'next search term' })

-- Use the system clipboard
keymap({ 'n', 'v' }, 'y', [["+y]], { desc = 'copy to system clipboard' })
keymap('n', 'Y', [["+Y]], { desc = 'copy to system clipboard the text at right of cursor' })
keymap({ 'n', 'v' }, 'p', [["+p]], { desc = 'paste from system clipboard' })

-- delete without yanking
keymap({'n', 'v' }, '<leader>d', '"_d', { desc = 'delete without yanking' })

-- Paste without losing yanked text
keymap('x', 'p', 'P', { desc = 'paste without yanking' })
keymap('x', '<leader>p', 'p', { desc = 'paste' })

-- allow multiple indentations 
keymap('v', '<', '<gv', { desc = 'indent left' })
keymap('v', '>', '>gv', { desc = 'indent right' })

--disable search highlight
keymap('n', '<leader>n', vim.cmd.nohlsearch, { desc = 'disable search highlight' })

function M.buffer_manager()
	-- Navigate buffers bypassing the menu
	local bmui = require('buffer_manager.ui')
	local keys = '1234567890'
	for i = 1, #keys do
		local key = keys:sub(i, i)
		keymap('n', string.format('<leader>%s', key), function()
			bmui.nav_file(i)
		end, { desc = 'Change to buffer at ' .. i })
	end
	keymap({ 't', 'n' }, '<leader>`', bmui.toggle_quick_menu, { desc = 'Open buffer list' })
end

return M
