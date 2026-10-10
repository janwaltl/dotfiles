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
	local formatting_method = vim.lsp.protocol.Methods.textDocument_formatting
	local format_group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = format_group,
		desc = "Format with an attached LSP client before saving",
		callback = function(event)
			local clients = vim.lsp.get_clients({ bufnr = event.buf })
			table.sort(clients, function(a, b)
				return a.id < b.id
			end)
			for _, client in ipairs(clients) do
				if client:supports_method(formatting_method, event.buf) then
					-- Use one provider only; lowest client ID is the earliest attached formatter.
					vim.lsp.buf.format({
						bufnr = event.buf,
						filter = function(format_client)
							return format_client.id == client.id
						end,
					})
					return
				end
			end
		end,
	})

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
		settings = {
			basedpyright = {
				analysis = {
					typeCheckingMode = "standard"
				}
			}
		}
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
