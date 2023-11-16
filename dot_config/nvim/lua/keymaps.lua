local augroup = vim.api.nvim_create_augroup   -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd   -- Create autocommand
local silent = { silent = true, noremap = true }

-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
vim.keymap.set('i', '<c-u>', '<c-g>u<c-u>', silent)

vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', silent)

vim.keymap.set('n', '<leader>fg', ':silent lgrep<space>')
vim.keymap.set('n', 'g*', ":silent lgrep <c-r>=expand('<cword>')<cr><cr>")
augroup('QuickfixWindows', {})
autocmd("QuickFixCmdPost", {
  group='QuickfixWindows',
  pattern='[^l]*',
  command='cwindow',
})
autocmd("QuickFixCmdPost", {
  group='QuickfixWindows',
  pattern='l*',
  command='lwindow',
})

vim.keymap.set('n', '<leader>h', '<cmd>HopWord<cr>', silent)

vim.keymap.set("n", "gx", "<esc>:URLOpenUnderCursor<cr>", silent)

vim.keymap.set("n", '-', '<cmd>Neotree reveal=true<cr>', silent)
