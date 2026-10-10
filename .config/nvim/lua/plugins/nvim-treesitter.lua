local parsers = {
	"bash",
	"c",
	"cmake",
	"comment",
	"cpp",
	"go",
	"json",
	"lua",
	"make",
	"python",
	"rust",
	"toml",
	"vim",
	"yaml",
}

local highlight_filetypes = {
	"sh",
	"c",
	"cmake",
	"cpp",
	"go",
	"json",
	"lua",
	"make",
	"python",
	"rust",
	"toml",
	"vim",
	"yaml",
}

local indent_filetypes = {
	"sh",
	"c",
	"cmake",
	"cpp",
	"go",
	"json",
	"lua",
	"python",
	"rust",
	"toml",
	"yaml",
}

local function treesitter_config()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({
		-- Keep compatible parsers and queries together, ahead of plugin-bundled parsers.
		install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
	})
	treesitter.install(parsers)

	local group = vim.api.nvim_create_augroup("DotfilesTreeSitter", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = highlight_filetypes,
		callback = function(event)
			vim.treesitter.start(event.buf)
		end,
	})
	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = indent_filetypes,
		callback = function(event)
			vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end,
	})
end

local function textobjects_config()
	require("nvim-treesitter-textobjects").setup({
		select = { lookahead = true },
	})

	local textobjects = {
		["af"] = "@function.outer",
		["if"] = "@function.inner",
		["ac"] = "@class.outer",
		["ic"] = "@class.inner",
		["aa"] = "@parameter.outer",
		["ia"] = "@parameter.inner",
		["ib"] = "@block.inner",
		["ab"] = "@block.outer",
		["ar"] = "@assignment.rhs",
		["al"] = "@assignment.lhs",
	}
	local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject
	for lhs, capture in pairs(textobjects) do
		vim.keymap.set({ "x", "o" }, lhs, function()
			select_textobject(capture, "textobjects")
		end, { desc = "Select " .. capture })
	end
end

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = treesitter_config,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = textobjects_config,
	},
}
