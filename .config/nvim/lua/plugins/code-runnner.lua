return {
  "CRAG666/code_runner.nvim",
  keys = {
    {
      "<leader>r",
      ":RunCode<CR>",
      desc = "Run current file",
    },
  },
  config = function()
    require("code_runner").setup({
      mode = "better_term",
      better_term = {
        number = 1,
      },
      filetype = {
        java = function()
          require("config.java-code-runner")()
        end,
        lua = {
          "cd $dir &&",
          "lua $fileName",
        },
        kotlin = {
          "cd $dir &&",
          "echo compiling code &&",
          "kotlinc $fileName &&",
          "clear && echo cleaning up &&",
          "rm -r META-INF &&",
          "clear &&",
          "kotlin \"$(echo $fileName | sed 's/.*/\\u&/' | sed 's/\\.\\s*\\([a-z]\\)/\\.\\u\\1/g' | sed 's/\\.//g' )\"",
        },
        python = "python3 -u",
        typescript = "deno run",
        rust = {
          "cd $dir &&",
          "rustc $fileName &&",
          "$dir/$fileNameWithoutExt",
        },
        c = function(...)
          c_base = {
            "cd $dir &&",
            "gcc $fileName -o",
            "/tmp/$fileNameWithoutExt",
          }
          local c_exec = {
            "&& /tmp/$fileNameWithoutExt &&",
            "rm /tmp/$fileNameWithoutExt",
          }
          vim.ui.input({ prompt = "Add more args:" }, function(input)
            c_base[4] = input
            vim.print(vim.tbl_extend("force", c_base, c_exec))
            require("code_runner.commands").run_from_fn(vim.list_extend(c_base, c_exec))
          end)
        end,
      },
    })
  end,
}
