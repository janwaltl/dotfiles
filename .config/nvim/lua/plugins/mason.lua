local ensure_installed = {
	-- Rust
	"rust-analyzer",
	"ruff",
	"basedpyright",
	-- Lua
	"lua-language-server",
	"stylua",
	-- C++
	"clangd",
	-- YAML,
	"yamlfmt",
	"yamllint",
	-- Misc,
	"codespell",
}

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				-- Prefer Mason binaries; commands absent from Mason can resolve via PATH.
				PATH = "prepend",
			})

			local registry = require("mason-registry")
			for _, tool in ipairs(ensure_installed) do
				if registry.has_package(tool) then
					local t = registry.get_package(tool)
					if not t:is_installed() then
						t:install()
					end
				end
			end
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			-- Mason above owns installation; mason-lspconfig enables installed servers.
			require("mason-lspconfig").setup()
		end,
	},
	-- Formatting, linting;
}
