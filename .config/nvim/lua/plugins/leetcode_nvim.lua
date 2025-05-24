return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
  dependencies = {
    "nvim-telescope/telescope.nvim",
    -- "ibhagwan/fzf-lua",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim",
  },
  opts = {
    -- configuration goes here
    ---@type boolean
    image_support = true,
    ---@type lc.lang
    lang = "kotlin",
  },
}
