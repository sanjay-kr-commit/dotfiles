return function(dap)
  -- Setup for java-debug-adapter (ensure it's installed via Mason)
  -- Mason typically installs binaries in a predictable path that nvim-dap can often find,
  -- or you might need to specify the path if it's not automatically detected.

  -- Get the path to the java-debug-adapter executable installed by Mason
  local java_debug_path = vim.fn.stdpath("data")
    .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.1.jar"
  local java_test_path = vim.fn.stdpath("data")
    .. "/mason/packages/java-test/extension/server/com.microsoft.java.test.plugin-0.53.1.jar" -- If you use java-test as well

  dap.adapters.java = function(callback, config)
    -- The config table contains information about the project, passed from the dap.configurations
    -- config.cwd will be the root of your Java project
    local an
    OS = vim.loop.os_uname().sysname
    local java_executable = "java" -- or the full path to your java executable if not in PATH
    local classpath_separator = (os == "Windows_NT") and ";" or ":" -- ; for Windows, : for Linux/MacOS

    -- Determine the project's classpath. This is a crucial step.
    -- jdtls usually provides this information.
    -- You might need to call a jdtls command or use a helper function
    -- to get the classpath for the current project.
    -- For simplicity, this example assumes you might have a way to get it or
    -- that the debugger can infer it if your project is simple (e.g., Maven/Gradle).

    -- A more robust way would be to query jdtls for the classpath.
    -- Example using a hypothetical jdtls command (you'll need to adapt this):
    -- local classpath = vim.fn.system('jdtls --classpath ' .. vim.fn.shellescape(config.cwd))
    -- For now, we'll let the debugger try to figure it out or you might need to set it manually in configurations.

    callback({
      type = "executable",
      command = java_executable,
      args = {
        "-jar",
        java_debug_path,
        -- You might need to add other arguments or system properties here
        -- For example, if your java-debug-adapter needs the java-test extension:
        -- '-Djava.debug.settings.javaTestServerPort=YOUR_JAVA_TEST_SERVER_PORT', -- if using java-test
      },
      -- Note: For older versions of java-debug-adapter, you might have launched it differently
      -- e.g., by pointing to a launch script. The -jar method is common for recent versions.
    })
  end

  -- Configurations for Java projects
  dap.configurations.java = {
    {
      type = "java", -- This must match the adapter name defined above
      request = "launch",
      name = "Launch Main Class",
      mainClass = "", -- Important: You'll often want to set this dynamically or prompt for it
      projectName = "", -- Optional: jdtls might use this
      -- vmArgs = '', -- e.g., "-Xmx512m"
      -- args = '', -- Program arguments
      -- classPaths = { 'path/to/your/project/classes', 'path/to/libs/*' }, -- Explicitly set if needed
      -- modulePaths = {}, -- For Java 9+ modules
      -- stopOnEntry = false,
      -- console = 'internalConsole', -- or 'integratedTerminal', 'externalTerminal'
    },
    {
      type = "java",
      request = "attach",
      name = "Attach to Remote Java Process",
      hostName = "localhost",
      port = 0, -- Set the debug port of the remote JVM
      -- processId = function() return vim.fn.input('PID to attach to: ') end, -- Alternative to host/port
    },
    -- You can add more configurations, e.g., for running tests
  }

  ---- Get the path to the java-debug-adapter executable installed by Mason
  --local java_debug_path = vim.fn.stdpath("data")
  --  .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin.jar"
  --local java_test_path = vim.fn.stdpath("data")
  --  .. "/mason/packages/java-test/extension/server/com.microsoft.java.test.plugin.jar" -- If you use java-test as well

  -- -- ~/.config/nvim/lua/config/dap.lua

  -- -- Path to your Java debug adapter installation
  -- -- Adjust this path based on where you copied the files
  -- local java_debug_adapter_path = vim.fn.expand("~/.config/nvim/dap/java")

  -- -- Set up the Java debug adapter
  -- dap.adapters.java = {
  --   type = "server",
  --   port = 8000, -- Choose an available port
  --   host = "127.0.0.1",
  --   options = {
  --     -- Important: This prevents nvim-dap from trying to auto-launch the server
  --     -- since the VS Code Java Debugger requires specific arguments.
  --     detached = false,
  --   },
  --   executable = {
  --     command = "java",
  --     args = {
  --       "-Declipse.jdt.ls.debug.java.bin=" .. os.getenv("JAVA_HOME") .. "/bin/java", -- Set JAVA_HOME if not already set or provide direct path
  --       "-jar",
  --       java_debug_adapter_path .. "/vscode-java-debug.jar",
  --       -- You might need to adjust the path to the provider JAR if its name changes
  --       java_debug_adapter_path .. "/com.microsoft.java.debug.provider-*.jar", -- Use glob for provider JAR
  --     },
  --     -- Use a specific `cwd` if necessary, e.g., if the debug adapter needs to run from a certain directory
  --     -- cwd = java_debug_adapter_path,
  --   },
  -- }

  -- -- Set up debug configurations for Java
  -- dap.configurations.java = {
  --   {
  --     type = "java",
  --     request = "attach", -- Or 'launch' depending on your use case
  --     name = "Debug (Attach) - Remote",
  --     hostName = "127.0.0.1",
  --     port = 5005, -- Default remote debug port for Java
  --   },
  --   {
  --     type = "java",
  --     request = "launch",
  --     name = "Debug (Launch) - Current File",
  --     -- Example for launching the currently open Java file.
  --     -- You'll likely need to adjust this for complex projects (Maven/Gradle).
  --     -- For simple files, you can try something like this:
  --     -- 'mainClass' needs to be the fully qualified name of your main class.
  --     -- 'classpath' needs to include your compiled classes and dependencies.
  --     -- For Maven/Gradle projects, it's better to use a tool that generates the launch config.
  --     mainClass = "${fileBasenameNoExtension}", -- Assumes your main class is in the current file
  --     -- projectRoot = vim.fn.cwd(), -- Or specific project root
  --     -- Example classpath: adjust for your project
  --     -- classpath = {
  --     --   vim.fn.getcwd() .. '/bin', -- Where your compiled .class files are
  --     --   -- Add other dependency JARs as needed
  --     -- },
  --     -- vmArgs = "",
  --     -- args = {},
  --     -- cwd = "${workspaceFolder}", -- Or specific working directory
  --     -- console = "internalConsole",
  --     -- stopOnEntry = true,
  --   },
  -- }
end
