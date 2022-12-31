local options = {
	autoindent = true, -- Indentation
	autoread = true, -- Automatically relaod files from disk
	backspace = "indent,eol,start", --
	belloff = all, -- No bells
	bg = dark, -- Dark background
	breakindent = true, -- Wrapped lines are indented
	clipboard = { "unnamed", "unnamedplus" }, -- Use system clipboard
	colorcolumn = "80,120", -- Highlight columns
	completeopt = { "menuone", "noselect" }, --
	conceallevel = 0, --
	cursorline = true, -- Highlight current line
	hidden = true, -- Allow hidden buffers
	hlsearch = true, -- Highlight search results
	incsearch = true, -- Start search immedietelly
	ignorecase = true, --
	mouse = "a", -- Enable mouse
	relativenumber = true, -- Relative line numbering
	number = true, -- Number lines
	ruler = true, --
	scrolloff = 10, -- Start scrolling earlier
	shiftwidth = 4, --
	showbreak = "+++", -- Denote wrapped lines
	showmatch = true, -- Highlight matching braces
	smartindent = true, --
	smartcase = true, -- Smart case for searching
	splitbelow = true, -- Split below current window
	splitright = true, -- Split to the right
	swapfile = false, -- No .swap
	tabstop = 4, -- 4 spaces per tab
	termguicolors = true, -- Correct colors
	timeoutlen = 300, -- 300ms which-key trigger
	undodir = os.getenv("HOME") .. "/undodir", -- Global persistent undodir
	undofile = true, -- Persistent undo
	updatetime = 300, -- 300ms for cmd completion
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.number = true
vim.opt.relativenumber = true

-- Doge docstring format
vim.g.doge_doc_standard_python = "numpy"
vim.g.doge_enable_mappings = 1
vim.g.doge_doc_standard_cpp = "doxygen_javadoc_banner"
-- Folder for snippets
vim.cmd([[
let g:UltiSnipsSnippetDirectories = ["UltiSnips", "my_snippets"]
]])

vim.g.c_syntax_for_h = 1
vim.api.nvim_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
