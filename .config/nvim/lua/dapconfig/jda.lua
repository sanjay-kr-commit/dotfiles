return function(dap)
  dap.adapters.java = function(callback)
    -- The client_id for the Java LSP server. You might need to adjust this
    -- if you have multiple LSP servers attached or a custom setup.
    -- A robust way is to find the client based on its name.
    local java_lsp_client = nil
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if client.name == "jdtls" then -- Common name for Java LSP server (JDT Language Server)
        java_lsp_client = client
        break
      end
    end

    if not java_lsp_client then
      vim.notify("Java LSP client (jdtls) not found. Make sure it's running.", vim.log.ERROR)
      return
    end

    -- Trigger the 'vscode.java.startDebugSession' LSP command
    java_lsp_client.request("vscode.java.startDebugSession", {}, function(err, result)
      if err then
        vim.notify("Error starting Java debug session: " .. tostring(err), vim.log.ERROR)
        return
      end

      if not result or not result.port then
        vim.notify("vscode.java.startDebugSession did not return a port.", vim.log.ERROR)
        return
      end

      local port = result.port

      -- Call the DAP callback with the received port
      callback({
        type = "server",
        host = "127.0.0.1", -- The debug adapter typically runs locally
        port = port,
      })
    end)
  end

  --dap.adapters.java = function(callback)
  --  -- FIXME:
  --  -- Here a function needs to trigger the `vscode.java.startDebugSession` LSP command
  --  -- The response to the command must be the `port` used below
  --

  --  callback({
  --    type = "server",
  --    host = "127.0.0.1",
  --    port = port,
  --  })
  --end

  dap.configurations.java = {
    {
      type = "java",
      request = "attach",
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005,
    },
  }

  --dap.configurations.java = {
  --  {
  --    -- You need to extend the classPath to list your dependencies.
  --    -- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
  --    classPaths = {},

  --    -- If using multi-module projects, remove otherwise.
  --    projectName = "yourProjectName",

  --    javaExec = "/path/to/your/bin/java",
  --    mainClass = "your.package.name.MainClassName",

  --    -- If using the JDK9+ module system, this needs to be extended
  --    -- `nvim-jdtls` would automatically populate this property
  --    modulePaths = {},
  --    name = "Launch YourClassName",
  --    request = "launch",
  --    type = "java",
  --  },
  --}
end
