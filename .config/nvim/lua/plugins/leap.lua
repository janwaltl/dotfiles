local function leap_config()
	local leap = require("leap")

	local function set_highlights()
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		vim.api.nvim_set_hl(0, "LeapMatch", {
			fg = "white", -- for light themes, set to 'black' or similar
			bold = true,
			nocombine = true,
		})
	end
	local group = vim.api.nvim_create_augroup("DotfilesLeapHighlights", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", { group = group, callback = set_highlights })
	set_highlights()

	leap.opts.vim_opts["go.ignorecase"] = true
	leap.opts.vim_opts["go.smartcase"] = false
	leap.opts.labels = "sfnjklhodweimbuyvrgtaqpcxz1234567890SFNJKLHODWEIMBUYVRGTAQPCXZ"

	leap.opts.safe_labels = {}
end

return {
	url = "https://codeberg.org/andyg/leap.nvim",
	config = leap_config,
}
