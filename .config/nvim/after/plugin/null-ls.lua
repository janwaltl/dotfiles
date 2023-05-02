local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.black,
		null_ls.builtins.diagnostics.pydocstyle,

		null_ls.builtins.diagnostics.ansiblelint,
		null_ls.builtins.diagnostics.yamllint,

		-- C/C++
		-- Formatting is handled by clangd language server
		null_ls.builtins.formatting.clang_format,
		-- Markdown
		null_ls.builtins.formatting.mdformat.with({
			-- "Filename is required by null_ls", I also want wrapping to 80.
			args = { "--wrap", "80", "$FILENAME" },
		}),

		-- Rust
		null_ls.builtins.formatting.rustfmt,
		-- Lua
		null_ls.builtins.formatting.stylua,
		-- JSON
		null_ls.builtins.formatting.jq,
		null_ls.builtins.formatting.yamlfmt,

		-- Spell checking
		null_ls.builtins.diagnostics.codespell.with({
			args = { "--builtin", "clear,rare,code", "-L", "mut,stdio", "-" },
		}),
	},
	on_attach = function(client)
		if
			-- The first one reports false positives for null-ls on files without formatters.
			--client.server_capabilities.documentFormattingProvider or
			client.supports_method("textDocument/formatting")
		then
			vim.cmd([[
                augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
                augroup END
                ]])
		end
	end,
})
