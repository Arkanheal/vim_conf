local dap = require("dap")

require("dapui").setup({})
require("nvim-dap-virtual-text").setup({})

require("dap-go").setup({
	delve = {
		initialize_timeout_sec = 20,
	},
})
require("dap-vscode-js").setup({
	-- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
	-- debugger_path = "(runtimedir)/site/pack/packer/opt/vscode-js-debug", -- Path to vscode-js-debug installation.
	-- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
	-- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
	-- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
	-- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
})

-- vim.keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
-- vim.keymap.set("n", "<F1>", ":lua require'dap'.step_into()<CR>")
-- vim.keymap.set("n", "<F2>", ":lua require'dap'.step_over()<CR>")
-- vim.keymap.set("n", "<F3>", ":lua require'dap'.step_out()<CR>")
-- vim.keymap.set("n", "<F6>", ":lua require'dap-go'.debug_test()<CR>")
vim.keymap.set("n", "<leader>dac", ":lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>das", ":lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>dao", ":lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>dap", ":lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>dat", ":lua require'dap-go'.debug_test()<CR>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
vim.keymap.set("n", "<leader>lp", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Logpoint message: '))<CR>")
vim.keymap.set("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>bui", ":lua require'dapui'.open()<CR>")

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = os.getenv("HOME") .. "/.local/share/dap/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },

		-- On windows you may have to uncomment this:
		-- detached = false,
	},
}

for _, language in ipairs({ "typescript", "javascript" }) do
	dap.configurations[language] = {
		{
			type = "pwa-node",
			request = "launch",
			name = "Debug Jest Tests",
			-- trace = true, -- include debugger info
			runtimeExecutable = "node",
			runtimeArgs = {
				"./node_modules/jest/bin/jest.js",
				"--runInBand",
			},
			rootPath = "${workspaceFolder}",
			cwd = "${workspaceFolder}",
			console = "integratedTerminal",
			internalConsoleOptions = "neverOpen",
		},
	}
end

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
