return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap, dapui = require("dap"), require("dapui")

    dap.adapters.codelldb = {
      type = "executable",
      command = require("lib.std").mason_packages .. "/codelldb/codelldb",
    }

    dap.configurations.c = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local file_name = vim.fn.expand("%:p")
          os.execute("gcc -g -o " .. file_name .. ".debug " .. file_name)
          return (file_name .. ".debug")
          --return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "codelldb",
        request = "launch",
        program = function()
          local file_name = vim.fn.expand("%:p")
          os.execute("gcc -g -lstdc++ -o " .. file_name .. ".debug " .. file_name)
          return (file_name .. ".debug")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
      },
    }

    dapui.setup()

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

    --vim.keymap.set("n", "<Leader>dt", function()
    --  dap.toggle_breakpoint()
    --end)
    --vim.keymap.set("n", "<Leader>dc", function()
    --  dap.continue()
    --end)
  end,

  keys = {
    {
      "<leader>dt",
      ':lua require("dap").toggle_breakpoint()<CR>',
      desc = "Toggle Breakpoint",
    },
    {
      "<leader>dc",
      ':lua require("dap").continue()<CR>',
      desc = "Start Debugger",
    },
    {
      "<leader>dso",
      ':lua require("dap").step_over()<CR>',
      desc = "Debugger Step Over",
    },
    {
      "<leader>dsi",
      ':lua require("dap").step_into()<CR>',
      desc = "Debugger Step Into",
    },
    {
      "<leader>dsoo",
      ':lua require("dap").step_out()<CR>',
      desc = "Debugger Step Out",
    },
    {
      "<leader>dsb",
      ':lua require("dap").step_breakpoint()<CR>',
      desc = "Debugger Set Breakpoint",
    },
    {
      "<leader>dsbl",
      ":lua require(\"dap\").step_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
      desc = "Debugger Set Breakpoint",
    },

    --
    -- vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    -- vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    -- vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
    --   require('dap.ui.widgets').hover()
    -- end)
    -- vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
    --   require('dap.ui.widgets').preview()
    -- end)
    -- vim.keymap.set('n', '<Leader>df', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.frames)
    -- end)
    -- vim.keymap.set('n', '<Leader>ds', function()
    --   local widgets = require('dap.ui.widgets')
    --   widgets.centered_float(widgets.scopes)
    -- end)

    --
    --
  },
}
