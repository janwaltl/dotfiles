local lsp_status = require("lsp-status")
local lsp_signature = require("lsp_signature")
local lsp_installer = require("nvim-lsp-installer")

lsp_status.config({
	status_symbol = "",
	indicator_hint = "",
})

local common_on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>CodeActionMenu<CR>", opts)
	buf_set_keymap("v", "<leader>ca", "<cmd>CodeActionMenu<CR>", opts)
	buf_set_keymap("n", "ge", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>', opts)
	buf_set_keymap("n", "g[", '<cmd>lua vim.diagnostic.goto_prev({ float =  { border = "single" }})<CR>', opts)
	buf_set_keymap("n", "g]", '<cmd>lua vim.diagnostic.goto_next({ float =  { border = "single" }})<CR>', opts)

	lsp_status.on_attach(client)
	lsp_signature.on_attach({
		floating_window_above_cur_line = true,
	})
end

-- Credits https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-851247107
-- Make pyright work with virtualenv
local function get_python_venv_path(workspace)
  local util = require('lspconfig/util')
  local path = util.path
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
  end

  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({'*', '.*'}) do
    local match = vim.fn.glob(path.join(workspace, pattern, 'venv'))
    if match ~= '' then
      return path.join(match, 'bin', 'python')
    end
  end

  -- Fallback to system Python.
  return exepath('python3') or exepath('python') or 'python'
end

lsp_installer.on_server_ready(function(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
	local opts = {
		on_attach = common_on_attach,
		capabilities = capabilities,
		before_init = function(_, config)
			local p = get_python_venv_path(config.root_dir)
			config.settings.python.pythonPath = p
		end,
	}

	server:setup(opts)
	vim.cmd([[ do User LspAttach Buffers ]])
end)
