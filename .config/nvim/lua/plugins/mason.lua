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
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				ensure_installed = { "rust_analyzer", "ruff_lsp" },
			})
		end,
	},
	-- Formatting, linting;
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					"jq",
					"black",
					"pydocstyle",
					"ansiblelint",
					"yamllint",
					"clang_format",
					"yamlfmt",
					--"rustfmt",
				},
				automatic_installation = true,
			})
		end,
	},
}
