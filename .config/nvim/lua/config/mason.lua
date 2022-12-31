local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local lsp_config = require("lspconfig")
local lsp_status = require("lsp-status")
local lsp_signature = require("lsp_signature")

mason.setup()
mason_lspconfig.setup({
	ensure_installed = { "clangd", "pyright", "rust_analyzer" },
})

lsp_status.config({
	status_symbol = "",
	indicator_hint = "",
})

local common_on_attach = function(client, bufnr)
	lsp_status.on_attach(client)
	lsp_signature.on_attach({ floating_window_above_cur_line = true })
end
local function get_python_venv_path(workspace)
	local util = require("lspconfig/util")
	local path = util.path
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	-- Find and use virtualenv in workspace directory.
	for _, pattern in ipairs({ "*", ".*" }) do
		local match = vim.fn.glob(path.join(workspace, pattern, "venv"))
		if match ~= "" then
			return path.join(match, "bin", "python")
		end
	end

	-- Fallback to system Python.
	return exepath("python3") or exepath("python") or "python"
end

lsp_config.clangd.setup({
	handlers = lsp_status.extensions.clangd.setup(),
	init_options = {
		clangdFileStatus = true,
	},
	on_attach = common_on_attach,
	capabilities = lsp_status.capabilities,
})

lsp_config.rust_analyzer.setup({
	on_attach = common_on_attach,
	capabilities = lsp_status.capabilities,
})

lsp_config.pyright.setup({
	on_attach = common_on_attach,
	capabilities = lsp_status.capabilities,
	before_init = function(_, config)
		config.settings.python.pythonPath = get_python_venv_path(config.root_dir)
	end,
})

-- Source of diagnostics messages
vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	severity_sort = true,
	float = { source = "always" },
})
