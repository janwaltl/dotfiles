--Initialize vim-notify plugin for notifications

notify = require('notify')

notify.setup()
--Required
vim.opt.termguicolors = true
--Set as default notification function
vim.notify = notify
