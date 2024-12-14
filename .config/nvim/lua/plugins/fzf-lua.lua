local function fzf_lua_config()
	local fzf_lua = require("fzf-lua")
	fzf_lua.setup({
		winopts = {
			fullscreen = true,
			on_create = function()
				-- Close window with 'q'
				vim.api.nvim_buf_set_keymap(0, "t", "<leader>q", "<ESC>", { silent = true, noremap = true })
			end,
		},
		previewers = {
			man = {
				cmd = "man  %s | col -bx",
			},
		},
	})
end

return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = fzf_lua_config,
}
