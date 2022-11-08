local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.pylint.with({ prefer_local = "venv/bin" }),
		null_ls.builtins.diagnostics.pydocstyle,

		null_ls.builtins.diagnostics.ansiblelint,
		null_ls.builtins.diagnostics.yamllint,

		-- C/C++
		-- Formatting is handled by clangd language server
		-- null_ls.builtins.formatting.clang_format,

		-- Rust
		null_ls.builtins.formatting.rustfmt,
		-- Lua
		null_ls.builtins.formatting.stylua,

		-- Spell checking
		null_ls.builtins.diagnostics.codespell.with({
			args = { "--builtin", "clear,rare,code", "-" },
		}),
	},
	on_attach = function(client)
		if client.server_capabilities.documentFormattingProvider then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
		end
	end,
})
