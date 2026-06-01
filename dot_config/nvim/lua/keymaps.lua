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

vim.keymap.set('n', '<leader>gg', '<cmd>Flog<cr>', silent)
vim.keymap.set('n', '<leader>ga', '<cmd>Flog -all<cr>', silent)
vim.keymap.set('n', '<leader>gs', '<cmd>Neogit<cr>', silent)
vim.keymap.set('n', '<leader>gd', function ()
  local hash = vim.fn.expand('<cword>')
  vim.cmd('DiffviewOpen ' .. hash .. '^!')
end, silent)

function _G.lint_and_format()
  local function finalize()
    require('conform').format()
    vim.cmd('write')
  end

  if vim.fn.exists('*CocActionAsync') ~= 1 then
    finalize()
    return
  end

  vim.fn.CocActionAsync('runCommand', 'eslint.executeAutofix', function()
    vim.fn.CocActionAsync('runCommand', 'editor.action.organizeImport', function()
      finalize()
    end)
  end)
end

vim.keymap.set('n', '<leader>ss', '<cmd>lua _G.lint_and_format()<cr>')
