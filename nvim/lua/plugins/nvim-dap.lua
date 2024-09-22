return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"mxsdev/nvim-dap-vscode-js",
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
			-- Javascript     --
			--------------------

			-- configures the VSCode JS debugger adapter.
			require("dap-vscode-js").setup({
				-- set the path to the debugger
				debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
				-- tells adapter which debugging scenarios/modes you want to support then the setup function
				-- creates the necessary configurations for each of these types:
				-- pwa-node: for debugging node.js application;
				-- pwa-chrome: for debugging in chrome browser
				-- node-terminal: for debugging node.js in integrated terminal
				-- pwa-extensionHost: for debugging vscode extensions
				adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
			})

			-- set up debugging configurations for both js and ts
			for _, language in ipairs({ "typescript", "javascript" }) do
				-- launch configuration for node.js. It runs the current file(${file}) in the current workspace folder(${workspaceFolder})
				dap.configurations[language] = {
					{
						type = "pwa-node",
						request = "launch",
						name = "Launch file",
						program = "${file}",
						cwd = "${workspaceFolder}",
					},
					-- 'attach' configuration for node.js, allows you to attach an already running node.js proccess
					{
						type = "pwa-node",
						request = "attach",
						name = "Attach",
						processId = require("dap.utils").pick_process,
						cwd = "${workspaceFolder}",
					},
					-- chrome debugging configuration. launches chrome and navigates to the address
					{
						type = "pwa-chrome",
						request = "launch",
						name = "Start Chrome with WebDebugging",
						url = "http://localhost:3000",
						webRoot = "${workspaceFolder}",
						userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
					},
				}
			end

			--------------------
			-- Python        --
			--------------------
			-- this is a project specific configuration
			-- 1. create a virtual environment in your project dir: `python3 -m venv venv`
			-- 2. activate the virtual environment: `source venv/bin/activate`
			-- 3. install debugpy or other packages `pip install debugpy`
			-- 4. documents all the dependencies: `pip freeze > requirements.txt`
			-- 5. then debug
			local function get_python_path()
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				else
					return "/opt/homebrew/bin/python3" -- fallback to system python
				end
			end

			require("dap-python").setup(get_python_path())

			table.insert(dap.configurations.python, {
				type = "python",
				request = "launch",
				name = "Launch file (debugpy)",
				program = "${file}",
				pythonPath = get_python_path,
				cwd = "${workspaceFolder}",
				env = {
					PYTHONPATH = "${workspaceFolder}",
				},
				justMyCode = false,
				console = "integratedTerminal",
				sourceMaps = true,
				resolveSourceMapLocations = {
					"${workspaceFolder}/**/*.py",
					"!**/site-packages/**",
				},
			})

			--------------------
			-- Rust          --
			--------------------
			--- 1. build the project using 'cargo build' in project dir (build first before debugging)
			--- 2. set breakpoint and continue, select `cargo run` as it ensure your project is up to date
			--- 3. terminate

			-- set up the adapter
			dap.adapters.codelldb = {
				type = "server", -- codelldb runs as a separate server process
				port = "${port}", -- DAP automatically assigns a port
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
						-- debugger looks for executable in target/debug/ (run `cargo build` first)
						-- if prompted, provide the path to your executable `/target/debug/project_name`
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
					-- program tries to automatically find the executable
					program = function()
						-- Get the package name from Cargo.toml
						local cargo_toml = io.open("Cargo.toml", "r")
						local package_name = nil
						-- if found, constructs the path to the debug build
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
							-- if not found, prompt for the path like in 'Launch file'
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
			-- allows debugging of existing executables, complementing the setup_c_cpp_command(),
			-- which build and debug uncompiled code.
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

			-- C++ configuration
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
					-- find the file name and path of the current buffer
					local file_name = vim.fn.expand("%:t:r")
					local file_path = vim.fn.expand("%:p:h")
					-- constructs a compile command with the compiler and c++ standard
					local command = string.format(
						"!cd %s && %s -std=%s -g %s.cpp -o %s",
						file_path,
						compiler_cmd,
						std_version,
						file_name,
						file_name
					)
					-- compiles the program
					vim.cmd(command)

					-- launches the debugger with the compiled program
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
					name = "Debug test", -- configuration for debugging test files
					request = "launch",
					mode = "test",
					program = "${file}",
				},
				-- works with go.mod packages and sub packages
				{
					type = "delve",
					name = "Debug test (go.mod)",
					request = "launch",
					mode = "test",
					program = "./${relativeFileDirname}",
				},
			}
			--
			-- additional debugger configuration goes here
			--
		end, -- end of nvim-dap config (do not delete)
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
		"mxsdev/nvim-dap-vscode-js",
		dependencies = { "mfussenegger/nvim-dap" },
	},
	{
		"microsoft/vscode-js-debug",
		build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
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
