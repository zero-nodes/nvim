return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha',
        integrations = {
          barbar = true,
          cmp = true,
          dap = true,
          dap_ui = true,
          diffview = true,
          indent_blankline = { enabled = true },
          mason = true,
          neotree = true,
          noice = true,
          notify = true,
          telescope = { enabled = true },
          treesitter = true,
        },
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}