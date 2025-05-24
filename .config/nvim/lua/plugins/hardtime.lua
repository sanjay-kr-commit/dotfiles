return {
  "m4xshen/hardtime.nvim",
  lazy = false,
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = {},
  config = function()
    require("hardtime").setup()
  end,
  keys = {
    {
      "<leader>ht",
      ":Hardtime toggle<CR>",
      desc = "Toggle Hardtime",
    },
    {
      "<leader>he",
      ":Hardtime enable<CR>",
      desc = "Enable Hardtime",
    },
    {
      "<leader>hd",
      ":Hardtime disable<CR>",
      desc = "Disable Hardtime",
    },
  },
}
