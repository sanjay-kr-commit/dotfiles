return function(dap)
  -- ~/.config/nvim/lua/config/dap.lua

  -- Path to your Java debug adapter installation
  -- Adjust this path based on where you copied the files
  local java_debug_adapter_path = vim.fn.expand("~/.config/nvim/dap/java")

  -- Set up the Java debug adapter
  dap.adapters.java = {
    type = "server",
    port = 8000, -- Choose an available port
    host = "127.0.0.1",
    options = {
      -- Important: This prevents nvim-dap from trying to auto-launch the server
      -- since the VS Code Java Debugger requires specific arguments.
      detached = false,
    },
    executable = {
      command = "java",
      args = {
        "-Declipse.jdt.ls.debug.java.bin=" .. os.getenv("JAVA_HOME") .. "/bin/java", -- Set JAVA_HOME if not already set or provide direct path
        "-jar",
        java_debug_adapter_path .. "/vscode-java-debug.jar",
        -- You might need to adjust the path to the provider JAR if its name changes
        java_debug_adapter_path .. "/com.microsoft.java.debug.provider-*.jar", -- Use glob for provider JAR
      },
      -- Use a specific `cwd` if necessary, e.g., if the debug adapter needs to run from a certain directory
      -- cwd = java_debug_adapter_path,
    },
  }

  -- Set up debug configurations for Java
  dap.configurations.java = {
    {
      type = "java",
      request = "attach", -- Or 'launch' depending on your use case
      name = "Debug (Attach) - Remote",
      hostName = "127.0.0.1",
      port = 5005, -- Default remote debug port for Java
    },
    {
      type = "java",
      request = "launch",
      name = "Debug (Launch) - Current File",
      -- Example for launching the currently open Java file.
      -- You'll likely need to adjust this for complex projects (Maven/Gradle).
      -- For simple files, you can try something like this:
      -- 'mainClass' needs to be the fully qualified name of your main class.
      -- 'classpath' needs to include your compiled classes and dependencies.
      -- For Maven/Gradle projects, it's better to use a tool that generates the launch config.
      mainClass = "${fileBasenameNoExtension}", -- Assumes your main class is in the current file
      -- projectRoot = vim.fn.cwd(), -- Or specific project root
      -- Example classpath: adjust for your project
      -- classpath = {
      --   vim.fn.getcwd() .. '/bin', -- Where your compiled .class files are
      --   -- Add other dependency JARs as needed
      -- },
      -- vmArgs = "",
      -- args = {},
      -- cwd = "${workspaceFolder}", -- Or specific working directory
      -- console = "internalConsole",
      -- stopOnEntry = true,
    },
  }
end
