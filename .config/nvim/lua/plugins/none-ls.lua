local function none_ls_config()
	local null_ls = require("null-ls")
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		debug = true,
		sources = {
			--null_ls.builtins.diagnostics.pydocstyle,

			null_ls.builtins.diagnostics.ansiblelint,
			null_ls.builtins.diagnostics.yamllint,

			-- Markdown
			null_ls.builtins.formatting.mdformat.with({
				-- "Filename is required by null_ls", I also want wrapping to 80.
				args = { "--wrap", "80", "$FILENAME" },
			}),

			-- JSON
			--null_ls.builtins.formatting.jq,
			-- Spell checking
			null_ls.builtins.diagnostics.codespell.with({
				args = { "--builtin", "clear,rare,code", "-L", "mut,stdio,crate", "-" },
			}),
		},
		on_attach = function(client, bufnr)
			if client.supports_method("textDocument/formatting") then
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end,
	})
end

return {
	-- Formatting, linting;
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = none_ls_config,
}
