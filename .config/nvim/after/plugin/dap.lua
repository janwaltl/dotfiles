local dap = require("dap")
local dapui = require("dapui")
local dapvtext = require("nvim-dap-virtual-text")

dapui.setup()
dapvtext.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

dap.set_log_level("TRACE")

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "OpenDebugAD7",
}

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = { "--port", "${port}" },
	},
}
dap.configurations.cpp = {
	{
		name = "Launch file[GDB]",
		type = "cppdbg",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		args = function()
			s = vim.fn.input("Arguments: ")
			return vim.fn.split(s, " ", true)
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = false,
			},
		},
	},
	{
		name = "Launch file[LLDB]",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		args = function()
			s = vim.fn.input("Arguments: ")
			return vim.fn.split(s, " ", true)
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = false,
	},
}

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointRejected", { text = "🟦", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "->", texthl = "", linehl = "", numhl = "" })

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
