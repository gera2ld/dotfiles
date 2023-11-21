vim.opt.cursorline = true
vim.opt.mouse = 'nivh'
vim.opt.textwidth = 100
vim.opt.smartindent = true
vim.opt.fileencodings = {'ucs-bom', 'utf-8', 'cp936'}
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.number = true
vim.opt.cmdheight = 0
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.shortmess:append 'c'
vim.opt.virtualedit = 'all'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.diffopt:append 'iwhite'
vim.opt.undofile = true
vim.opt.laststatus = 3

vim.opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
vim.opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'

-- disable default markdown style
vim.g.markdown_recommended_style = 0
