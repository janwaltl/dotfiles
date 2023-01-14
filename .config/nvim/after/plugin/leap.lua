leap = require("leap")

vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
vim.api.nvim_set_hl(0, "LeapMatch", {
	fg = "white", -- for light themes, set to 'black' or similar
	bold = true,
	nocombine = true,
})
require("leap").opts.highlight_unlabeled_phase_one_targets = true

leap.opts.safe_labels = {}
