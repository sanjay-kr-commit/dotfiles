return {
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
}
