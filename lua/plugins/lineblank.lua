return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {
    indent = {
      char = '│',
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
    },
    exclude = {
      filetypes = { 'dashboard', 'alpha', 'startify', 'neo-tree' },
      buftypes = { 'nofile', 'prompt', 'terminal' },
    },
  },
}