--Initialize vim-notify plugin for notifications

notify = require('notify')

notify.setup()
--Required
vim.opt.termguicolors = true
--Set as default notification function
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
