return {
	-- Colorscheme
	"morhetz/gruvbox",
	-- See which keys we can press while typing a command
	"folke/which-key.nvim",
	-- Status line
	"hoob3rt/lualine.nvim",
	-- File browser
	"kyazdani42/nvim-tree.lua",
	-- Operate on pairs
	"tpope/vim-surround",
	-- Make . work for plugin commands
	"tpope/vim-repeat",
	-- Integrate git
	"tpope/vim-fugitive",
	-- Easier commenting
	"tpope/vim-commentary",
	-- FZF
	{ "junegunn/fzf", build = "./install --bin" },
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	-- Illuminate symbol usage
	"RRethy/vim-illuminate",
	-- Undotree
	"mbbill/undotree",
	-- Doc generation
	{ "kkoomen/vim-doge", build = ":call doge#install()" },
	-- Gitgutter - work with hunks from VIM
	"airblade/vim-gitgutter",
	-- Fancy icons
	"kyazdani42/nvim-web-devicons",
	-- Easy motion, leap for navigation
	"easymotion/vim-easymotion",
	"ggandor/leap.nvim",
	-- LSP
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
	-- language server settings defined in json for
	"tamago324/nlsp-settings.nvim",
	-- Formatting, linting;
	{ "nvimtools/none-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
	-- AUto pairs
	"windwp/nvim-autopairs",
}
