local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = {
		-- Python
		null_ls.builtins.formatting.black,

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

		-- Lua
		null_ls.builtins.formatting.stylua,
		-- JSON
		-- Golang
		null_ls.builtins.formatting.golines,

		-- Spell checking
		null_ls.builtins.diagnostics.codespell.with({
			args = { "--builtin", "clear,rare,code", "-L", "mut,stdio,crate", "-" },
		}),
	},
	on_attach = function(client, bufnr)
		if client.server_capabilities.documentFormattingProvider or client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
                    -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
                    vim.lsp.buf.format({bufnr=bufnr})
                end,
            })
        end
    end,
})
