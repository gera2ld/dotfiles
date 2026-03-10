local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
local silent = { silent = true, noremap = true }

-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
vim.keymap.set('i', '<c-u>', '<c-g>u<c-u>', silent)

vim.keymap.set('n', '<leader>w', '<c-w>')

-- open quickfix list automatically
augroup('QuickfixWindows', {})
autocmd("QuickFixCmdPost", {
  group = 'QuickfixWindows',
  pattern = '[^l]*',
  command = 'cwindow',
})
autocmd("QuickFixCmdPost", {
  group = 'QuickfixWindows',
  pattern = 'l*',
  command = 'lwindow',
})

vim.keymap.set('n', '<leader>ff', '<cmd>lua FzfLua.files()<cr>', silent)
vim.keymap.set('n', '<leader>fg', '<cmd>lua FzfLua.git_files()<cr>', silent)
vim.keymap.set('n', '<leader>fs', '<cmd>lua FzfLua.live_grep()<cr>', silent)
vim.keymap.set('n', '<leader>*', "<cmd>lua FzfLua.grep_cword()<cr>", silent)
