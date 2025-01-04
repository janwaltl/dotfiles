local common_on_attach = function(client, bufnr)
	local lsp_status = require("lsp-status")
	lsp_status.on_attach(client)
	local kmap = require("utils").kmap
	local methods = vim.lsp.protocol.Methods
	if client:supports_method(methods.textDocument_inlayHint) or client.server_capabilities.clangdInlayHintsProvider then
		-- Toggle inlay hints
		kmap("n", '<leader>lh', function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bunr = bufnr }), { bunr = bufnr })
		end, { desc = "Toggle inlay hints" })
		kmap("n", '<leader>ld', function()
				vim.diagnostic.enable(not vim.diagnostic.is_enabled())
			end,
			{ desc = "Toggle diagnostics" })
	end
	if client:supports_method(methods.textDocument_formatting) then
		local group = vim.api.nvim_create_augroup("AutoFormatting", { clear = true })
		local format_buff = function() vim.lsp.buf.format({ bufnr = bufnr }) end
		vim.api.nvim_create_autocmd("BufWritePre", { callback = format_buff, group = group, desc = "", buffer = bufnr })
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
		local f = vim.uv.fs_stat(venv_python)
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
	local lsp_status = require("lsp-status")

	--------------------CPP--------------------
	vim.lsp.config('clangd', {
		handlers = lsp_status.extensions.clangd.setup(),
		cmd = {
			"clangd",
			"--background-index",
			"--clang-tidy",
			"--header-insertion=iwyu",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"--fallback-style=llvm",
			"--query-driver=/**/*"
		},
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		},
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
	})

	--------------------RUST-------------------
	vim.lsp.config('rust_analyzer', {
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
	})


	--------------------LUA--------------------
	vim.lsp.config('lua_ls', {
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
		settings = {
			Lua = {
				runtime = {
					version = 'LuaJIT',
				},
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME
					}
				}
			}
		}
	})
	--------------------PYTHON-----------------
	vim.lsp.config('basedpyright', {
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
		-- I also want to recognize project via venv,.venv dirs
		root_markers = { ".venv", "venv" },
		before_init = function(_, config)
			config.settings.python = { pythonPath = get_python_venv_path(config.root_dir) }
		end,
	})
	vim.lsp.config('ruff', {
		on_attach = common_on_attach,
		capabilities = lsp_status.capabilities,
	})


	vim.lsp.config('gopls', {})
end

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
