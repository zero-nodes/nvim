vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.scrolloff = 8
opt.ignorecase = true
opt.smartcase = true
opt.splitright = true
opt.splitbelow = true
opt.updatetime = 250
opt.clipboard = 'unnamedplus'

vim.keymap.set('n', '<leader>N', function()
  vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = 'Переключить относительную нумерацию строк' })

vim.keymap.set('n', '<leader>sv', '<C-w>v', { desc = 'Создать вертикальный сплит' })
vim.keymap.set('n', '<leader>sh', '<C-w>s', { desc = 'Создать горизонтальный сплит' })
vim.keymap.set('n', '<leader>sq', '<C-w>c', { desc = 'Закрыть сплит' })

require('config.lazy')