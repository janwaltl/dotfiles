local function leap_config()
	local leap = require("leap")

	vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
	vim.api.nvim_set_hl(0, "LeapMatch", {
		fg = "white", -- for light themes, set to 'black' or similar
		bold = true,
		nocombine = true,
	})
	leap.opts.highlight_unlabeled_phase_one_targets = true
	leap.opts.case_sensitive = false
	leap.opts.labels = 'sfnjklhodweimbuyvrgtaqpcxz1234567890SFNJKLHODWEIMBUYVRGTAQPCXZ'

	leap.opts.safe_labels = {}
end

return {
	"ggandor/leap.nvim",
	config = leap_config,
}
