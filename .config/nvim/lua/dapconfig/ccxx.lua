return function(dap)
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
end
