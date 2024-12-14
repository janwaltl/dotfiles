local common_on_attach = function(client, bufnr)
	require("lsp-status").on_attach(client)
	-- Enable inlay hints
	if client.server_capabilities.inlayHintProvider or
		client.server_capabilities.clangdInlayHintsProvider then
		vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
	end
	if client.supports_method("textDocument/formatting") or true then
		vim.cmd([[
			augroup LspFormatting
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
			augroup END
			]])
	end
end

local function get_python_venv_path(root_dir)
	local util = require("lspconfig/util")
	local path = util.path
	-- Use activated virtualenv.
	if vim.env.VIRTUAL_ENV then
		return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
	end

	for _, venv in ipairs({ "venv", ".venv" }) do
		local venv_python = path.join(root_dir, venv, "bin", "python")
		local f = vim.loop.fs_stat(venv_python)
		if f and f.type == 'file' then
			return venv_python
		end
	end

	-- Fallback to system Python.
	return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local function lspstatus_config()
	local lsp_status = require("lsp-status")
	lsp_status.config({
		status_symbol = "",
		indicator_hint = "",
	})
end

local function lspconfig_config()
	local lsp_config = require("lspconfig")
	local lsp_status = require("lsp-status")

	lsp_config.clangd.setup({
		handlers = lsp_status.extensions.clangd.setup(),
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
		},
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
	})

	lsp_config.rust_analyzer.setup({
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
	})

	lsp_config.lua_ls.setup({
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
	})
	local py_root_files = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"pyrightconfig.json",
		"venv",
		".venv",
	}

	lsp_config.basedpyright.setup({
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
		-- Override pyright root_dir generation
		-- I also want to recognize project via venv,.venv dirs
		root_dir = function(fname)
			local util = require("lspconfig/util")
			return util.root_pattern(unpack(py_root_files))(fname)
		end,
		before_init = function(_, config)
			config.settings.python = { pythonPath = get_python_venv_path(config.root_dir) }
		end,
	})

	lsp_config.ruff.setup({
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
		root_dir = function(fname)
			local util = require("lspconfig/util")
			return util.root_pattern(unpack(py_root_files))(fname)
		end,
	})

	lsp_config.gopls.setup({})
end

-- Source of diagnostics messages
vim.diagnostic.config({
	virtual_text = { prefix = "●" },
	severity_sort = true,
	float = { source = "always" },
})

return {
	{
		"neovim/nvim-lspconfig",
		config = lspconfig_config,
	},
	{
		"nvim-lua/lsp-status.nvim",
		config = lspstatus_config,
	},
}
