return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = { "rust_analyzer", "ruff_lsp",
					"basedpyright",
					"lua_ls",
					--"clangd"
				},
			})
		end,
	},
	-- Formatting, linting;
}
