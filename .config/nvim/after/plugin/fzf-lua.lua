fzf_lua = require("fzf-lua")

fzf_lua.setup({
	winopts = {
		fullscreen = true,
		on_create = function()
			-- Close window with 'q'
			vim.api.nvim_buf_set_keymap(0, "t", "q", "<ESC>", { silent = true, noremap = true })
		end,
	},
	previewers = {
		man = {
			cmd = "man  %s | col -bx",
		},
	},
})
