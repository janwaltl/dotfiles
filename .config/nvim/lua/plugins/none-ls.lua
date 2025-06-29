local function none_ls_config()
	local null_ls = require("null-ls")

	null_ls.setup({
		debug = true,
		sources = {
			null_ls.builtins.diagnostics.ansiblelint,
			null_ls.builtins.diagnostics.yamllint,

			-- Markdown
			null_ls.builtins.formatting.mdformat.with({
				-- "Filename is required by null_ls", I also want wrapping to 80.
				args = { "--wrap", "80", "$FILENAME" },
			}),
			-- Spell checking
			null_ls.builtins.diagnostics.codespell.with({
				args = { "--builtin", "clear,rare,code", "-L", "mut,stdio,crate", "-" },
			}),
		},
		on_attach = function(client, bufnr)
			--vim.notify(vim.inspect(client),vim.log.levels.ERROR)
		end,
	})
end

return {
	-- Formatting, linting;
	"nvimtools/none-ls.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = none_ls_config,
}
