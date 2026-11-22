return {
  'xiyaowong/transparent.nvim',
  lazy = false,
  config = function()
    require('transparent').setup({
      groups = {
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
        'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
        'SignColumn', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
        'EndOfBuffer',
      },
      exclude_groups = { 'CursorLine' },
    })

    require('transparent').clear_prefix('NeoTree')
    require('transparent').clear_prefix('lualine')
    require('transparent').clear_prefix('Buffer')

    vim.keymap.set('n', '<leader>tt', '<cmd>TransparentToggle<CR>', { desc = 'Toggle transparency' })
  end,
}