return {
  "jay-babu/mason-nvim-dap.nvim",
  config = function()
    local masonnvimdap = require("mason-nvim-dap")
    masonnvimdap.setup({
      automatic_installation = true,
    })
  end,
}
