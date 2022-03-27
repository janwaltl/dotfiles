local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.isort,
		null_ls.builtins.diagnostics.pylint,

		null_ls.builtins.diagnostics.ansiblelint,
		null_ls.builtins.diagnostics.yamllint,

		-- C/C++
		-- Formatting is handled by clangd language server
		-- null_ls.builtins.formatting.clang_format,

		-- Lua
		-- cargo install stylua
		-- add ~/.cargo/bin to PATH
		null_ls.builtins.formatting.stylua,

		-- Spell checking
		null_ls.builtins.diagnostics.codespell.with({
			args = { "--builtin", "clear,rare,code", "-" },
		}),
	},
})
