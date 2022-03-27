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
kmap("n", "<Leader>ds", "<cmd>SessionSave<CR>", opts)
kmap("n", "<Leader>dl", "<cmd>SessionLoad<CR>", opts)
kmap("n", "<leader>df", ":DashboardFindFile<CR>", opts)
kmap("n", "<leader>dw", ":DashboardFindWord<CR>", opts)
kmap("n", "<leader>dh", ":DashboardFindHistory<CR>", opts)
