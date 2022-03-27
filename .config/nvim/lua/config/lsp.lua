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

lsp_installer.on_server_ready(function(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
	local opts = {
		on_attach = common_on_attach,
		capabilities = capabilities,
	}

	server:setup(opts)
	vim.cmd([[ do User LspAttach Buffers ]])
end)
