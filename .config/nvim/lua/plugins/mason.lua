local ensure_installed = {
	-- Rust
	"rust_analyzer",
	"ruff",
	"basedpyright",
	-- Lua
	"lua_ls",
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
			require("mason").setup()

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
		},
		config = function()
			local mason_lspconfig = require("mason-lspconfig")
			local registry = require("mason-registry")

			-- Collect all LSP servers
			local lsps = {}
			for _, tool in ipairs(ensure_installed) do
				if registry.has_package(tool) then
					local t = registry.get_package(tool)
					for _, value in ipairs(t.spec.categories) do
						if value == "LSP" then
							table.insert(lsps, tool)
						end
					end
				end
			end
			mason_lspconfig.setup({
				ensure_installed = lsps
			})
		end,
	},
	-- Formatting, linting;
}
