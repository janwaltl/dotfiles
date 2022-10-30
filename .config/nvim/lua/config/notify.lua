--Initialize vim-notify plugin for notifications

--Required
vim.opt.termguicolors = true
--Set as default notification function
vim.notify = require("notify")
