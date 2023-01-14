require("nvim-treesitter.configs").setup({
	ensure_installed = {
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
	},

	indent = { enable = true },
	highlight = { enable = true, additional_vim_regex_highlighting = false },
	autopairs = { enable = true },
	rainbow = { enable = false },
	textobjects = {
		select = {
			enable = true,
			-- Automatically jump forward to textobj, similar to targets.vim
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["ib"] = "@block.inner",
				["ab"] = "@block.outer",
			},
		},
		swap = { enable = false },
	},
})
