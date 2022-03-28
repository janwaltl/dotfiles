function kmap(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--Remap leader to <space>
local opts = { noremap = true, silent = true }
kmap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- Better mode switching
kmap("v", ";", ":", {})
kmap("n", ";", ":", {})
kmap("i", "jk", "<ESC>", {})
-- Move in "screen coordinates", useful for wrapped lines.
kmap("n", "j", "gj", opts)
kmap("n", "k", "gk", opts)
-- Disable exec mode, run macros instead
kmap("n", "Q", "@q", opts)
-- Move between splits
kmap("", "<leader>h", "<C-w>h", opts)
kmap("", "<leader>j", "<C-w>j", opts)
kmap("", "<leader>k", "<C-w>k", opts)
kmap("", "<leader>l", "<C-w>l", opts)
-- Move between tabs with gt,gb
kmap("", "gb", "gT", opts)
-- Move between buffers
kmap("", "<leader>]", ":bnext<CR>", opts)
kmap("", "<leader>[", ":bprev<CR>", opts)
kmap("n", "<C-L>", ":nohls<CR>", opts)
-- Center on search results
kmap("n", "n", "nzz", opts)
kmap("n", "N", "Nzz", opts)
-- Move text around
kmap("v", "<C-j>", ":m '>+1<CR>gv=gv", opts)
kmap("v", "<C-k>", ":m '<-2<CR>gv=gv", opts)
kmap("i", "<C-j>", "<esc>:m .+1<CR>==i", opts)
kmap("i", "<C-k>", "<esc>:m .-2<CR>==i", opts)
kmap("n", "<C-j>", ":m .+1<CR>==", opts)
kmap("n", "<C-k>", ":m .-2<CR>==", opts)
-- Dashboard mappings
kmap("n", "<Leader>fs", "<cmd>SessionSave<CR>", opts)
kmap("n", "<Leader>fl", "<cmd>SessionLoad<CR>", opts)
kmap("n", "<leader>ff", ":DashboardFindFile<CR>", opts)
kmap("n", "<leader>fw", ":DashboardFindWord<CR>", opts)
kmap("n", "<leader>fh", ":DashboardFindHistory<CR>", opts)
-- Work with hunks
vim.g.gitgutter_map_keys = 0
kmap("n", "<leader>hp", ":GitGutterPrevHunk<CR>")
kmap("n", "<leader>hn", ":GitGutterNextHunk<CR>")
kmap("n", "<leader>hr", ":GitGutterPreviewHunk<CR>")
kmap("n", "<leader>hs", ":GitGutterStageHunk<CR>")
kmap("n", "<leader>hu", ":GitGutterUndoHunk<CR>")
-- File browser
kmap("n", "<leader>t", "<cmd>NvimTreeToggle<cr>")
--- Doc generation
vim.g.doge_mapping = "<leader>d"
