local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand
local silent = { silent = true, noremap = true }

-- CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
-- so that you can undo CTRL-U after inserting a line break.
vim.keymap.set('i', '<c-u>', '<c-g>u<c-u>', silent)

vim.keymap.set('n', '<leader>ff', '<cmd>FzfLua files<cr>', silent)

vim.keymap.set('n', '<leader>w', '<c-w>')

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

vim.api.nvim_create_user_command('Search', function(opts)
  local lines = vim.fn.systemlist('rg --vimgrep --no-heading --smart-case --hidden --follow -g "!.git" -M 150 --max-columns-preview ' .. opts.args)
  local list = {}
  for _, line in ipairs(lines) do
    local c1 = string.find(line, ':')
    local c2 = string.find(line, ':', c1 + 1)
    local c3 = string.find(line, ':', c2 + 1)
    if c3 ~= nil then
      table.insert(list,
        {
          filename = string.sub(line, 1, c1 - 1),
          lnum = string.sub(line, c1 + 1, c2 - 1),
          col = string.sub(line, c2 + 1, c3 - 1),
          text = string.sub(line, c3 + 1, -1)
        })
    end
  end
  vim.fn.setqflist(list)
  vim.cmd.copen()
end, { nargs = '+' })

vim.keymap.set('n', '<leader>fg', ':silent Search<space>')
vim.keymap.set('n', 'g*', ":silent Search -Fw '<c-r>=expand('<cword>')<cr>'<cr>")
