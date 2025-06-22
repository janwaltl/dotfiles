-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Neovim options
require("options")

-- Start lazy.nvim
require("lazy").setup("plugins", {
	change_detection = {
		enabled = false,
		notify = false,
	},
	checker = {
		enabled = false,
	},
})

require("mappings")
require("colorscheme")
require("utils")
