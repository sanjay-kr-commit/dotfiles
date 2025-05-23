return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
  },
  config = require("dapconfig.nvim-dap-nvim-dap-ui"),

  keys = require("dapconfig.keymap"),
}
