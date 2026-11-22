return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>dd', '<cmd>DiffviewOpen<CR>', desc = 'Open Diffview' },
    { '<leader>dh', '<cmd>DiffviewFileHistory %<CR>', desc = 'File history' },
    { '<leader>dc', '<cmd>DiffviewClose<CR>', desc = 'Close Diffview' },
  },
  opts = {
    diff_binaries = false,
    enhanced_diff_hl = true,
    use_icons = true,
    watch_index = true,
    view = {
      default = {
        layout = 'diff2_horizontal',
      },
      merge_tool = {
        layout = 'diff3_horizontal',
        disable_diagnostics = true,
        winbar_info = true,
      },
      file_history = {
        layout = 'diff2_horizontal',
        position = 'bottom',
        height = 16,
      },
    },
  },
}