require("nvim-treesitter.configs").setup({
	ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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
