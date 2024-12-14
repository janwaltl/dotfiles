-- File browser
local function nvim_tree_config()
	require("nvim-tree").setup({
		update_focused_file = {
			enable = true,
		},
		view = {
			width = 40,
		},
	})
end

return {
	"kyazdani42/nvim-tree.lua",
	config = nvim_tree_config,
}
