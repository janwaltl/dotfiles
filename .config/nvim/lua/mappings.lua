-- Key mappings
-- Some extra mappings are in plugin configurations in after/plugin/
--  - nvim-cmp.lua in particular.

--Keyremap function with extra common options
function kmap(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

--------------------------------------------------------------------------------
-- Remap leader to <space>
kmap("", "<Space>", "<Nop>", {})
vim.g.mapleader = " "
vim.g.maplocalleader = " "
--------------------------------------------------------------------------------
-- Better mode switching
kmap("v", ";", ":", {})
kmap("n", ";", ":", {})
kmap("i", "jk", "<ESC>", {})
--------------------------------------------------------------------------------
-- Move in "screen coordinates", useful for wrapped lines.
kmap("n", "j", "gj", {})
kmap("n", "k", "gk", {})
--------------------------------------------------------------------------------
-- Disable exec mode
kmap("n", "Q", ":<CR>", { desc = "Unmap Q" })
-- Record macros with `
kmap("n", "`", "q", { desc = "Record macro" })
--------------------------------------------------------------------------------
-- Close buffer with single keystroke
kmap("n", "q", ":q<CR>", { desc = "Close current buffer" })
--------------------------------------------------------------------------------
-- Move between splits
kmap("", "<leader>h", "<C-w>h", { desc = "Go to left window" })
kmap("", "<leader>j", "<C-w>j", { desc = "Go to down window" })
kmap("", "<leader>k", "<C-w>k", { desc = "Go to up window" })
kmap("", "<leader>l", "<C-w>l", { desc = "Go to right window" })
--------------------------------------------------------------------------------
-- Move between tabs with gt,gb
kmap("", "gb", "gT", { desc = "Previous tab" })
--------------------------------------------------------------------------------
-- Move between buffers
kmap("n", "[b", ":bprev<CR>", { desc = "Previous buffer" })
kmap("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
--------------------------------------------------------------------------------
-- Location list
kmap("n", "<leader>ol", ":botright lopen<CR>", { desc = "Open location list" })
kmap("n", "<leader>c", ":windo lclose | windo cclose<CR>", { desc = "Close quick/loc lists" })
kmap("n", "[l", ":lprev<CR>", { desc = "Previous location item" })
kmap("n", "]l", ":lnext<CR>", { desc = "Next location item" })
--------------------------------------------------------------------------------
-- Quickfix list
kmap("n", "<leader>oq", ":botright copen<CR>", { desc = "Open quickfix list" })
kmap("n", "[q", ":cprev<CR>", { desc = "Go to previous quick item" })
kmap("n", "]q", ":cnext<CR>", { desc = "Go to next quick item" })
--------------------------------------------------------------------------------
-- Clear highlights
kmap("n", "<C-L>", ":nohls<CR>", { desc = "Clear highlights" })
--------------------------------------------------------------------------------
-- Center on search results
kmap("n", "n", "nzz", { desc = "Previous search result" })
kmap("n", "N", "Nzz", { desc = "Next search result" })
--------------------------------------------------------------------------------
-- Move text around
kmap("v", "<C-j>", ":m '>+1<CR>gv=gv", {})
kmap("v", "<C-k>", ":m '<-2<CR>gv=gv", {})
kmap("i", "<C-j>", "<esc>:m .+1<CR>==i", {})
kmap("i", "<C-k>", "<esc>:m .-2<CR>==i", {})
kmap("n", "<C-j>", ":m .+1<CR>==", {})
kmap("n", "<C-k>", ":m .-2<CR>==", {})
--------------------------------------------------------------------------------
-- FZF mappings
kmap("n", "<leader>ff", ":FzfLua files<CR>", { desc = "Search files" })
kmap("n", "<leader>fg", ":FzfLua git_files<CR>", { desc = "Search git files" })
kmap("n", "<leader>fw", ":FzfLua grep_project<CR>", { desc = "Search words" })
kmap("n", "<leader>fc", ":FzfLua git_commits<CR>", { desc = "Search git log" })
kmap("n", "<leader>fh", ":FzfLua oldfiles<CR>", { desc = "Search recently opened files" })
kmap("n", "<leader>fl", ":FzfLua lines<CR>", { desc = "Search lines in open files" })
kmap("n", "<leader>fb", ":FzfLua buffers<CR>", { desc = "Fuzzy buffers" })
kmap("n", "<leader>ft", ":FzfLua tabs<CR>", { desc = "Search tabs" })
kmap("n", "<leader>fm", ":FzfLua man_pages<CR>", { desc = "Fuzzy manpages" })
kmap("n", "<leader>fs", ":FzfLua lsp_workspace_symbols<CR>", { desc = "Fuzzy symbols" })
kmap("n", "<leader>fr", ":FzfLua resume<CR>", { desc = "Resume last fzf search" })

--------------------------------------------------------------------------------
-- Work with hunks
function hunk_quicklist()
	vim.cmd(":GitGutterQuickFix")
	require("fzf-lua").quickfix()
end
kmap("n", "[h", ":GitGutterPrevHunk<CR>", { desc = "Previous hunk" })
kmap("n", "]h", ":GitGutterNextHunk<CR>", { desc = "Next hunk" })
kmap("n", "<leader>hr", ":GitGutterPreviewHunk<CR>", { desc = "Preview hunk" })
kmap("n", "<leader>hs", ":GitGutterStageHunk<CR>", { desc = "Stage hunk" })
kmap("n", "<leader>hu", ":GitGutterUndoHunk<CR>", { desc = "Undu hunk" })
kmap("n", "<leader>hl", hunk_quicklist, { desc = "List hunks" })
kmap("o", "ih", "<Plug>(GitGutterTextObjectInnerPending)", { desc = "Select in hunk" })
kmap("o", "ah", "<Plug>(GitGutterTextObjectOuterPending)", { desc = "Select around hunk" })
kmap("x", "ih", "<Plug>(GitGutterTextObjectInnerVisual)", { desc = "Select in hunk" })
kmap("x", "ah", "<Plug>(GitGutterTextObjectOuterVisual)", { desc = "Select around hunk" })
--------------------------------------------------------------------------------
-- Git fugitive
kmap("n", "<leader>gs", ":Git<CR><C-w>T", { desc = "Git status (new tab)" })
kmap("n", "<leader>gb", ":Git blame<CR>", { desc = "Git blame (side)" })
kmap("n", "<leader>gm", ":Git merge<CR>", { desc = "Git merge" })
kmap("n", "<leader>gl", ":Gllog<CR>", { desc = "Git log" })
--------------------------------------------------------------------------------
-- File browser
kmap("n", "<leader>t", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file explorer" })
--------------------------------------------------------------------------------
-- Open manpage in new tab
kmap("n", "<leader>K", "K<C-w>T", { desc = "Open manpage in new tab" })
--------------------------------------------------------------------------------
-- Doc generation
vim.g.doge_mapping = "<leader>d"
--------------------------------------------------------------------------------
-- Move around the current tab with leap and easy motion
function leap_search()
	leap.leap({
		target_windows = vim.tbl_filter(function(win)
			return vim.api.nvim_win_get_config(win).focusable
		end, vim.api.nvim_tabpage_list_wins(0)),
	})
end
kmap("n", "s", leap_search, { desc = "Leap on 2 characters" })
kmap("n", ",f", "<Plug>(easymotion-overwin-f)", { desc = "Search 1 characters" })
kmap("n", ",s", "<Plug>(easymotion-overwin-f2)", { desc = "Search 2 characters" })
kmap("n", ",w", "<Plug>(easymotion-overwin-w)", { desc = "Search words" })
vim.g.EasyMotion_smartcase = 1
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_use_upper = 1
vim.g.EasyMotion_keys = "ABCDEGHILMNOPQRSTUVWXYZFJK"
--------------------------------------------------------------------------------
-- Notifications log
kmap("n", "<leader>nl", ":Notifications<CR>", { desc = "List notifications" })
--------------------------------------------------------------------------------
-- LSP code navigation
kmap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
kmap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
kmap("n", "gk", vim.lsp.buf.hover, { desc = "Hover symbol" })
kmap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
kmap("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type definition" })
kmap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
kmap("n", "gr", ":FzfLua lsp_references<CR>", { desc = "List symbol references" })
kmap("n", "gc", ":FzfLua lsp_incoming_calls<CR>", { desc = "List symbol references" })
kmap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
kmap("n", "ge", function()
	vim.diagnostic.open_float(0, { scope = "line", border = "single" })
end, { desc = "Diagnostic under cursor" })
kmap("n", "[g", function()
	vim.diagnostic.goto_prev({ float = { border = "single" } })
end, { desc = "Previous diagnostic" })
kmap("n", "]g", function()
	vim.diagnostic.goto_next({ float = { border = "single" } })
end, { desc = "Next diagnostic" })
kmap("n", "gl", ":FzfLua lsp_workspace_diagnostics<CR>", { desc = "List all diagnostics" })
--------------------------------------------------------------------------------
-- Debugging
local dap = require("dap")
local dapui = require("dapui")

kmap("n", "<leader>dt", function()
	dapui.toggle()
end, { desc = "Toggle Debug UI" })
kmap("n", "<Leader>dr", function()
	dap.run_last()
end, { desc = "Run last debug session" })
kmap("n", "<leader>db", function()
	dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })
kmap("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set conditional breakpoint" })
kmap("n", "<leader>do", function()
	dap.step_out()
end, { desc = "Step out" })
kmap("n", "<leader>di", function()
	dap.step_into()
end, { desc = "Step into" })
kmap("n", "<leader>dn", function()
	dap.step_over()
end, { desc = "Step over" })
kmap("n", "<leader>dc", function()
	dap.continue()
end, { desc = "Continue" })
kmap("n", "<leader>dk", function()
	dap.run_to_cursor()
end, { desc = "Run to cursor" })
kmap("n", "<leader>du", function()
	dap.up()
end, { desc = "Frame up" })
kmap("n", "<leader>dd", function()
	dap.down()
end, { desc = "Frame down" })
kmap("n", "<leader>de", function()
	dap.terminate()
end, { desc = "Terminate debug session" })
kmap({ "n", "v" }, "<Leader>dh", function()
	require("dap.ui.widgets").hover()
end, { desc = "Hover symbol" })
kmap("n", "<leader>dlf", ":FzfLua dap_frames<CR>", { desc = "List DAP frames" })
kmap("n", "<leader>dlv", ":FzfLua dap_variables<CR>", { desc = "List DAP variables" })
kmap("n", "<leader>dlb", ":FzfLua dap_breakpoints<CR>", { desc = "List DAP breakpoints" })
--------------------------------------------------------------------------------
-- Undo tree
kmap("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Undo tree" })
