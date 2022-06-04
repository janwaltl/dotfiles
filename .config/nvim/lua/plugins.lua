local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	-- See which keys we can press while typing a command
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({})
		end,
	})
	-- Insert matching braces, quotes automatically
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	-- Operate on pairs
	use("tpope/vim-surround")
	-- Make . work for plugin commands
	use("tpope/vim-repeat")

	-- Colorscheme
	use("morhetz/gruvbox")
	-- Status line
	use({
		"hoob3rt/lualine.nvim",
		config = function()
			require("lualine").setup({ options = { theme = "wombat" } })
		end,
	})
	-- Integrate git
	use("tpope/vim-fugitive")
	-- Easier commenting
	use("tpope/vim-commentary")
	-- FZF
	use({
		"junegunn/fzf",
		run = "./install --bin",
	})
	use("junegunn/fzf.vim")
	-- Starting dashboard
	use({
		"glepnir/dashboard-nvim",
		config = function()
			require("config.dashboard")
		end,
	})
	use({
		"SirVer/ultisnips",
		requires = { { "honza/vim-snippets", rtp = "." } },
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<tab>"
			vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
			vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
			vim.g.UltiSnipsListSnippets = "<c-s><c-s>"
			vim.g.UltiSnipsRemoveSelectModeMappings = 0
		end,
	})
	-- Completion
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"SirVer/ultisnips",
			"quangnguyen30192/cmp-nvim-ultisnips",
			"honza/vim-snippets",
		},
		config = function()
			require("config.cmp")
		end,
	})
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("config.treesitter")
		end,
	})
	-- File browser
	use({
		"kyazdani42/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				update_focused_file = {
					enable = true,
				},
				view = {
					width = 40,
				},
			})
		end,
	})
	-- Pretty Notifications
	use("rcarriga/nvim-notify")
	-- Show function signature while typing arguments
	use("ray-x/lsp_signature.nvim")
	-- Install LSP servers
	use("williamboman/nvim-lsp-installer")
	-- LSP in status line
	use("nvim-lua/lsp-status.nvim")
	-- language server settings defined in json for
	use("tamago324/nlsp-settings.nvim")
	-- Formatting, linting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("config.formatting")
		end,
	})
	-- LSP
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	})
	-- Gitgutter - work with hunks from VIM
	use("airblade/vim-gitgutter")
	-- Fancy icons
	use("kyazdani42/nvim-web-devicons")
	-- Documentation generation
	use({
		"kkoomen/vim-doge",
		config = function()
			--vim.cmd("call doge#install()")
		end,
	})
	-- Easy motion, navigation
	use("easymotion/vim-easymotion")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
