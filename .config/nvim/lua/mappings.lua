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
-- Close buffer with single keystroke
kmap("n", "q", ":q<CR>", {})
-- Move between splits
kmap("", "<leader>h", "<C-w>h", opts)
kmap("", "<leader>j", "<C-w>j", opts)
kmap("", "<leader>k", "<C-w>k", opts)
kmap("", "<leader>l", "<C-w>l", opts)
-- Move between tabs with gt,gb
kmap("", "gb", "gT", opts)
-- Move between buffers
kmap("n", "[b", ":bprev<CR>", opts)
kmap("n", "]b", ":bnext<CR>", opts)
-- Location list
kmap("n", "<leader>lo", ":botright lopen<CR>", opts)
kmap("n", "<leader>ol", ":windo lclose<CR>", opts)
kmap("n", "[l", ":lprev<CR>", opts)
kmap("n", "]l", ":lnext<CR>", opts)
-- Quickfix list
kmap("n", "<leader>qo", ":botright copen<CR>", opts)
kmap("n", "<leader>oq", ":windo cclose<CR>", opts)
kmap("n", "[q", ":cprev<CR>", opts)
kmap("n", "]q", ":cnext<CR>", opts)
-- Clear highlights
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
-- FZF mappings
kmap("n", "<leader>af", ":Files<CR>", opts) --Search in files.
kmap("n", "<leader>ag", ":GFiles<CR>", opts) --Search in git files.
kmap("n", "<leader>aw", ":Rg<CR>", opts) -- Search via ripgrep for words.
kmap("n", "<leader>as", ":Snippets<CR>", opts) -- Search in snippets.
kmap("n", "<leader>ac", ":Commits<CR>", opts) -- Search in git log.
kmap("n", "<leader>ah", ":History<CR>", opts) -- Search in git history for this file.
kmap("i", "<C-f>p", "<Plug>(fzf-complete-path)") -- Complete path in insert mode.
--- Telescope mappings
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fm", builtin.man_pages, {})
vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
vim.keymap.set("n", "<leader>fl", builtin.loclist, {})
vim.keymap.set("n", "<leader>fc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>fsr", builtin.lsp_references, {})
--vim.keymap.set("n", "<leader>fsd", builtin.lsp_diagnostics, {})

-- Work with hunks
vim.g.gitgutter_map_keys = 0
kmap("n", "[h", ":GitGutterPrevHunk<CR>")
kmap("n", "]h", ":GitGutterNextHunk<CR>")
kmap("n", "<leader>hr", ":GitGutterPreviewHunk<CR>")
kmap("n", "<leader>hs", ":GitGutterStageHunk<CR>")
kmap("n", "<leader>hu", ":GitGutterUndoHunk<CR>")
-- Git fugitive
kmap("n", "<leader>gs", ":Git<CR>")
kmap("n", "<leader>gb", ":Git blame<CR>")
kmap("n", "<leader>gm", ":Git merge<CR>")
kmap("n", "<leader>gl", ":Git log<CR>")
-- File browser
kmap("n", "<leader>t", "<cmd>NvimTreeToggle<cr>")
-- Open manpage in new tab
kmap("n", "<leader>K", "K<C-w>T")
--- Doc generation
vim.g.doge_mapping = "<leader>d"
--- Move around the current tab with easy motion
kmap("n", "f", "<Plug>(easymotion-overwin-f)")
kmap("n", "s", "<Plug>(easymotion-overwin-f2)")
kmap("n", "<leader>w", "<Plug>(easymotion-overwin-w)")
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_use_upper = 1
vim.g.EasyMotion_keys = "ABCDEGHILMNOPQRSTUVWXYZFJK"
--- Notifications log
kmap("n", "<leader>nl", ":Notifications<CR>")
--- LSP code
kmap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
kmap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
kmap("n", "gk", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
kmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
kmap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
kmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
kmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
kmap("n", "<leader>ca", "<cmd>CodeActionMenu<CR>", opts)
kmap("v", "<leader>ca", "<cmd>CodeActionMenu<CR>", opts)
kmap("n", "ge", '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "single" })<CR>', opts)
kmap("n", "[g", '<cmd>lua vim.diagnostic.goto_prev({ float =  { border = "single" }})<CR>', opts)
kmap("n", "]g", '<cmd>lua vim.diagnostic.goto_next({ float =  { border = "single" }})<CR>', opts)
