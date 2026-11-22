return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Глобальные capabilities для всех серверов
      vim.lsp.config('*', {
        capabilities = capabilities,
      })

      -- Настройка lua_ls для корректной работы с Neovim API
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      require('mason').setup()
      require('mason-lspconfig').setup({
        ensure_installed = { 'ts_ls', 'lua_ls', 'clangd' },
        automatic_enable = true,
      })

      -- Горячие клавиши через LspAttach
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = 'Переименовать символ' }))
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = 'Code action' }))
          vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = 'Показать ошибки' }))
        end,
      })

      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local kind_icons = {
        Text = '󰉿', Method = '󰆧', Function = '󰊕', Constructor = '',
        Field = '󰜢', Variable = '󰀫', Class = '󰠱', Interface = '',
        Module = '', Property = '󰜢', Unit = '󰑭', Value = '󰎠',
        Enum = '', Keyword = '󰌋', Snippet = '', Color = '󰏘',
        File = '󰈙', Reference = '󰈇', Folder = '󰉋', EnumMember = '',
        Constant = '󰏿', Struct = '󰙅', Event = '', Operator = '󰆕',
        TypeParameter = '󰊄',
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping.select_next_item(),
          ['<S-Tab>'] = cmp.mapping.select_prev_item(),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind] or '', vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
            })[entry.source.name]
            return vim_item
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}