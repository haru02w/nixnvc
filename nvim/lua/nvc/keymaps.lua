local M = {} -- ignore for now

-- rename keymap
local keymap = vim.keymap.set

-- map leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- easier save and quit
keymap('n', '<leader>q', vim.cmd.wq, { desc = 'save and quit' })

-- Split panes
keymap('n', '<leader>\\', vim.cmd.sp, { desc = 'horizontal split' })
keymap('n', '<leader>|', vim.cmd.vs, { desc = 'vertical split' })

-- Move lines around
keymap('v', '<C-j>', ':m \'>+1<CR>gv=gv', { desc = 'move text down', silent = true })
keymap('v', '<C-k>', ':m \'<-2<CR>gv=gv', { desc = 'move text up', silent = true })

-- Append next line without moving cursor
keymap('n', 'J', 'mzJ`z', { desc = 'append next line', silent = true })

-- Move half page around keeping cursor in the middle
keymap('n', '<C-d>', '<C-d>zz', { desc = 'move cursor half page down', silent = true })
keymap('n', '<C-u>', '<C-u>zz', { desc = 'move cursor half page up', silent = true })

-- Next search term kepping cursor in the middle
keymap('n', 'n', 'nzzzv', { desc = 'next search term', silent = true })
keymap('n', 'N', 'Nzzzv', { desc = 'next search term', silent = true })

-- delete without yanking
keymap({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'delete without yanking', silent = true })

-- Paste without losing yanked text
keymap('x', 'p', 'P', { desc = 'paste without yanking', silent = true })
keymap('x', '<leader>p', 'p', { desc = 'paste', silent = true })

-- allow multiple indentations
keymap('v', '<', '<gv', { desc = 'indent left', silent = true })
keymap('v', '>', '>gv', { desc = 'indent right', silent = true })

--disable search highlight
keymap('n', '<leader>n', vim.cmd.nohlsearch, { desc = 'disable search highlight' })

keymap(
  'x',
  'n',
  [[:<c-u>let temp_variable=@"<CR>gvy:<c-u>let @/='\V<C-R>=escape(@",'/\')<CR>'<CR>:let @"=temp_variable<CR>]],
  { silent = true }
)

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

function M.spectre()
  keymap('n', '<leader>ss', '<cmd>lua require("spectre").open()<CR>', {
    desc = 'Open Spectre',
  })
  keymap('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = 'Search current word',
  })
  keymap('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = 'Search current word',
  })
  keymap('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = 'Search on current file',
  })
end

function M.undotree()
  keymap('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'UndoTree Toggle' })
end

function M.smart_splits()
  local splits = require('smart-splits')
  -- resizing splits
  keymap('n', '<C-A-h>', splits.resize_left, { desc = 'Resize current window left' })
  keymap('n', '<C-A-j>', splits.resize_down, { desc = 'Resize current window down' })
  keymap('n', '<C-A-k>', splits.resize_up, { desc = 'Resize current window up' })
  keymap('n', '<C-A-l>', splits.resize_right, { desc = 'Resize current window right' })
  -- moving between splits
  keymap('n', '<C-h>', splits.move_cursor_left, { desc = 'Move focus to left window' })
  keymap('n', '<C-j>', splits.move_cursor_down, { desc = 'Move focus to down window' })
  keymap('n', '<C-k>', splits.move_cursor_up, { desc = 'Move focus to up window' })
  keymap('n', '<C-l>', splits.move_cursor_right, { desc = 'Move focus to right window' })
  -- swapping buffers between windows
  keymap('n', '<A-H>', splits.swap_buf_left, { desc = 'Swap current window with left one' })
  keymap('n', '<A-K>', splits.swap_buf_down, { desc = 'Swap current window with down one' })
  keymap('n', '<A-J>', splits.swap_buf_up, { desc = 'Swap current window with up one' })
  keymap('n', '<A-L>', splits.swap_buf_right, { desc = 'Swap current window with right one' })
end

function M.telescope()
  local builtin = require('telescope.builtin')
  keymap('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
  keymap('n', '<leader>fG', builtin.git_files, { desc = '[f]ind [G]it files' })
  keymap('n', '<leader>fg', builtin.live_grep, { desc = '[f]ind [g]rep pattern' })
  keymap('n', '<leader>fb', builtin.buffers, { desc = '[f]ind on [b]uffers' })
  keymap('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind in [h]elp manuals' })
  return {
    i = {
      ['<C-n>'] = 'move_selection_next',
      ['<C-p>'] = 'move_selection_previous',
    },
  }
end

function M.comment()
  local api = require('Comment.api')
  local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

  keymap('n', '<leader>/', api.toggle.linewise.current, { desc = 'linewise comment a line' })
  keymap('n', '<leader>?', api.toggle.blockwise.current, { desc = 'blockwise comment a line' })

  keymap('x', '<leader>/', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.toggle.blockwise(vim.fn.visualmode())
  end, { desc = 'blockwise comment selected text' })

  keymap('x', '<leader>?', function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    api.toggle.linewise(vim.fn.visualmode())
  end, { desc = 'linewise comment selected text' })
end

function M.todo_comments()
  local todo = require('todo-comments')
  keymap('n', ']t', todo.jump_next, { desc = 'Next todo comment' })
  keymap('n', '[t', todo.jump_prev, { desc = 'Previous todo comment' })

  -- You can also specify a list of valid jump keywords
  keymap('n', ']t', function()
    todo.jump_next { keywords = { 'ERROR', 'WARNING' } }
  end, { desc = 'Next error/warning todo comment' })
end

function M.oil()
  keymap('n', '-', '<cmd>Oil<CR>', { desc = 'Open file manager' })
  return {
    ['<Esc>'] = 'actions.close',
    ['q'] = 'actions.close',
    ['<CR>'] = 'actions.select',
  }
end

function M.lsp()
  -- Call hierarchy
  keymap('n', '<Leader>li', vim.lsp.buf.incoming_calls, { desc = '[L]sp [I]ncoming Calls' })
  keymap('n', '<Leader>lo', vim.lsp.buf.outgoing_calls, { desc = '[L]sp [O]utgoing Calls' })

  -- Diagnostic keymaps
  keymap('n', '<leader>ld', vim.diagnostic.open_float)
  keymap('n', '[d', vim.diagnostic.goto_prev)
  keymap('n', ']d', vim.diagnostic.goto_next)

  keymap('n', '<leader>lr', vim.lsp.buf.rename, { desc = '[L]sp [R]ename' })

  keymap('n', 'gd', vim.lsp.buf.definition, { desc = '[G]oto [D]efinition' })
  keymap('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]efinition' })
  keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Hover docs' })
  keymap('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]oto [I]mplementation' })
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  keymap('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, {})
  keymap('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, {})
  keymap('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {})
  keymap('n', 'gt', vim.lsp.buf.type_definition, { desc = 'type [D]efinition' })
  keymap('n', 'gr', vim.lsp.buf.references, { desc = 'type [D]efinition' })
  keymap({ 'n', 'v' }, '<leader>la', vim.lsp.buf.code_action, { desc = '[L]sp [A]ctions' })

  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, { desc = '[F]ormat buffer' })
end

function M.cmp()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  local function has_words_before()
    local unpack_ = unpack or table.unpack
    local line, col = unpack_(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  return {
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-d>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Replace }
      else
        fallback()
      end
    end, { 'i', 'c', 's' }),
    ['<C-u>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Replace }
      else
        fallback()
      end
    end, { 'i', 'c', 's' }),
    ['<C-n>'] = cmp.mapping(function()
      if luasnip.jumpable(1) and luasnip.in_snippet() then
        luasnip.jump(1)
      end
    end, { 'i', 'c', 's' }),
    ['<C-p>'] = cmp.mapping(function()
      if luasnip.jumpable(-1) and luasnip.in_snippet() then
        luasnip.jump(-1)
      end
    end, { 'i', 'c', 's' }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 'c', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item { behavior = cmp.SelectBehavior.Select }
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<C-x>'] = cmp.mapping(function()
      if luasnip.choice_active() then
        luasnip.change_choice(1)
      end
    end, { 'i', 's' }),
  }
end

function M.dap()
  local dap, dapui = require('dap'), require('dapui')

  keymap('n', '<F3>', dapui.toggle, { desc = 'toggle dap ui' })

  keymap('n', '<F5>', dap.continue, { desc = 'debug: continue program' })
  keymap('n', '<F17>', dap.terminate, { desc = 'debug: stop program' }) -- Shift + F5
  keymap('n', '<F29>', dap.restart_frame, { desc = 'debug: restart program' }) -- Control + F5

  keymap('n', '<F6>', dap.pause, { desc = 'debug: pause program' })
  keymap('n', '<F9>', dap.toggle_breakpoint, { desc = 'debug: toggle breakpoint' })
  keymap('n', '<F21>', function()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end, { desc = 'debug: Conditional breakpoint' }) -- Shift + F9
  keymap('n', '<F10>', dap.step_over, { desc = 'debug: step over' })
  keymap('n', '<F11>', dap.step_into, { desc = 'debug: step into' })
  keymap('n', '<F23>', dap.step_out, { desc = 'debug: step out' }) -- Shift + F11
end

return M
