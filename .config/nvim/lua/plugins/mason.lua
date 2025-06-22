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
				ensure_installed = {
					-- Rust
					"rust_analyzer",
					"ruff",
					-- Python
					"basedpyright",
					-- Lua
					"lua_ls",
					-- C++
					"clangd",
				},
			})
		end,
	},
	-- Formatting, linting;
}
