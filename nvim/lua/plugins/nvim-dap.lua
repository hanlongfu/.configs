return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Set up UI
      dapui.setup()

      -- sets up an event listener that autotmatically opens the dapui when a
      -- debugging session is initialized
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      --------------------
      -- Python        --
      --------------------
      require("dap-python").setup("python")
      -- Add configurations for Python
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return vim.fn.exepath("python3")
          end,
        },
        {
          type = "python",
          request = "launch",
          name = "Launch with args",
          program = "${file}",
          args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
          end,
          pythonPath = function()
            return vim.fn.exepath("python3")
          end,
        },
      }

      --------------------
      -- JavaScript    --
      --------------------
      dap.adapters.node = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      dap.configurations.javascript = {
        {
          type = "node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "auto",
          console = "integratedTerminal",
          skipFiles = { "<node_internals>/**" },
        },
        {
          type = "node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          skipFiles = { "<node_internals>/**" },
        },
      }

      dap.configurations.typescript = dap.configurations.javascript
      dap.configurations.javascriptreact = dap.configurations.javascript
      dap.configurations.typescriptreact = dap.configurations.javascript

      --------------------
      -- Rust          --
      --------------------
      --- 1. build the project using 'cargo build' in project dir (build first before debugging)
      --- 2. set breakpoint and continue, select `cargo run` as it ensure your project is up to date
      --- 3. terminate

      -- set up the adapter
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
          args = { "--port", "${port}" },
        },
      }
      -- debug configurations
      dap.configurations.rust = {
        -- launch file configurations
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        -- cargo run configuration
        {
          name = "Cargo run",
          type = "codelldb",
          request = "launch",
          program = function()
            local cargo_toml = io.open("Cargo.toml", "r")
            local package_name = nil
            if cargo_toml then
              for line in cargo_toml:lines() do
                if line:match('^name%s*=%s*"(.+)"') then
                  package_name = line:match('^name%s*=%s*"(.+)"')
                  break
                end
              end
              cargo_toml:close()
            end
            if package_name then
              return vim.fn.getcwd() .. "/target/debug/" .. package_name
            else
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end
          end,
          args = {},
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          runInTerminal = false,
          cargo = {
            args = { "run" },
          },
        },
      }

      --------------------
      -- C/C++         --
      --------------------
      dap.configurations.c = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
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
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      local function setup_c_cpp_commands()
        local function build_and_debug(compiler_cmd, std_version)
          local file_name = vim.fn.expand("%:t:r")
          local file_path = vim.fn.expand("%:p:h")
          local command = string.format(
            "!cd %s && %s -std=%s -g %s.cpp -o %s",
            file_path,
            compiler_cmd,
            std_version,
            file_name,
            file_name
          )
          vim.cmd(command)

          require("dap").run({
            type = "codelldb",
            request = "launch",
            program = file_path .. "/" .. file_name,
            cwd = file_path,
            stopOnEntry = false,
          })
        end

        vim.api.nvim_create_user_command("BuildAndDebugCPP", function()
          build_and_debug("clang++", "c++11")
        end, {})

        vim.api.nvim_create_user_command("BuildAndDebugC", function()
          build_and_debug("clang", "c11")
        end, {})

        vim.api.nvim_create_user_command("BDCPP", function()
          build_and_debug("clang++", "c++11")
        end, {})

        vim.api.nvim_create_user_command("BDC", function()
          build_and_debug("clang", "c11")
        end, {})
      end

      setup_c_cpp_commands()

      --------------------
      -- Go             --
      --------------------
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }

      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug test (go.mod)",
          request = "launch",
          mode = "test",
          program = "./${relativeFileDirname}",
        },
      }
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  {
    "vadimcn/vscode-lldb",
    dependencies = { "mfussenegger/nvim-dap" },
  },
}
