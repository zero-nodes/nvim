return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'theHamsta/nvim-dap-virtual-text',
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    require('nvim-dap-virtual-text').setup()
    require('mason-nvim-dap').setup({
      ensure_installed = { 'cpptools' },
      automatic_installation = true,
    })

    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.40 },
            { id = 'breakpoints', size = 0.15 },
            { id = 'stacks', size = 0.25 },
            { id = 'watches', size = 0.20 },
          },
          size = 50,
          position = 'left',
        },
        {
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          size = 10,
          position = 'bottom',
        },
      },
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = '⏸', play = '▶', step_into = '⤵', step_over = '⏭',
          step_out = '⤴', step_back = '⏮', run_last = '🔁', terminate = '⏹',
        },
      },
    })

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.adapters.cppdbg = {
      id = 'cppdbg',
      type = 'executable',
      command = vim.fn.stdpath('data') .. '/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
    }

    dap.configurations.cpp = {
      {
        name = 'Запуск файла',
        type = 'cppdbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Путь к исполняемому файлу: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = true,
        setupCommands = {
          {
            text = '-enable-pretty-printing',
            description = 'Включить красивый вывод (GDB)',
            ignoreFailures = false,
          },
        },
      },
    }
    dap.configurations.c = dap.configurations.cpp

    vim.keymap.set('n', '<leader>n', dap.step_over, { desc = 'Шаг через (next)' })
    vim.keymap.set('n', '<leader>i', dap.step_into, { desc = 'Шаг внутрь (into)' })
    vim.keymap.set('n', '<leader>o', dap.step_out, { desc = 'Шаг из функции (out)' })
    vim.keymap.set('n', '<leader>c', dap.continue, { desc = 'Продолжить выполнение' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Точка останова' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input('Условие: '))
    end, { desc = 'Точка с условием' })

    vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Открыть/закрыть UI отладки' })
    vim.keymap.set('n', '<leader>dx', dap.terminate, { desc = 'Остановить отладку' })
    vim.keymap.set('n', '<leader>dr', dap.restart, { desc = 'Перезапустить отладку' })
  end,
}